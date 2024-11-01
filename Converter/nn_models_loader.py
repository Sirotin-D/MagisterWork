import torch
import torch.nn as nn
from torchvision.models import DenseNet, densenet201, MobileNetV2


def get_densenet_model() -> DenseNet:
    file_path = 'model_checkpoints/DenseNet.pth'
    model = densenet201()
    model.eval()
    classifier = nn.Sequential(
        nn.Linear(1920, 1024),
        nn.LeakyReLU(),
        nn.Linear(1024, 101),
        nn.Softmax(dim=1)
    )
    model.classifier = classifier
    model.load_state_dict(torch.load(file_path, map_location='cpu'), strict=False)
    return model


def get_mobilenet_v2_model() -> MobileNetV2:
    file_path = 'model_checkpoints/MobileNet.pth'
    model = MobileNetV2(num_classes=101)
    model.eval()
    checkpoint = torch.load(file_path, map_location='cpu')
    weights = {key.replace('module.', ''): value for (key, value) in checkpoint['state_dict'].items()}
    model.load_state_dict(weights, strict=False)
    classifier = nn.Sequential(
        nn.Dropout(p=0.2, inplace=False),
        nn.Linear(in_features=1280, out_features=101),
        nn.Softmax(dim=1)
    )
    model.classifier = classifier

    return model
