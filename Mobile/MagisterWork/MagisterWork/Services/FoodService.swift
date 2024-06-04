//
//  FoodService.swift
//

import Foundation

protocol IFoodService {
    func fetchFoodDescription(foodName: String) async -> FoodDescriptionModel?
    func getMockFoodDescription(foodName: String) -> ProductMetadataModel?
    static func getFoodObject(for classLabel: String) -> FoodObject?
}

class FoodService: IFoodService {
    private let kLogTag = "FoodService"
    private let nutritionApiUrl = "https://api.api-ninjas.com/v1/nutrition?query="
    
    func fetchFoodDescription(foodName: String) async -> FoodDescriptionModel? {
        if GlobalSettings.shared.isXcodePreview {
            return FoodDescriptionModel.getMockData()
        }
        
        var nutritionFactsResponseModel: FoodDescriptionModel?
        let formattedUrl = nutritionApiUrl + foodName
        guard let url = URL(string: formattedUrl) else {return nil}
        var request = URLRequest(url: url)
        let nutritionApiKey = KeyConstants.APIKeys.nutritionAPIKey
        request.setValue(nutritionApiKey, forHTTPHeaderField: "X-Api-Key")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedModel = try JSONDecoder().decode([FoodDescriptionModel].self, from: data)
            if !decodedModel.isEmpty {
                nutritionFactsResponseModel = decodedModel.first
            }
        } catch {
            Logger.shared.e(kLogTag, "Error: \(error)")
        }
        
        return nutritionFactsResponseModel
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
    
    func getMockFoodDescription(foodName: String) -> ProductMetadataModel? {
        guard let foodObject = FoodService.getFoodObject(for: foodName) else {return nil}
        var mockFoodNutrition: ProductMetadataModel?
        switch foodObject {
        case .ApplePie:
            mockFoodNutrition = MockFoodDescription.applePieMetadata
        case .BabyBackRibs:
            mockFoodNutrition = MockFoodDescription.babyBackRibsMetadata
        case .Baklava:
            mockFoodNutrition = MockFoodDescription.baklavaMetadata
        case .BeefCarpaccio:
            mockFoodNutrition = MockFoodDescription.beefCarpatioMetadata
        case .BeefTartare:
            mockFoodNutrition = MockFoodDescription.beefTartareMetadata
        case .BeetSalad:
            mockFoodNutrition = MockFoodDescription.beet_saladMetadata
        case .Beignets:
            mockFoodNutrition = MockFoodDescription.beignetsMetadata
        case .Bibimbap:
            mockFoodNutrition = MockFoodDescription.bibimbapMetadata
        case .BreadPudding:
            mockFoodNutrition = MockFoodDescription.bread_puddingMetadata
        case .BreakfastBurrito:
            mockFoodNutrition = MockFoodDescription.breakfast_burritoMetadata
        case .Bruschetta:
            mockFoodNutrition = MockFoodDescription.bruschettaMetadata
        case .CaesarSalad:
            mockFoodNutrition = MockFoodDescription.caesar_saladMetadata
        case .Cannoli:
            mockFoodNutrition = MockFoodDescription.cannoliMetadata
        case .CapreseSalad:
            mockFoodNutrition = MockFoodDescription.caprese_saladMetadata
        case .CarrotCake:
            mockFoodNutrition = MockFoodDescription.carrot_cakeMetadata
        case .Ceviche:
            mockFoodNutrition = MockFoodDescription.cevicheMetadata
        case .Cheesecake:
            mockFoodNutrition = MockFoodDescription.cheesecakeMetadata
        case .CheesePlate:
            mockFoodNutrition = MockFoodDescription.cheese_plateMetadata
        case .ChickenCurry:
            mockFoodNutrition = MockFoodDescription.chicken_curryMetadata
        case .ChickenQuesadilla:
            mockFoodNutrition = MockFoodDescription.chicken_quesadillaMetadata
        case .ChickenWings:
            mockFoodNutrition = MockFoodDescription.chicken_wingsMetadata
        case .ChocolateCake:
            mockFoodNutrition = MockFoodDescription.chocolate_cakeMetadata
        case .ChocolateMousse:
            mockFoodNutrition = MockFoodDescription.chocolate_mousseMetadata
        case .Churros:
            mockFoodNutrition = MockFoodDescription.churrosMetadata
        case .ClamChowder:
            mockFoodNutrition = MockFoodDescription.clam_chowderMetadata
        case .ClubSandwich:
            mockFoodNutrition = MockFoodDescription.club_sandwichMetadata
        case .CrabCakes:
            mockFoodNutrition = MockFoodDescription.crab_cakesMetadata
        case .CremeBrulee:
            mockFoodNutrition = MockFoodDescription.creme_bruleeMetadata
        case .CroqueMadame:
            mockFoodNutrition = MockFoodDescription.croque_madameMetadata
        case .CupCakes:
            mockFoodNutrition = MockFoodDescription.cup_cakesMetadata
        case .DeviledEggs:
            mockFoodNutrition = MockFoodDescription.deviled_eggsMetadata
        case .Donuts:
            mockFoodNutrition = MockFoodDescription.donutsMetadata
        case .Dumplings:
            mockFoodNutrition = MockFoodDescription.dumplingsMetadata
        case .Edamame:
            mockFoodNutrition = MockFoodDescription.edamameMetadata
        case .EggsBenedict:
            mockFoodNutrition = MockFoodDescription.eggs_benedictMetadata
        case .Escargots:
            mockFoodNutrition = MockFoodDescription.escargotsMetadata
        case .Falafel:
            mockFoodNutrition = MockFoodDescription.falafelMetadata
        case .FiletMignon:
            mockFoodNutrition = MockFoodDescription.filet_mignonMetadata
        case .FishAndChips:
            mockFoodNutrition = MockFoodDescription.fish_and_chipsMetadata
        case .FoieGras:
            mockFoodNutrition = MockFoodDescription.foie_grasMetadata
        case .FrenchFries:
            mockFoodNutrition = MockFoodDescription.french_friesMetadata
        case .FrenchOnionSoup:
            mockFoodNutrition = MockFoodDescription.french_onion_soupMetadata
        case .FrenchToast:
            mockFoodNutrition = MockFoodDescription.french_toastMetadata
        case .FriedCalamari:
            mockFoodNutrition = MockFoodDescription.fried_calamariMetadata
        case .FriedRice:
            mockFoodNutrition = MockFoodDescription.fried_riceMetadata
        case .FrozenYogurt:
            mockFoodNutrition = MockFoodDescription.frozen_yogurtMetadata
        case .GarlicBread:
            mockFoodNutrition = MockFoodDescription.garlic_breadMetadata
        case .Gnocchi:
            mockFoodNutrition = MockFoodDescription.gnocchiMetadata
        case .GreekSalad:
            mockFoodNutrition = MockFoodDescription.greek_saladMetadata
        case .GrilledCheeseSandwich:
            mockFoodNutrition = MockFoodDescription.grilled_cheese_sandwichMetadata
        case .GrilledSalmon:
            mockFoodNutrition = MockFoodDescription.grilled_salmonMetadata
        case .Guacamole:
            mockFoodNutrition = MockFoodDescription.guacamoleMetadata
        case .Gyoza:
            mockFoodNutrition = MockFoodDescription.gyozaMetadata
        case .Hamburger:
            mockFoodNutrition = MockFoodDescription.hamburgerMetadata
        case .HotAndSourSoup:
            mockFoodNutrition = MockFoodDescription.hot_and_sovur_soupMetadata
        case .HotDog:
            mockFoodNutrition = MockFoodDescription.hot_dogMetadata
        case .HuevosRancheros:
            mockFoodNutrition = MockFoodDescription.huevos_rancherosMetadata
        case .Hummus:
            mockFoodNutrition = MockFoodDescription.hummusMetadata
        case .IceCream:
            mockFoodNutrition = MockFoodDescription.ice_creamMetadata
        case .Lasagna:
            mockFoodNutrition = MockFoodDescription.lasagnaMetadata
        case .LobsterBisque:
            mockFoodNutrition = MockFoodDescription.lobster_bisqueMetadata
        case .LobsterRollSandwich:
            mockFoodNutrition = MockFoodDescription.lobster_roll_sandwichMetadata
        case .MacaroniAndCheese:
            mockFoodNutrition = MockFoodDescription.macaroni_and_cheeseMetadata
        case .Macarons:
            mockFoodNutrition = MockFoodDescription.macaronsMetadata
        case .MisoSoup:
            mockFoodNutrition = MockFoodDescription.miso_soupMetadata
        case .Mussels:
            mockFoodNutrition = MockFoodDescription.musselsMetadata
        case .Nachos:
            mockFoodNutrition = MockFoodDescription.nachosMetadata
        case .Omelette:
            mockFoodNutrition = MockFoodDescription.omeletteMetadata
        case .OnionRings:
            mockFoodNutrition = MockFoodDescription.onion_ringsMetadata
        case .Oysters:
            mockFoodNutrition = MockFoodDescription.oystersMetadata
        case .PadThai:
            mockFoodNutrition = MockFoodDescription.pad_thaiMetadata
        case .Paella:
            mockFoodNutrition = MockFoodDescription.paellaMetadata
        case .Pancakes:
            mockFoodNutrition = MockFoodDescription.pancakeMetadata
        case .PannaCotta:
            mockFoodNutrition = MockFoodDescription.panna_cottaMetadata
        case .PekingDuck:
            mockFoodNutrition = MockFoodDescription.peking_duckMetadata
        case .Pho:
            mockFoodNutrition = MockFoodDescription.phoMetadata
        case .Pizza:
            mockFoodNutrition = MockFoodDescription.pizzaMetadata
        case .PorkChop:
            mockFoodNutrition = MockFoodDescription.pork_chopMetadata
        case .Poutine:
            mockFoodNutrition = MockFoodDescription.poutineMetadata
        case .PrimeRib:
            mockFoodNutrition = MockFoodDescription.prime_ribMetadata
        case .PulledPorkSandwich:
            mockFoodNutrition = MockFoodDescription.pulled_pork_sandwichMetadata
        case .Ramen:
            mockFoodNutrition = MockFoodDescription.ramenMetadata
        case .Ravioli:
            mockFoodNutrition = MockFoodDescription.ravioliMetadata
        case .RedVelvetCake:
            mockFoodNutrition = MockFoodDescription.red_velvet_cakeMetadata
        case .Risotto:
            mockFoodNutrition = MockFoodDescription.risottoMetadata
        case .Samosa:
            mockFoodNutrition = MockFoodDescription.samosaMetadata
        case .Sashimi:
            mockFoodNutrition = MockFoodDescription.sashimiMetadata
        case .Scallops:
            mockFoodNutrition = MockFoodDescription.scallopsMetadata
        case .SeaweedSalad:
            mockFoodNutrition = MockFoodDescription.seaweed_saladMetadata
        case .ShrimpAndGrits:
            mockFoodNutrition = MockFoodDescription.shrimp_and_gritsMetadata
        case .SpaghettiBolognese:
            mockFoodNutrition = MockFoodDescription.spaghetti_bologneseMetadata
        case .SpaghettiCarbonara:
            mockFoodNutrition = MockFoodDescription.spaghetti_carbonaraMetadata
        case .SpringRolls:
            mockFoodNutrition = MockFoodDescription.spring_rollsMetadata
        case .Steak:
            mockFoodNutrition = MockFoodDescription.steakMetadata
        case .StrawberryShortCake:
            mockFoodNutrition = MockFoodDescription.strawberry_shortcakeMetadata
        case .Sushi:
            mockFoodNutrition = MockFoodDescription.sushiMetadata
        case .Tacos:
            mockFoodNutrition = MockFoodDescription.tacosMetadata
        case .Takoyaki:
            mockFoodNutrition = MockFoodDescription.takoyakiMetadata
        case .Tiramisu:
            mockFoodNutrition = MockFoodDescription.tiramisuMetadata
        case .TunaTartare:
            mockFoodNutrition = MockFoodDescription.tuna_tartareMetadata
        case .Waffles:
            mockFoodNutrition = MockFoodDescription.wafflesMetadata
        }
        
        return mockFoodNutrition
    }
}
