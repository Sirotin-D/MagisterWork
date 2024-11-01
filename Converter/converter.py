import os
import coremltools as ct
import torchsummary
import torch.jit
import torch.nn as nn
import nn_models_loader


model_author = "Dmitry Sirotin"
model_short_description = "CNN model trained on Food-101 dataset"
model_version = "1,0"
model_licence = "UNN"
mobileNet_model_name = "MobileNet"
denseNet_model_name = "DenseNet"


def convert_torch_model_to_coreml(model: nn.Module, package_name: str):
    classifier_config = ct.ClassifierConfig('class_labels/food101_class_labels.txt')
    dummy_input = torch.rand(1, 3, 224, 224)
    traced_model = torch.jit.trace(model, dummy_input)
    input_image = ct.ImageType(name="image", shape=(1, 3, 224, 224), scale=1 / 255)
    coreml_model = ct.convert(
        traced_model,
        inputs=[input_image],
        convert_to="neuralnetwork",
        classifier_config=classifier_config,
        minimum_deployment_target=ct.target.iOS13
    )
    coreml_model.author = model_author
    coreml_model.short_description = model_short_description
    coreml_model.version = model_version
    coreml_model.license = model_licence

    coreml_model.save(os.path.join(f'ml_models/{package_name}.mlmodel'))


def print_architecture(model: nn.Module, input_size=(3, 224, 224)):
    print(model)
    torchsummary.summary(model, input_size=input_size)


if __name__ == "__main__":
    mobile_net_model = nn_models_loader.get_mobilenet_v2_model()
    print_architecture(mobile_net_model)
    convert_torch_model_to_coreml(mobile_net_model, mobileNet_model_name)
    dense_net_model = nn_models_loader.get_densenet_model()
    print_architecture(dense_net_model)
    convert_torch_model_to_coreml(dense_net_model, denseNet_model_name)
