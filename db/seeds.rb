# db/seeds.rb

# Category names and subcategories
categories_data = [
  {
    name: 'Science',
    subcategories: [
      'Biology',
      'Chemistry',
      'Physics',
      'Astronomy',
      'Geology',
      'Ecology',
      'Genetics',
      'Neuroscience',
      'Mathematics',
      'Computer Science'
    ],
    classification: :factual
  },
  {
    name: 'Humanities',
    subcategories: [
      'History',
      'Philosophy',
      'Literature',
      'Linguistics',
      'Anthropology',
      'Archaeology',
      'Psychology',
      'Sociology',
      'Political Science',
      'Religious Studies'
    ],
    classification: :factual
  },
  {
    name: 'Technology',
    subcategories: [
      'Programming',
      'Artificial Intelligence',
      'Cybersecurity',
      'Data Science',
      'Web Development',
      'Mobile App Development',
      'Robotics',
      'Internet of Things (IoT)',
      'Blockchain',
      'Virtual Reality'
    ],
    classification: :factual
  },
  {
    name: 'Arts',
    subcategories: [
      'Painting',
      'Sculpture',
      'Photography',
      'Music',
      'Dance',
      'Theater',
      'Film',
      'Literature',
      'Architecture',
      'Fashion'
    ],
    classification: :factual
  },
  {
    name: 'Worldly',
    subcategories: [
      'Travel and Exploration',
      'Culture and Customs',
      'Geography',
      'Global History',
      'Current Affairs',
      'International Relations',
      'Anthropology',
      'Sociology',
      'Global Economics',
      'Environmental Studies'
    ],
    classification: :factual
  },
  {
    name: 'Fantasy',
    subcategories: [
      'Magic',
      'Dragons',
      'Mythical Creatures',
      'Epic Quests',
      'Sorcery',
      'Legendary Heroes',
      'Enchanted Worlds',
      'Magical Artifacts',
      'Fairy Tales',
      'Alternate Realities'
    ],
    classification: :fictional
  },
  {
    name: 'Adventure',
    subcategories: [
      'Exploration',
      'Treasure Hunting',
      'Lost Civilizations',
      'Pirates',
      'Jungle Expeditions',
      'Mysterious Islands',
      'Quests for Ancient Relics',
      'Daring Escapes',
      'Perilous Journeys',
      'Thrilling Discoveries'
    ],
    classification: :fictional
  }
]

# Seed the categories and subcategories
categories_data.each do |category_data|
  category = Category.create(name: category_data[:name], classification: category_data[:classification])

  category_data[:subcategories].each do |subcategory_name|
    category.subcategories.create(name: subcategory_name)
  end
end

Book.create(title: "Permaculture paradise: The path to prosperity", classification: 1, category: Category.find_by(name: "Science"), subcategory: Subcategory.find_by(name: "Ecology"))
