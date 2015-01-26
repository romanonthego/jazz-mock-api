require 'grape'
require 'faker'

module Jazz
  class String
    def underscore
      self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("- ", "_").
      downcase
    end
  end

  class API < Grape::API
    # version 'v1', using: :header, vendor: 'twitter'
    format :json
    # prefix :api
    
    # get '/hello' do
    #   {hello: 'world'}
    # end

    helpers do
      def title_card
        {
          type: 'title',
          id: Faker::Number.number(10),
          title: "Марокко",
          content: {
            title: "Марокко",
            rating: 4.2,
            locations: [
              {
                title: "Марокко",
                name: 'marocco',
                geo_prefix: ''
              },
              {
                title: "Рабат",
                name: 'rabat',
                geo_prefix: '/marocco'
              },
              {
                title: "Рабат",
                name: 'rabat',
                geo_prefix: '/marocco'
              }
            ],
            text: "<p>Morocco is a North African country that has a coastline on both the North Atlantic Ocean and the Mediterranean Sea. It has borders with Western Sahara to the south, Algeria to the east and the Spanish North African territories of Ceuta and Melilla on the Mediterranean coast in the north. It is just across the Strait of Gibraltar from Gibraltar.</p>",
            photos: [
              photo,
              photo,
              photo
            ]
          }
        }
      end

      def rnd
        Random.rand(100) + 1
      end

      def photo
        {
          url:"http://loremflickr.com/741/304/#{Faker::Address.country}",
          title: "photo title (optional)",
          alt: "photo alt (optional)"
        }
      end

      def title
        Faker::Lorem.sentence
      end

      def description
        Faker::Lorem.sentence(25)
      end

      def hotel
        hotel = tour
        hotel[:type] = 'hotel'
        hotel[:title] = Faker::Lorem.sentence(15)
        hotel
      end


      def entertainment
        ent = tour
        ent[:type] = 'entertainment'
        ent[:title]= Faker::Lorem.sentence
        ent
      end


      def special
      end

      def locations_list
        name = Faker::Address.country

        {
          type: 'locations_list',
          id: name,
          
          object: {
            name: name.underscore,
            geo_prefix: '',
            title: "Африка"
          },
          
          title: 'Африка',
          
          content: {
            cover: photo,
            locations: [
              {
                title: "Марокко",
                id: "morocco",
                geo_prefix: 'earth/africa',
                regions: [
                  {
                    title: "Рабат",
                    id: "rabat",
                    geo_prefix: 'earth/africa/morocco',
                  },
                  {
                    title: "Рабат",
                    id: "rabat",
                    geo_prefix: 'earth/africa/morocco',
                  }
                ]
              },
              {
                title: "Марокко",
                id: "morocco",
                geo_prefix: 'earth/africa',
              },
              {
                title: "Марокко",
                id: "morocco",
                geo_prefix: 'earth/africa',
              }
            ]
          }
        }
      end

      
      def tour
        {
          type: 'tour',
          id: Random.rand(100) + 1,
          title: 'Шикарный тур',
          object: {
            geo_prefix: '/marocco/rabat',
            slug: 'awesome-tour'
          },
          price: [
            {
              currency: 'rub',
              amount: '120000'
            },
            {
              currency: 'usd',
              amount: '2200'
            }
          ],

          title: "Шикарный тур",
          content: {
            rating: 4.7,
            title: 'Лучший тур в самую лучшую страну в мире',
            description: "Morocco is a North African country that has a coastline on both the North Atlantic Ocean and the Mediterranean Sea. It has borders with Western Sahara to the south, Algeria to the east and the Spanish North African territories of Ceuta and Melilla on the Mediterranean coast in the north. It is just across the Strait of Gibraltar from Gibraltar.Morocco is a North African country that has a coastline on both the North Atlantic Ocean and the Mediterranean Sea. It has borders with Western Sahara to the south, Algeria to the east and the Spanish North African territories of Ceuta and Melilla on the Mediterranean coast in the north. It is just across the Strait of Gibraltar from Gibraltar.Morocco is a North African country that has a coastline on both the North Atlantic Ocean and the Mediterranean Sea. It has borders with Western Sahara to the south, Algeria to the east and the Spanish North African territories of Ceuta and Melilla on the Mediterranean coast in the north. It is just across the Strait of Gibraltar from Gibraltar.",
            locations: [
              {
                title: "Марокко",
                name: 'marocco',
                geo_prefix: ''
              },
              {
                title: "Рабат",
                name: 'rabat',
                geo_prefix: '/marocco'
              },
              {
                title: "Рабат",
                name: 'rabat',
                geo_prefix: '/marocco'
              }
            ],
            photos: [
              photo,
              photo,
              photo
            ],
            primary_tags: [
              {
                type: 'peoples',
                value: 'от 3-х'
              },
              {
                type: 'duration',
                value: '12 дней'
              }
            ],
            secondary_tags: [
              {
                type: 'hotel',
                value: 'Отель 3 звезды'
              },
              {
                type: 'activities',
                value: [
                  {name: 'city-life', title: 'Городской отдых'},
                  {name: 'active', title: 'Активный отдых'}
                ]
              }
            ]
          },
        }
      end
    end

    get '/main_grid' do
      [
        tour,
        hotel,
        entertainment
      ]
    end

    get '/locations_lists' do
      [
        locations_list,
        locations_list,
        locations_list,
      ]
    end

    get '/activities' do
    end

    # get '/tours' do

    resource :tours do
      get do
        [
          tour,
          tour,
          tour
        ]
      end
      
      params do
        requires :id, type: Integer, desc: "Status id."
      end
      route_param :id do
        get do
          {
            id: rnd,
            type: 'tour',
            title: title,
            object: {
              geo_prefix: '/marocco/rabat',
              slug: 'awesome-tour'
            },
            meta: {
              title: "Самый лучший тур",
              description: "Описание самого лучшего тура",
              
              open_graph: {
                title: "Самый лучший тур для facebook"
              },
              schema_org: {

              },
              twitter: {

              }
            },
            content: {
              main: [
                title_card
              ],
              aside: [
                {type: 'booking'},
                {type: 'help'}
              ]
            }
          }
        end
      end
    end
  end
end