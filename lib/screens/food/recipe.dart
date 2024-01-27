import 'commons.dart';
import './breakfast.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
    {
      'path': 'assets/images/recipe1.jpeg',
      'title': 'Banana Berry Acai Bowl',
      'ingredients': '''
          Banana
          Mixed Berries
          Acai Puree
          Greek Yogurt 
          Honey
          ''',
      'recipe': '''
        1. Blend all ingredients until smooth.
        2. Pour into a bowl.
        3. Add toppings of your choice.
      ''',
    },
    {
      'path': 'assets/images/recipe2.jpeg',
      'title': 'Smoothie Bowl',
      'ingredients': '''
        Your choice of fruits
        Greek Yogurt
        Honey
        Granola
          ''',
      'recipe': '''
        1. Blend fruits, Greek Yogurt, and Honey until smooth.
        2. Pour into a bowl.
        3. Sprinkle with granola.
      ''',
    },
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato',
      'ingredients': '''
      Avocado
       Bread 
       Tomato
       Salt
       Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Add sliced tomato.
        4. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast',
      'ingredients': '''
       Avocado
        Bread
         Lime 
         juice
          Cilantro
           Salt 
           Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Squeeze lime juice over the avocado.
        4. Sprinkle with chopped cilantro.
        5. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe5.jpeg',
      'title': 'Chocolate Chip Banana Pancakes',
      'ingredients': '''
Banana 
Pancake
 mix 
 Chocolate 
 chips 
 Milk ''',
      'recipe': '''
        1. Mash banana and mix with pancake mix and milk.
        2. Stir in chocolate chips.
        3. Cook pancakes on a hot griddle.
      ''',
    },
    {
      'path': 'assets/images/recipe6.jpeg',
      'title': 'Fruit Salad',
      'ingredients': '''
       Assorted
        fruits 
        (e.g., apples, oranges, grapes)
        ''',
      'recipe': '''
        1. Wash and chop fruits into bite-sized pieces.
        2. Combine in a bowl.
        3. Serve chilled.
      ''',
    },
    {
      'path': 'assets/images/recipe7.jpeg',
      'title': 'Egg Breakfast Bowl',
      'ingredients': '''
Eggs
Spinach 
Tomato
 Cheese 
 Salt 
 Pepper
''',
      'recipe': '''
        1. Scramble eggs and cook with spinach, tomatoes, and cheese.
        2. Season with salt and pepper.
        3. Serve hot in a bowl.
      ''',
    },
    {
      'path': 'assets/images/recipe9.jpeg',
      'title': 'Yogurt Parfait',
      'ingredients': '''
      Greek yogurt
       Granola
        Mixed berries
         Honey
      ''',
      'recipe': '''
        1. Layer Greek yogurt, granola, and mixed berries in a glass.
        2. Drizzle with honey.
        3. Repeat the layers.
      ''',
    },
    {
      'path': 'assets/images/recipe1.jpeg',
      'title': 'Banana Berry Acai Bowl',
      'ingredients': '''
          Banana
          Mixed Berries
          Acai Puree
          Greek Yogurt 
          Honey
          ''',
      'recipe': '''
        1. Blend all ingredients until smooth.
        2. Pour into a bowl.
        3. Add toppings of your choice.
      ''',
    },
    {
      'path': 'assets/images/recipe2.jpeg',
      'title': 'Smoothie Bowl',
      'ingredients': '''
        Your choice of fruits
        Greek Yogurt
        Honey
        Granola
          ''',
      'recipe': '''
        1. Blend fruits, Greek Yogurt, and Honey until smooth.
        2. Pour into a bowl.
        3. Sprinkle with granola.
      ''',
    },
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato',
      'ingredients': '''
      Avocado
       Bread 
       Tomato
       Salt
       Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Add sliced tomato.
        4. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast',
      'ingredients': '''
       Avocado
        Bread
         Lime 
         juice
          Cilantro
           Salt 
           Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Squeeze lime juice over the avocado.
        4. Sprinkle with chopped cilantro.
        5. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe5.jpeg',
      'title': 'Chocolate Chip Banana Pancakes',
      'ingredients': '''
Banana 
Pancake
 mix 
 Chocolate 
 chips 
 Milk ''',
      'recipe': '''
        1. Mash banana and mix with pancake mix and milk.
        2. Stir in chocolate chips.
        3. Cook pancakes on a hot griddle.
      ''',
    },
    {
      'path': 'assets/images/recipe6.jpeg',
      'title': 'Fruit Salad',
      'ingredients': '''
       Assorted
        fruits 
        (e.g., apples, oranges, grapes)
        ''',
      'recipe': '''
        1. Wash and chop fruits into bite-sized pieces.
        2. Combine in a bowl.
        3. Serve chilled.
      ''',
    },
    {
      'path': 'assets/images/recipe7.jpeg',
      'title': 'Egg Breakfast Bowl',
      'ingredients': '''
Eggs
Spinach 
Tomato
 Cheese 
 Salt 
 Pepper
''',
      'recipe': '''
        1. Scramble eggs and cook with spinach, tomatoes, and cheese.
        2. Season with salt and pepper.
        3. Serve hot in a bowl.
      ''',
    },
    {
      'path': 'assets/images/recipe9.jpeg',
      'title': 'Yogurt Parfait',
      'ingredients': '''
      Greek yogurt
       Granola
        Mixed berries
         Honey
      ''',
      'recipe': '''
        1. Layer Greek yogurt, granola, and mixed berries in a glass.
        2. Drizzle with honey.
        3. Repeat the layers.
      ''',
    },
    {
      'path': 'assets/images/snack1.jpeg',
      'title': 'Frozen Vanilla Berry Bark',
      'ingredients': '''
        Greek Yogurt
        Mixed Berries
        Honey
        Vanilla Extract
      ''',
      'recipe': '''
        1. Mix Greek yogurt, honey, and vanilla extract in a bowl.
        2. Spread the mixture on a baking sheet.
        3. Sprinkle mixed berries on top.
        4. Freeze until solid, then break into pieces.
      ''',
    },
    {
      'path': 'assets/images/snack2.jpeg',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack3.jpeg',
      'title': 'Apple Peanut Butter',
      'ingredients': '''
        Apples
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Slice apples.
        2. Spread peanut butter on apple slices.
        3. Sprinkle chocolate chips on top.
      ''',
    },
    {
      'path': 'assets/images/snack4.jpeg',
      'title': 'Frozen Yogurt',
      'ingredients': '''
        Greek Yogurt
        Honey
        Berries
      ''',
      'recipe': '''
        1. Mix Greek yogurt and honey in a bowl.
        2. Add berries and mix well.
        3. Freeze until firm.
      ''',
    },
    {
      'path': 'assets/images/snack5.png',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack6.jpeg',
      'title': 'Healthy Cookies',
      'ingredients': '''
        Rolled Oats
        Banana
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mash bananas in a bowl.
        2. Add rolled oats, peanut butter, and chocolate chips.
        3. Mix well and form into cookies.
        4. Bake in the oven until golden brown.
      ''',
    },
    {
      'path': 'assets/images/snack7.jpeg',
      'title': 'Fruits',
      'ingredients': '''
        Assorted Fruits (e.g., Strawberries, Grapes, Kiwi)
      ''',
      'recipe': '''
        1. Wash and chop assorted fruits.
        2. Arrange them on a plate.
      ''',
    },
    {
      'path': 'assets/images/snack8.jpeg',
      'title': 'Greek Yogurt Brownies',
      'ingredients': '''
        Greek Yogurt
        Cocoa Powder
        Honey
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix Greek yogurt, cocoa powder, honey, and chocolate chips in a bowl.
        2. Pour into a baking pan and spread evenly.
        3. Bake in the oven until set.
      ''',
    },
    {
      'path': 'assets/images/snack1.jpeg',
      'title': 'Frozen Vanilla Berry Bark',
      'ingredients': '''
        Greek Yogurt
        Mixed Berries
        Honey
        Vanilla Extract
      ''',
      'recipe': '''
        1. Mix Greek yogurt, honey, and vanilla extract in a bowl.
        2. Spread the mixture on a baking sheet.
        3. Sprinkle mixed berries on top.
        4. Freeze until solid, then break into pieces.
      ''',
    },
    {
      'path': 'assets/images/snack2.jpeg',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack3.jpeg',
      'title': 'Apple Peanut Butter',
      'ingredients': '''
        Apples
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Slice apples.
        2. Spread peanut butter on apple slices.
        3. Sprinkle chocolate chips on top.
      ''',
    },
    {
      'path': 'assets/images/snack4.jpeg',
      'title': 'Frozen Yogurt',
      'ingredients': '''
        Greek Yogurt
        Honey
        Berries
      ''',
      'recipe': '''
        1. Mix Greek yogurt and honey in a bowl.
        2. Add berries and mix well.
        3. Freeze until firm.
      ''',
    },
    {
      'path': 'assets/images/snack5.png',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack6.jpeg',
      'title': 'Healthy Cookies',
      'ingredients': '''
        Rolled Oats
        Banana
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mash bananas in a bowl.
        2. Add rolled oats, peanut butter, and chocolate chips.
        3. Mix well and form into cookies.
        4. Bake in the oven until golden brown.
      ''',
    },
    {
      'path': 'assets/images/snack7.jpeg',
      'title': 'Fruits',
      'ingredients': '''
        Assorted Fruits (e.g., Strawberries, Grapes, Kiwi)
      ''',
      'recipe': '''
        1. Wash and chop assorted fruits.
        2. Arrange them on a plate.
      ''',
    },
    {
      'path': 'assets/images/snack8.jpeg',
      'title': 'Greek Yogurt Brownies',
      'ingredients': '''
        Greek Yogurt
        Cocoa Powder
        Honey
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix Greek yogurt, cocoa powder, honey, and chocolate chips in a bowl.
        2. Pour into a baking pan and spread evenly.
        3. Bake in the oven until set.
      ''',
    },
    {
      'path': 'assets/images/lunch1.png',
      'title': 'Bean Salad',
      'ingredients': '''
        Canned Beans
        Cherry Tomatoes
        Red Onion
        Olive Oil
        Balsamic Vinegar
      ''',
      'recipe': '''
        1. Mix canned beans, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and balsamic vinegar.
        3. Toss well and serve.
      ''',
    },
    {
      'path': 'assets/images/lunch2.jpeg',
      'title': 'Mediterranean Tuna Salad',
      'ingredients': '''
        Tuna
        Cucumber
        Cherry Tomatoes
        Red Onion
        Olive Oil
      ''',
      'recipe': '''
        1. Combine tuna, cucumber, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and toss to combine.
        3. Serve as a refreshing salad.
      ''',
    },
    {
      'path': 'assets/images/lunch3.png',
      'title': 'Ramen',
      'ingredients': '''
        Ramen Noodles
        Broth
        Vegetables (e.g., Bok Choy, Mushrooms)
        Soy Sauce
      ''',
      'recipe': '''
        1. Cook ramen noodles according to package instructions.
        2. Heat broth and add vegetables.
        3. Add cooked ramen noodles and soy sauce.
        4. Serve hot.
      ''',
    },
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-Roasted Carrot & Cauliflower',
      'ingredients': '''
        Carrots
        Cauliflower
        Cumin
        Olive Oil
        Salt and Pepper
      ''',
      'recipe': '''
        1. Toss carrots and cauliflower with cumin, olive oil, salt, and pepper.
        2. Roast in the oven until tender.
        3. Serve as a side dish.
      ''',
    },
    {
      'path': 'assets/images/lunch5.jpeg',
      'title': 'Amatriciana',
      'ingredients': '''
        Pasta
        Pancetta or Guanciale
        Tomatoes
        Onion
        Pecorino Cheese
      ''',
      'recipe': '''
        1. Cook pasta until al dente.
        2. Sauté pancetta or guanciale and onion in a pan.
        3. Add tomatoes and simmer.
        4. Toss pasta with the sauce and top with Pecorino cheese.
      ''',
    },
    {
      'path': 'assets/images/easybutterchicken.jpg',
      'title': 'Easy Butter Chicken',
      'ingredients': '''
        Chicken
        Butter
        Tomatoes
        Cream
        Spices
      ''',
      'recipe': '''
        1. Sauté chicken in butter, add tomatoes, cream, and spices.
        2. Simmer until the sauce thickens and serve.
      ''',
    },
    {
      'path': 'assets/images/spaghettibolognese.jpeg',
      'title': 'Spaghetti Bolognese',
      'ingredients': '''
        Ground Beef
        Tomatoes
        Onion
        Spaghetti
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Brown ground beef and onion, add tomatoes, and simmer.
        2. Serve over cooked spaghetti with Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/classicshepherdspie.jpg',
      'title': 'Classic Shepherd Pie',
      'ingredients': '''
        Ground Beef
        Vegetables
        Mashed Potatoes
        Gravy
      ''',
      'recipe': '''
        1. Brown ground beef, add vegetables, and top with mashed potatoes.
        2. Bake until golden and serve with gravy.
      ''',
    },
    {
      'path': 'assets/images/zucchinifritters.jpeg',
      'title': 'Zucchini Fritters',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Feta Cheese
        Dill
      ''',
      'recipe': '''
        1. Grate zucchini, mix with eggs, flour, feta cheese, and dill.
        2. Fry until golden brown and serve.
      ''',
    },
    {
      'path': 'assets/images/lunch6.jpeg',
      'title': 'Sautéed Shrimp',
      'ingredients': '''
        Shrimp
        Garlic
        Butter
        Lemon Juice
        Parsley
      ''',
      'recipe': '''
        1. Sauté shrimp and garlic in butter.
        2. Add lemon juice and parsley.
        3. Cook until shrimp turn pink.
      ''',
    },
    {
      'path': 'assets/images/lunch7.jpeg',
      'title': 'Healthy Pasta',
      'ingredients': '''
        Whole Wheat Pasta
        Broccoli
        Cherry Tomatoes
        Olive Oil
        Garlic
      ''',
      'recipe': '''
        1. Cook whole wheat pasta.
        2. Sauté broccoli, cherry tomatoes, and garlic in olive oil.
        3. Toss with cooked pasta.
      ''',
    },
    {
      'path': 'assets/images/lunch8.png',
      'title': 'Spaghetti',
      'ingredients': '''
        Spaghetti
        Tomato Sauce
        Ground Beef (optional)
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Cook spaghetti.
        2. If desired, brown ground beef and mix with tomato sauce.
        3. Serve spaghetti with sauce and Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/lunch1.png',
      'title': 'Bean Salad',
      'ingredients': '''
        Canned Beans
        Cherry Tomatoes
        Red Onion
        Olive Oil
        Balsamic Vinegar
      ''',
      'recipe': '''
        1. Mix canned beans, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and balsamic vinegar.
        3. Toss well and serve.
      ''',
    },
    {
      'path': 'assets/images/lunch2.jpeg',
      'title': 'Mediterranean Tuna Salad',
      'ingredients': '''
        Tuna
        Cucumber
        Cherry Tomatoes
        Red Onion
        Olive Oil
      ''',
      'recipe': '''
        1. Combine tuna, cucumber, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and toss to combine.
        3. Serve as a refreshing salad.
      ''',
    },
    {
      'path': 'assets/images/lunch3.png',
      'title': 'Ramen',
      'ingredients': '''
        Ramen Noodles
        Broth
        Vegetables (e.g., Bok Choy, Mushrooms)
        Soy Sauce
      ''',
      'recipe': '''
        1. Cook ramen noodles according to package instructions.
        2. Heat broth and add vegetables.
        3. Add cooked ramen noodles and soy sauce.
        4. Serve hot.
      ''',
    },
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-Roasted Carrot & Cauliflower',
      'ingredients': '''
        Carrots
        Cauliflower
        Cumin
        Olive Oil
        Salt and Pepper
      ''',
      'recipe': '''
        1. Toss carrots and cauliflower with cumin, olive oil, salt, and pepper.
        2. Roast in the oven until tender.
        3. Serve as a side dish.
      ''',
    },
    {
      'path': 'assets/images/lunch5.jpeg',
      'title': 'Amatriciana',
      'ingredients': '''
        Pasta
        Pancetta or Guanciale
        Tomatoes
        Onion
        Pecorino Cheese
      ''',
      'recipe': '''
        1. Cook pasta until al dente.
        2. Sauté pancetta or guanciale and onion in a pan.
        3. Add tomatoes and simmer.
        4. Toss pasta with the sauce and top with Pecorino cheese.
      ''',
    },
    {
      'path': 'assets/images/lunch6.jpeg',
      'title': 'Sautéed Shrimp',
      'ingredients': '''
        Shrimp
        Garlic
        Butter
        Lemon Juice
        Parsley
      ''',
      'recipe': '''
        1. Sauté shrimp and garlic in butter.
        2. Add lemon juice and parsley.
        3. Cook until shrimp turn pink.
      ''',
    },
    {
      'path': 'assets/images/lunch7.jpeg',
      'title': 'Healthy Pasta',
      'ingredients': '''
        Whole Wheat Pasta
        Broccoli
        Cherry Tomatoes
        Olive Oil
        Garlic
      ''',
      'recipe': '''
        1. Cook whole wheat pasta.
        2. Sauté broccoli, cherry tomatoes, and garlic in olive oil.
        3. Toss with cooked pasta.
      ''',
    },
    {
      'path': 'assets/images/lunch8.png',
      'title': 'Spaghetti',
      'ingredients': '''
        Spaghetti
        Tomato Sauce
        Ground Beef (optional)
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Cook spaghetti.
        2. If desired, brown ground beef and mix with tomato sauce.
        3. Serve spaghetti with sauce and Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/TeriyakiSalmonSushiBowl.jpg',
      'title': 'Teriyaki Salmon Sushi Bowl',
      'ingredients': '''
        Salmon
        Sushi Rice
        Teriyaki Sauce
        Avocado
        Cucumber
      ''',
      'recipe': '''
        1. Cook salmon and glaze with teriyaki sauce.
        2. Prepare sushi rice.
        3. Assemble the bowl with rice, salmon, avocado, and cucumber.
      ''',
    },
    {
      'path': 'assets/images/lunch7.jpeg',
      'title': 'Healthy Pasta',
      'ingredients': '''
        Whole Wheat Pasta
        Broccoli
        Cherry Tomatoes
        Olive Oil
        Garlic
      ''',
      'recipe': '''
        1. Cook whole wheat pasta.
        2. Sauté broccoli, cherry tomatoes, and garlic in olive oil.
        3. Toss with cooked pasta.
      ''',
    },
    {
      'path': 'assets/images/lunch8.png',
      'title': 'Spaghetti',
      'ingredients': '''
        Spaghetti
        Tomato Sauce
        Ground Beef (optional)
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Cook spaghetti.
        2. If desired, brown ground beef and mix with tomato sauce.
        3. Serve spaghetti with sauce and Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/lunch1.png',
      'title': 'Bean Salad',
      'ingredients': '''
        Canned Beans
        Cherry Tomatoes
        Red Onion
        Olive Oil
        Balsamic Vinegar
      ''',
      'recipe': '''
        1. Mix canned beans, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and balsamic vinegar.
        3. Toss well and serve.
      ''',
    },
    {
      'path': 'assets/images/lunch2.jpeg',
      'title': 'Mediterranean Tuna Salad',
      'ingredients': '''
        Tuna
        Cucumber
        Cherry Tomatoes
        Red Onion
        Olive Oil
      ''',
      'recipe': '''
        1. Combine tuna, cucumber, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and toss to combine.
        3. Serve as a refreshing salad.
      ''',
    },
    {
      'path': 'assets/images/LoadedSpicyShrimpBowl.jpg',
      'title': 'Loaded Spicy Shrimp Bowl',
      'ingredients': '''
        Shrimp
        Rice
        Spices
        Black Beans
        Corn
      ''',
      'recipe': '''
        1. Season and cook shrimp with spices.
        2. Cook rice and top with black beans and corn.
        3. Add spicy shrimp on top.
      ''',
    },
    {
      'path': 'assets/images/zucchinislice.jpg',
      'title': 'Zucchini Slice',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Cheese
        Bacon
      ''',
      'recipe': '''
        1. Grate zucchini and mix with eggs, flour, cheese, and bacon.
        2. Bake until golden brown.
      ''',
    },
    {
      'path': 'assets/images/besteasypumpkinsouprecipe.jpeg',
      'title': 'Best Easy Pumpkin Soup Recipe',
      'ingredients': '''
        Pumpkin
        Onion
        Garlic
        Vegetable Broth
        Cream
      ''',
      'recipe': '''
        1. Sauté onion and garlic, then add pumpkin and vegetable broth.
        2. Simmer until pumpkin is tender, then blend.
        3. Stir in cream and serve.
      ''',
    },
    {
      'path': 'assets/images/easyfriedrice.jpeg',
      'title': 'Easy Fried Rice',
      'ingredients': '''
        Rice
        Vegetables
        Soy Sauce
        Eggs
        Sesame Oil
      ''',
      'recipe': '''
        1. Cook rice and set aside.
        2. Sauté vegetables, add eggs, then mix in rice and soy sauce.
        3. Drizzle with sesame oil and serve.
      ''',
    },
    {
      'path': 'assets/images/classicshepherdspie.jpg',
      'title': 'Classic Shepherd Pie',
      'ingredients': '''
        Ground Beef
        Vegetables
        Mashed Potatoes
        Gravy
      ''',
      'recipe': '''
        1. Brown ground beef, add vegetables, and top with mashed potatoes.
        2. Bake until golden and serve with gravy.
      ''',
    },
    {
      'path': 'assets/images/quiche.jpeg',
      'title': 'Quiche',
      'ingredients': '''
        Pie Crust
        Eggs
        Milk
        Cheese
        Vegetables
      ''',
      'recipe': '''
        1. Line pie crust with vegetables and cheese.
        2. Whisk eggs and milk, then pour into crust.
        3. Bake until set and golden.
      ''',
    },
    {
      'path': 'assets/images/basicchickenandvegetablestirfry.jpeg',
      'title': 'Basic Chicken and Vegetable Stir Fry',
      'ingredients': '''
        Chicken
        Vegetables
        Soy Sauce
        Ginger
        Garlic
      ''',
      'recipe': '''
        1. Stir fry chicken and vegetables with ginger and garlic.
        2. Add soy sauce for flavor.
        3. Serve over rice or noodles.
      ''',
    },
    {
      'path': 'assets/images/easybutterchicken.jpg',
      'title': 'Easy Butter Chicken',
      'ingredients': '''
        Chicken
        Butter
        Tomatoes
        Cream
        Spices
      ''',
      'recipe': '''
        1. Sauté chicken in butter, add tomatoes, cream, and spices.
        2. Simmer until the sauce thickens and serve.
      ''',
    },
    {
      'path': 'assets/images/spaghettibolognese.jpeg',
      'title': 'Spaghetti Bolognese',
      'ingredients': '''
        Ground Beef
        Tomatoes
        Onion
        Spaghetti
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Brown ground beef and onion, add tomatoes, and simmer.
        2. Serve over cooked spaghetti with Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/zucchinifritters.jpeg',
      'title': 'Zucchini Fritters',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Feta Cheese
        Dill
      ''',
      'recipe': '''
        1. Grate zucchini, mix with eggs, flour, feta cheese, and dill.
        2. Fry until golden brown and serve.
      ''',
    },
 
    {
      'path': 'assets/images/TeriyakiSalmonSushiBowl.jpg',
      'title': 'Teriyaki Salmon Sushi Bowl',
      'ingredients': '''
        Salmon
        Sushi Rice
        Teriyaki Sauce
        Avocado
        Cucumber
      ''',
      'recipe': '''
        1. Cook salmon and glaze with teriyaki sauce.
        2. Prepare sushi rice.
        3. Assemble the bowl with rice, salmon, avocado, and cucumber.
      ''',
    },
    {
      'path': 'assets/images/LoadedSpicyShrimpBowl.jpg',
      'title': 'Loaded Spicy Shrimp Bowl',
      'ingredients': '''
        Shrimp
        Rice
        Spices
        Black Beans
        Corn
      ''',
      'recipe': '''
        1. Season and cook shrimp with spices.
        2. Cook rice and top with black beans and corn.
        3. Add spicy shrimp on top.
      ''',
    },
    {
      'path': 'assets/images/zucchinislice.jpg',
      'title': 'Zucchini Slice',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Cheese
        Bacon
      ''',
      'recipe': '''
        1. Grate zucchini and mix with eggs, flour, cheese, and bacon.
        2. Bake until golden brown.
      ''',
    },
    {
      'path': 'assets/images/besteasypumpkinsouprecipe.jpeg',
      'title': 'Best Easy Pumpkin Soup Recipe',
      'ingredients': '''
        Pumpkin
        Onion
        Garlic
        Vegetable Broth
        Cream
      ''',
      'recipe': '''
        1. Sauté onion and garlic, then add pumpkin and vegetable broth.
        2. Simmer until pumpkin is tender, then blend.
        3. Stir in cream and serve.
      ''',
    },
    {
      'path': 'assets/images/easyfriedrice.jpeg',
      'title': 'Easy Fried Rice',
      'ingredients': '''
        Rice
        Vegetables
        Soy Sauce
        Eggs
        Sesame Oil
      ''',
      'recipe': '''
        1. Cook rice and set aside.
        2. Sauté vegetables, add eggs, then mix in rice and soy sauce.
        3. Drizzle with sesame oil and serve.
      ''',
    },
    {
      'path': 'assets/images/classicshepherdspie.jpg',
      'title': 'Classic Shepherd Pie',
      'ingredients': '''
        Ground Beef
        Vegetables
        Mashed Potatoes
        Gravy
      ''',
      'recipe': '''
        1. Brown ground beef, add vegetables, and top with mashed potatoes.
        2. Bake until golden and serve with gravy.
      ''',
    },
    {
      'path': 'assets/images/quiche.jpeg',
      'title': 'Quiche',
      'ingredients': '''
        Pie Crust
        Eggs
        Milk
        Cheese
        Vegetables
      ''',
      'recipe': '''
        1. Line pie crust with vegetables and cheese.
        2. Whisk eggs and milk, then pour into crust.
        3. Bake until set and golden.
      ''',
    },
    {
      'path': 'assets/images/basicchickenandvegetablestirfry.jpeg',
      'title': 'Basic Chicken and Vegetable Stir Fry',
      'ingredients': '''
        Chicken
        Vegetables
        Soy Sauce
        Ginger
        Garlic
      ''',
      'recipe': '''
        1. Stir fry chicken and vegetables with ginger and garlic.
        2. Add soy sauce for flavor.
        3. Serve over rice or noodles.
      ''',
    },
    {
      'path': 'assets/images/easybutterchicken.jpg',
      'title': 'Easy Butter Chicken',
      'ingredients': '''
        Chicken
        Butter
        Tomatoes
        Cream
        Spices
      ''',
      'recipe': '''
        1. Sauté chicken in butter, add tomatoes, cream, and spices.
        2. Simmer until the sauce thickens and serve.
      ''',
    },
    {
      'path': 'assets/images/spaghettibolognese.jpeg',
      'title': 'Spaghetti Bolognese',
      'ingredients': '''
        Ground Beef
        Tomatoes
        Onion
        Spaghetti
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Brown ground beef and onion, add tomatoes, and simmer.
        2. Serve over cooked spaghetti with Parmesan cheese.
      ''',
    },
  
  

    {
      'path': 'assets/images/zucchinifritters.jpeg',
      'title': 'Zucchini Fritters',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Feta Cheese
        Dill
      ''',
      'recipe': '''
        1. Grate zucchini, mix with eggs, flour, feta cheese, and dill.
        2. Fry until golden brown and serve.
      ''',
    },







  ];

  
  SharedPreferences? _prefs;
  //imageData.shuffle();
  @override
  void initState() {
    super.initState();
    filteredImageData = List.from(imageData);
    _loadFavoriteImages();
  }

  Future<void> _loadFavoriteImages() async {
    _prefs = await SharedPreferences.getInstance();
    final favoriteImagesList = _prefs?.getStringList('recipeFavoriteImages') ?? [];
    setState(() {
      favoriteImages = favoriteImagesList;
    });
  }
  // List to store the favorite images
  List<String> favoriteImages = [];
  List<String> favoriteRecipes = [];

  Future<void> _loadFavoriteRecipes() async {
    favoriteRecipes = await FavoriteRecipes.getFavoriteRecipes();
    setState(() {
      filteredImageData = List.from(imageData);
    });
  }

  void _saveFavoriteRecipes() async {
    await FavoriteRecipes.saveFavoriteRecipes(favoriteRecipes);
  }


  List<Map<String, String>> filteredImageData = [];
  TextEditingController searchController = TextEditingController();

  void toggleFavorite(String imagePath) async {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
    });

    // Save the updated list of favorite images to SharedPreferences
    await _prefs?.setStringList('recipeFavoriteImages', favoriteImages);
  }


  //search
  void updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredImageData = List.from(imageData);
      } else {
        filteredImageData = imageData
            .where((data) =>
                data['title']!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  //navigation
  void navigateToDetailPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecipeDetailPage(recipeData: filteredImageData[index]),
      ),
    );
  }

  Widget buildCard(String imagePath, String title, bool isFavorite,
      Function() onFavoritePressed) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: 175.0,
      height: 175.0,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: () {
                int index = filteredImageData
                    .indexWhere((data) => data['path'] == imagePath);
                navigateToDetailPage(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -4.0,
            right: 15.0,
            child: FavoriteButton(
              onFavoriteChanged: (bool isFavorite) {
                onFavoritePressed();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Recipe',
        showFavoriteIcon: true,
        onFavoritePressed: () {
          if (favoriteImages.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteImages, imageData),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => buildEmptyFavoritesDialog(context),
            );
          }
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth / 2 - 10;
            double searchBarWidth =
                constraints.maxWidth > 400 ? 400 : constraints.maxWidth - 16;
            return Column(
              children: [
                Container(
                  width: searchBarWidth,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color.fromARGB(255, 236, 238, 241),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF9FA5C0),
                          size: 28.006,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (query) => updateSearch(query),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.50),
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.105,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: cardWidth / (cardWidth + 80),
                    ),
                    itemCount: filteredImageData.length,
                    itemBuilder: (context, index) {
                      final data = filteredImageData[index];
                      final imagePath = data['path']!;
                      final title = data['title']!;
                      final isFavorite = favoriteImages.contains(imagePath);

                      return buildCard(imagePath, title, isFavorite, () {
                        toggleFavorite(imagePath);
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
