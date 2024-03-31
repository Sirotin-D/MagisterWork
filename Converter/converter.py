import torch
import coremltools


def download_deit_base_model():
    return torch.hub.load('facebookresearch/deit:main', 'deit_base_patch16_224', pretrained=True)


def download_mobilenet_model():
    return torch.hub.load('pytorch/vision:v0.10.0', 'mobilenet', pretrained=True)


def convert_model_to_coreml(model, package_name):
    dummy_input = torch.rand(1, 3, 32, 32)
    # Трассировка модели
    traced_model = torch.jit.trace(model, dummy_input)
    # Создание типа входного изображения
    input_image = coremltools.ImageType(name="my_input", shape=(1, 3, 32, 32), scale=1 / 255)
    # Конвертация модели в CoreML
    coreml_model = coremltools.convert(traced_model, inputs=[input_image])
    # Изменtybt названия вывода на "class_label" в спецификации
    spec = coreml_model.get_spec()
    coremltools.utils.rename_feature(spec, "81", "class_label")
    # Повторное создание модели на основе обновлённой спецификации
    coreml_model_updated = coremltools.models.MLModel(spec)
    # Сохранение CoreML модели
    coreml_model_updated.save(f'{package_name}.mlpackage')


if __name__ == "__main__":
    deit_model = download_deit_base_model()
    mobilenet_model = download_mobilenet_model()
    convert_model_to_coreml(deit_model, "Deit-base384")
    convert_model_to_coreml(mobilenet_model, "MobileNet")
