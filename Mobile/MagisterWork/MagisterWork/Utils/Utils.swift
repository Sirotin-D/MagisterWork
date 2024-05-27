//
//  Utils.swift
//

import CoreML

class Utils {
    static func getCurrentNetworkMetadata() async -> NeuralNetworkMetadataModel {
        let imageClassifierDescription = ImagePredictor.shared.getCurrentClassififerDescription()
        let networkModelDescription = imageClassifierDescription.modelDescription
        let modelName = imageClassifierDescription.modelType.rawValue
        let modelMetaData = imageClassifierDescription.modelDescription.metadata
        var modelDescription = ""
        var modelClassLabels = [NeuralNetworkClassLabel]()
        let metaDataKey = MLModelMetadataKey.description
        if let description = modelMetaData[metaDataKey] as? String {
            modelDescription = description
        }
        if let classLabels = networkModelDescription.classLabels as? [String] {
            modelClassLabels = classLabels.map { classLabel in
                NeuralNetworkClassLabel(name: classLabel)
            }
        }
        return NeuralNetworkMetadataModel(name: modelName, description: modelDescription, classLabels: modelClassLabels)
    }
    
    static func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
    
    static func getFoodObject(for classLabel: String) -> FoodObject? {
        let formattedFoodName = classLabel.replacingOccurrences(of: "_", with: " ")
        let foodName = formattedFoodName.prefix(1).uppercased() + formattedFoodName.dropFirst()
        var foodObject: FoodObject? = nil
        for product in FoodObject.allCases {
            if foodName == product.getValue() {
                foodObject = product
                break
            }
        }
        return foodObject
    }
    
    static func getFoodMetadata(for foodObject: FoodObject) -> ProductMetadataModel? {
        var mockMetadata: ProductMetadataModel?
        switch foodObject {
        case .ApplePie:
            mockMetadata = MockFoodDescription.applePieMetadata
        case .BabyBackRibs:
            mockMetadata = MockFoodDescription.babyBackRibsMetadata
        case .Baklava:
            mockMetadata = MockFoodDescription.baklavaMetadata
        case .BeefCarpaccio:
            mockMetadata = MockFoodDescription.beefCarpatioMetadata
        case .BeefTartare:
            mockMetadata = MockFoodDescription.beefTartareMetadata
        case .BeetSalad:
            mockMetadata = MockFoodDescription.beet_saladMetadata
        case .Beignets:
            mockMetadata = MockFoodDescription.beignetsMetadata
        case .Bibimbap:
            mockMetadata = MockFoodDescription.bibimbapMetadata
        case .BreadPudding:
            mockMetadata = MockFoodDescription.bread_puddingMetadata
        case .BreakfastBurrito:
            mockMetadata = MockFoodDescription.breakfast_burritoMetadata
        case .Bruschetta:
            mockMetadata = MockFoodDescription.bruschettaMetadata
        case .CaesarSalad:
            mockMetadata = MockFoodDescription.caesar_saladMetadata
        case .Cannoli:
            mockMetadata = MockFoodDescription.cannoliMetadata
        case .CapreseSalad:
            mockMetadata = MockFoodDescription.caprese_saladMetadata
        case .CarrotCake:
            mockMetadata = MockFoodDescription.carrot_cakeMetadata
        case .Ceviche:
            mockMetadata = MockFoodDescription.cevicheMetadata
        case .Cheesecake:
            mockMetadata = MockFoodDescription.cheesecakeMetadata
        case .CheesePlate:
            mockMetadata = MockFoodDescription.cheese_plateMetadata
        case .ChickenCurry:
            mockMetadata = MockFoodDescription.chicken_curryMetadata
        case .ChickenQuesadilla:
            mockMetadata = MockFoodDescription.chicken_quesadillaMetadata
        case .ChickenWings:
            mockMetadata = MockFoodDescription.chicken_wingsMetadata
        case .ChocolateCake:
            mockMetadata = MockFoodDescription.chocolate_cakeMetadata
        case .ChocolateMousse:
            mockMetadata = MockFoodDescription.chocolate_mousseMetadata
        case .Churros:
            mockMetadata = MockFoodDescription.churrosMetadata
        case .ClamChowder:
            mockMetadata = MockFoodDescription.clam_chowderMetadata
        case .ClubSandwich:
            mockMetadata = MockFoodDescription.club_sandwichMetadata
        case .CrabCakes:
            mockMetadata = MockFoodDescription.crab_cakesMetadata
        case .CremeBrulee:
            mockMetadata = MockFoodDescription.creme_bruleeMetadata
        case .CroqueMadame:
            mockMetadata = MockFoodDescription.croque_madameMetadata
        case .CupCakes:
            mockMetadata = MockFoodDescription.cup_cakesMetadata
        case .DeviledEggs:
            mockMetadata = MockFoodDescription.deviled_eggsMetadata
        case .Donuts:
            mockMetadata = MockFoodDescription.donutsMetadata
        case .Dumplings:
            mockMetadata = MockFoodDescription.dumplingsMetadata
        case .Edamame:
            mockMetadata = MockFoodDescription.edamameMetadata
        case .EggsBenedict:
            mockMetadata = MockFoodDescription.eggs_benedictMetadata
        case .Escargots:
            mockMetadata = MockFoodDescription.escargotsMetadata
        case .Falafel:
            mockMetadata = MockFoodDescription.falafelMetadata
        case .FiletMignon:
            mockMetadata = MockFoodDescription.filet_mignonMetadata
        case .FishAndChips:
            mockMetadata = MockFoodDescription.fish_and_chipsMetadata
        case .FoieGras:
            mockMetadata = MockFoodDescription.foie_grasMetadata
        case .FrenchFries:
            mockMetadata = MockFoodDescription.french_friesMetadata
        case .FrenchOnionSoup:
            mockMetadata = MockFoodDescription.french_onion_soupMetadata
        case .FrenchToast:
            mockMetadata = MockFoodDescription.french_toastMetadata
        case .FriedCalamari:
            mockMetadata = MockFoodDescription.fried_calamariMetadata
        case .FriedRice:
            mockMetadata = MockFoodDescription.fried_riceMetadata
        case .FrozenYogurt:
            mockMetadata = MockFoodDescription.frozen_yogurtMetadata
        case .GarlicBread:
            mockMetadata = MockFoodDescription.garlic_breadMetadata
        case .Gnocchi:
            mockMetadata = MockFoodDescription.gnocchiMetadata
        case .GreekSalad:
            mockMetadata = MockFoodDescription.greek_saladMetadata
        case .GrilledCheeseSandwich:
            mockMetadata = MockFoodDescription.grilled_cheese_sandwichMetadata
        case .GrilledSalmon:
            mockMetadata = MockFoodDescription.grilled_salmonMetadata
        case .Guacamole:
            mockMetadata = MockFoodDescription.guacamoleMetadata
        case .Gyoza:
            mockMetadata = MockFoodDescription.gyozaMetadata
        case .Hamburger:
            mockMetadata = MockFoodDescription.hamburgerMetadata
        case .HotAndSourSoup:
            mockMetadata = MockFoodDescription.hot_and_sovur_soupMetadata
        case .HotDog:
            mockMetadata = MockFoodDescription.hot_dogMetadata
        case .HuevosRancheros:
            mockMetadata = MockFoodDescription.huevos_rancherosMetadata
        case .Hummus:
            mockMetadata = MockFoodDescription.hummusMetadata
        case .IceCream:
            mockMetadata = MockFoodDescription.ice_creamMetadata
        case .Lasagna:
            mockMetadata = MockFoodDescription.lasagnaMetadata
        case .LobsterBisque:
            mockMetadata = MockFoodDescription.lobster_bisqueMetadata
        case .LobsterRollSandwich:
            mockMetadata = MockFoodDescription.lobster_roll_sandwichMetadata
        case .MacaroniAndCheese:
            mockMetadata = MockFoodDescription.macaroni_and_cheeseMetadata
        case .Macarons:
            mockMetadata = MockFoodDescription.macaronsMetadata
        case .MisoSoup:
            mockMetadata = MockFoodDescription.miso_soupMetadata
        case .Mussels:
            mockMetadata = MockFoodDescription.musselsMetadata
        case .Nachos:
            mockMetadata = MockFoodDescription.nachosMetadata
        case .Omelette:
            mockMetadata = MockFoodDescription.omeletteMetadata
        case .OnionRings:
            mockMetadata = MockFoodDescription.onion_ringsMetadata
        case .Oysters:
            mockMetadata = MockFoodDescription.oystersMetadata
        case .PadThai:
            mockMetadata = MockFoodDescription.pad_thaiMetadata
        case .Paella:
            mockMetadata = MockFoodDescription.paellaMetadata
        case .Pancakes:
            mockMetadata = MockFoodDescription.pancakeMetadata
        case .PannaCotta:
            mockMetadata = MockFoodDescription.panna_cottaMetadata
        case .PekingDuck:
            mockMetadata = MockFoodDescription.peking_duckMetadata
        case .Pho:
            mockMetadata = MockFoodDescription.phoMetadata
        case .Pizza:
            mockMetadata = MockFoodDescription.pizzaMetadata
        case .PorkChop:
            mockMetadata = MockFoodDescription.pork_chopMetadata
        case .Poutine:
            mockMetadata = MockFoodDescription.poutineMetadata
        case .PrimeRib:
            mockMetadata = MockFoodDescription.prime_ribMetadata
        case .PulledPorkSandwich:
            mockMetadata = MockFoodDescription.pulled_pork_sandwichMetadata
        case .Ramen:
            mockMetadata = MockFoodDescription.ramenMetadata
        case .Ravioli:
            mockMetadata = MockFoodDescription.ravioliMetadata
        case .RedVelvetCake:
            mockMetadata = MockFoodDescription.red_velvet_cakeMetadata
        case .Risotto:
            mockMetadata = MockFoodDescription.risottoMetadata
        case .Samosa:
            mockMetadata = MockFoodDescription.samosaMetadata
        case .Sashimi:
            mockMetadata = MockFoodDescription.sashimiMetadata
        case .Scallops:
            mockMetadata = MockFoodDescription.scallopsMetadata
        case .SeaweedSalad:
            mockMetadata = MockFoodDescription.seaweed_saladMetadata
        case .ShrimpAndGrits:
            mockMetadata = MockFoodDescription.shrimp_and_gritsMetadata
        case .SpaghettiBolognese:
            mockMetadata = MockFoodDescription.spaghetti_bologneseMetadata
        case .SpaghettiCarbonara:
            mockMetadata = MockFoodDescription.spaghetti_carbonaraMetadata
        case .SpringRolls:
            mockMetadata = MockFoodDescription.spring_rollsMetadata
        case .Steak:
            mockMetadata = MockFoodDescription.steakMetadata
        case .StrawberryShortCake:
            mockMetadata = MockFoodDescription.strawberry_shortcakeMetadata
        case .Sushi:
            mockMetadata = MockFoodDescription.sushiMetadata
        case .Tacos:
            mockMetadata = MockFoodDescription.tacosMetadata
        case .Takoyaki:
            mockMetadata = MockFoodDescription.takoyakiMetadata
        case .Tiramisu:
            mockMetadata = MockFoodDescription.tiramisuMetadata
        case .TunaTartare:
            mockMetadata = MockFoodDescription.tuna_tartareMetadata
        case .Waffles:
            mockMetadata = MockFoodDescription.wafflesMetadata
        }
        
        return mockMetadata
    }
}
