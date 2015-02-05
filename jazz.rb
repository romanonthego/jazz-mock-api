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
      def photo_url
        'http://public.gde.travel/images/JazzTour/thumbnail/slider/6sqh9z1uxo.jpg'
      end

      def photo_thumb_url
        'http://public.gde.travel/images/JazzTour/thumbnail/content/p67i97mjpq.jpg'
      end

      def list_of_articles
        id = Faker::Number.number(10)

        {
          type: 'list_of_objects',
          id: id,
          title: 'Что почитать про Норвегию',
          content: {
            objects: [
              {
                type: 'article',
                title: 'Виза в Норвегию',
                object: {
                  type: 'article',
                  id: 12,
                  slug: 'some-awesome-article'
                },
                content: {
                  description: description,
                  photos: [
                    photo
                  ]
                }
              },
              tour
            ]
          }
        }
      end

      def single_object_with_preview
        id = rnd
        {
          type: 'single_object',
          id: Faker::Number.number(10),
          title: 'Виза',
          object: {
            type: 'article',
            id: id,
            geo_prefix: 'marocco/rabat',
            slug: 'norway-visa'
          },
          content: {
            sections: [
              {
                type: 'text',
                text: description
              }
            ]
          }
        }
      end

      def sing_object_without_content
        id = rnd
        {
          type: 'single_object',
          id: Faker::Number.number(10),
          title: 'Погода в норвегии',
          object: {
            type: 'article',
            id: id,
            geo_prefix: 'marocco/rabat',
            slug: 'weather-in-norway'
          },
          # content: {
          # }
        }
      end

      def single_object_with_photo
        id = rnd
        {
          type: 'single_object',
          id: Faker::Number.number(10),
          title: 'Лето в норвегии',
          object: {
            type: 'tour',
            id: id,
            geo_prefix: 'marocco/rabat',
            slug: 'awesome-tour'
          },
          content: {
            sections: [
              {
                type: 'photo',
                url:photo_url,
                thumb: photo_thumb_url,
                title: 'Мыс Нордкап в лучах полуночного солнца, Северная Норвегия'
              }
            ]
          }
        }
      end

      def content_5_ways
        {
          type: 'content',
          id: Faker::Number.number(10),
          title: "5 причин отправиться на отдых в Норвегию",
          navigation: true,
          content: {
            sections: [
              {
                type: 'text',
                title: 'Фьорды Норвегии',
                text: 'Фьорды – заливы в скалах ледникового происхождения, изумительные по форме, масштабности и красоте. Норвежские фьорды возглавляют список объектов Всемирного наследия и являются туристическим направлением №1 в обозрении «National Geographic».
Умеренный климат, невероятно красивая девственная природа, чистейшая экология и спокойный ритм жизни в Норвегии создают идеальные условия для отдыха и восстановления жизненных сил. При этом вдали от цивилизации в колоритных поселках прямо на берегу фьорда в окружении живописных пейзажей можно остановиться в первоклассных четырех- и пятизвездочных отелях с самым высоким уровнем сервиса, что делает отдых еще более приятным.'
              },
              {
                type: 'photo',
                url:photo_url,
                thumb: photo_thumb_url,
                title: 'Мыс Нордкап в лучах полуночного солнца, Северная Норвегия'
              },
              {
                type: 'text',
                title: 'Фьорды Норвегии',
                text: 'Фьорды – заливы в скалах ледникового происхождения, изумительные по форме, масштабности и красоте. Норвежские фьорды возглавляют список объектов Всемирного наследия и являются туристическим направлением №1 в обозрении «National Geographic».
Умеренный климат, невероятно красивая девственная природа, чистейшая экология и спокойный ритм жизни в Норвегии создают идеальные условия для отдыха и восстановления жизненных сил. При этом вдали от цивилизации в колоритных поселках прямо на берегу фьорда в окружении живописных пейзажей можно остановиться в первоклассных четырех- и пятизвездочных отелях с самым высоким уровнем сервиса, что делает отдых еще более приятным.'
              },
              {
                type: 'slideshow',
                photos: [
                  photo
                ]*rnd,
                description: description,
                title: 'Северная Норвегия, рыбалка'
              },
              {
                type: 'text',
                title: 'Фьорды Норвегии',
                text: 'Фьорды – заливы в скалах ледникового происхождения, изумительные по форме, масштабности и красоте. Норвежские фьорды возглавляют список объектов Всемирного наследия и являются туристическим направлением №1 в обозрении «National Geographic».
Умеренный климат, невероятно красивая девственная природа, чистейшая экология и спокойный ритм жизни в Норвегии создают идеальные условия для отдыха и восстановления жизненных сил. При этом вдали от цивилизации в колоритных поселках прямо на берегу фьорда в окружении живописных пейзажей можно остановиться в первоклассных четырех- и пятизвездочных отелях с самым высоким уровнем сервиса, что делает отдых еще более приятным.'
              },
              {
                type: 'gallery',
                # url:photo_url,
                # thumb: photo_thumb_url,
                photos: [
                  photo
                ]*rnd,
                description: description,
                title: 'Лофотенские острова, Норвегия'
              }
            ]
          }
        }
      end

      def title_norway
        {
          type: 'title',
          id: Faker::Number.number(10),
          title: "Марокко",
          navigation: true,
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
            html_content: html_text,
            photos: [
              photo,
              photo,
              photo
            ]
          }
        }    
      end


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
            text: description,
            photos: [
              photo,
              photo,
              photo
            ]
          }
        } 
      end

      def peoples_card
        {
          type: 'peoples',
          id: Faker::Number.number(10),        }
      end

      def dates_card
        {
          type: 'dates',
          id: Faker::Number.number(10),
          content: {
            user_dates: {

            },
            dates: [
              {
                departure_date: '02.10.2014',
                return_date: '01.10.2014',
                price: 70000
              },
              {
                departure_date: '29.11.2014',
                return_date: '30.11.2014',
                price: 70000
              }
            ]
          }
        }
      end

      def html_text
        text = '<p><strong>Путешествие в Норвегию</strong></p>
<p>Зачем люди едут в Норвегию? Страна северная, солнца мало, Лувра нет. Однако постойте! Благодаря теплому Гольфстриму Норвегия зимой не так сурова – максимум -5°C на побережье, а в июне норвежцы радуются клубнике, как любой русский на даче. Смельчаки, вернувшиеся с мыса Нордкап, утверждают, что своими глазами видели, как солнце не заходит ни днем, ни ночью – и так три месяца подряд!</p>
<p>В то время как остальной мир стремительно переходит на синтетику и заменители вкуса, Норвегия остается оплотом первозданной чистоты и естественности. В этой стране до сих пор можно без опаски закусить первую морошку снегом, пройтись по купе вагона в носках и вдохнуть свежий воздух в центре Осло. Все как в старые добрые времена. Все по-честному. Если с утра не лениться и выйти на палтуса - то вечером будет королевский ужин. Если, обдирая локти, ты полз 5 часов по леднику – от открывшегося сверху вида перехватит дыхание. Полиция здесь не прячется в кустах, блондинки и впрямь блондинки, а поданный на завтрак лосось выловлен только что из прозрачных волн горной реки. И будьте уверены – после пережитого в городах Норвегии вы не пожалеете ни об одной потраченной кроне. Здесь назначают справедливые цены за первоклассные вещи.</p>
<p><strong>Сколько стоит отдых в Норвегии?</strong></p>
<p>От 1395 евро – стоимость двухчасового перелета Москва-Осло и недели путешествий по фьордам. Если вы справедливо считаете, что недели для отдыха мало, отправляйтесь в большой вояж по всему побережью и городам Норвегии на автомобиле или круизном судне Хуртигрутен. Цены 2015 года позволят вам осуществить задуманное в рамках 2000 евро. И пусть в вашей поездке будет и скрип деревянной ганзейской набережной, и чудесная музыка Грига, и сладкий вкус козьего сыра брюност. </p>
<p>Предпочитаете треску? Держите путь в Северную Норвегию. Прямой перелет Москва-Тромсе, проживание в коттедже и неделя упоительной рыбалки с личным катером в придачу — стоимость поездки в Северную Норвегию всего за 1050 €! </p>
<p>Тем, кто жаждет увидеть все и сразу, мы предлагаем увлекательные путешествия в Норвегию на автомобиле fly &amp; drive. На своей или арендованной машине можно объехать хоть всю Норвегию по маршруту, разработанному опытными гидами и адаптированному индивидуально под вас.</p>
<p>Планируете отправиться в край викингов всей семьей? Отдых в Норвегии с детьми приятен в любой сезон. Летом, в июле или в августе самое время поближе познакомиться с родиной легендарного Тура Хейердала. Погладить морского зайца в Тромсе, изучить историю архитектуры на улицах Олесунда, переплыть фьорд наперегонки с дельфинами или, сев на берегу со спиннингом, доказать папе, что великими рыбаками не становятся, а рождаются. По крайней мере, в Норвегии.</p>
<p><strong>Осторожно, лоси!</strong></p>
<p>Этот дорожный знак всюду — на открытках, брелоках, футболках. Негласный символ страны отражает главное правило норвежцев: «Береги природу и… человека». По этой причине путешествие в Норвегию на автомобиле обещает стать вашим самым идиллическим воспоминанием: современная трасса с местами для отдыха посреди девственных лесов впечатляет даже бывалых автолюбителей.
Выделяя немалые средства на защиту окружающего мира, норвежцы в свою очередь черпают силы в природе в самом буквальном смысле слова. В этом легко убедиться, мчась по Фломской железной дороге. Посреди своего пути паровоз неожиданно делает передышку у водопада Кьосфоссен — лишь для того, чтобы пассажиры могли восхититься мощью водяного потока, который питает местную ГЭС, а заодно и поезд, с которого вы только что сошли.</p>
<p><strong>Отдых в Норвегии летом</strong></p>
<p>… вращается вокруг слова «фьорды». Ими любуются с круизных лайнеров, покоряют пешком и на велосипеде, с их скал летят бэйсджамперы, а в воду ныряют дайверы и каякеры. И даже туристы, не склонные к спортивным авантюрам, под руководством опытных инструкторов впервые садятся в лодки и карабкаются на скалы. Ведь Норвегия летом – это прежде всего чувство свободы. Свободы движения. Отдых не только для души, но и для тела. Здесь есть чем заняться! Для тех, кого интересует активный отдых в Норвегии, мы предлагаем рыбалку, каякинг, рафтинг, походы и велопрогулки. </p>
<p>Вот уже 16 лет «Джаз тур» – туроператор по Норвегии в Москве и Санкт-Петербурге – разрабатывает северные маршруты. Вот уже 16 лет мы миксуем скандинавские столицы и зеленые долины, реки, города и великие фьорды Норвегии... Но до сих пор наши гиды скромно называют эти туры всего лишь миниатюрными исследованиями.</p>
<p>И когда придет время покидать Осло, вы поймете, почему викинги так и не завоевали полмира. Зачем им мир, когда есть Норвегия.</p>'
      end

      def accomodation_card
        {
          type: 'accomodation',
          id: rnd,
          title: "Размещение",

          content: {
            accomodations: [
              {
                type: 'hotel',
                id: rnd,
                title: 'Отель ' + title,
                is_default: true,
                object: {
                  geo_prefix: 'usa/new-york',
                  id: rnd,
                  slug: title
                },
                content: {
                  stars: Random.rand(4) + 1,
                  description: description,
                  photos: [
                    {
                      title: 'title',
                      url:photo_url,
                      thumb: photo_thumb_url
                    }
                  ]*rnd,
                  primary_tags: [
                    {
                      type: 'capacity',
                      value: '2 основных места'
                    },
                    {
                      type: 'area',
                      value: '37 м2'
                    }
                  ],
                  # secondary_tags: [
                  #   {
                  #     type: 'hotel',
                  #     value: 'Отель 3 звезды'
                  #   },
                  #   {
                  #     type: 'activities',
                  #     value: [
                  #       {name: 'city-life', title: 'Городской отдых'},
                  #       {name: 'active', title: 'Активный отдых'}
                  #     ]
                  #   }
                  # ],
                  services: [
                    {
                      title: 'Услуги отеля',
                      list: ["Бассейн", "Конференц-зал", "Консьерж", "Фитнес центр", "Йога"]
                    },
                    {
                      title: 'Бесплатный сервис',
                      list: ["Крулосуточное обслуживание в номерах", "Номера для людей с ограниченными возможностями", "Уборка номера 2 раза в день"]
                    },
                    {
                      title: 'За дополнительную плату',
                      list: ["Интернет", "Разрешено размещение с животными", "WI-FI", "Парковка"]
                    }
                  ],
                  variants: [
                    {
                      type: 'room',
                      id: Faker::Number.number(10),
                      title: 'Комната ' + title,
                      content: {
                        description: description,
                        photos: [
                          {
                            title: 'title',
                            url:photo_url,
                            thumb: photo_thumb_url
                          }
                        ]*rnd,
                        services: [
                          {
                            title: 'Услуги отеля',
                            list: ["Бассейн", "Конференц-зал", "Консьерж", "Фитнес центр", "Йога"]
                          },
                          {
                            title: 'Бесплатный сервис',
                            list: ["Крулосуточное обслуживание в номерах", "Номера для людей с ограниченными возможностями", "Уборка номера 2 раза в день"]
                          },
                          {
                            title: 'За дополнительную плату',
                            list: ["Интернет", "Разрешено размещение с животными", "WI-FI", "Парковка"]
                          }
                        ],
                        primary_tags: [
                          {
                            type: 'capacity',
                            value: '2 основных места'
                          },
                          {
                            type: 'area',
                            value: '37 м2'
                          }
                        ]
                      },
                    },
                    {
                      type: 'room',
                      id: Faker::Number.number(10),
                      title: 'Комната ' + title,
                      description: description
                    },
                    {
                      type: 'room',
                      id: Faker::Number.number(10),
                      title: 'Комната ' + title,
                      description: description
                    }
                  ]
                }
              },
              {
                type: 'hotel',
                id: Faker::Number.number(10),
                title: 'Отель ' + title,
                stars: Random.rand(4) + 1,
                is_default: false,
                description: description,
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
                ],
                variants: [
                  {
                    type: 'room',
                    id: Faker::Number.number(10),
                    title: 'Комната ' + title,
                    description: description
                  },
                  {
                    type: 'room',
                    id: Faker::Number.number(10),
                    title: 'Комната ' + title,
                    description: description
                  },
                  {
                    type: 'room',
                    id: Faker::Number.number(10),
                    title: 'Комната ' + title,
                    description: description
                  }
                ]
              }
            ]
          }
        }
      end

      def media_card
        {
          type: 'media',
          id: Faker::Number.number(10),

          content: {
            sections: [
              {
                type: 'video',
                provider: 'vimeo',
                id: 80874188, 
                description: 'В этом году мы решили создать небольшую flow-team, так как нам очень хотелось поддержать молодых ребят, которых пока еще нельзя назвать про, но это временно.'
              },
              {
                type: 'gallery',
                description: 'В этом году мы решили создать небольшую flow-team, так как нам очень хотелось поддержать молодых ребят, которых пока еще нельзя назвать про, но это временно.',
                photos: [
                  {
                    title: 'title',
                    url:photo_url,
                    thumb: photo_thumb_url
                  }
                ]*20
              }
            ]
          }
        }
      end

      def rnd
        Random.rand(100) + 1
      end

      def price
        {
          options: {
            dates: {
              departure_date: '23.10.2014',
              return_date: '30.10.2014',
            },
            peoples: {
              adults: 4,
              children: '1-12-12'
            }
          },
          prices: [
            {
              currency: 'rub',
              value: 122000
            },
            {
              currency: 'usd',
              value: 2000
            } 
          ]
        }
      end

      def photo
        photos = [
          'http://admin.gde.travel/images/JazzTour/cg9urwvglf.jpg',
          'http://admin.gde.travel/images/JazzTour/krfvxdemi1.jpg',
          'http://admin.gde.travel/images/JazzTour/qi8fykmir4.jpg',
          'http://admin.gde.travel/images/JazzTour/zphf2bw7kf.jpg',
          'http://admin.gde.travel/images/JazzTour/c91cisl77f.jpg'
        ]
        {
          url: photos.sample,
          thumb: photo_thumb_url,
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

      def activities_list
        {
          type: 'activities_list',
          id: rnd,
          object: {
            name: 'as',
            type: 'activity',
            geo_prefix: 'france/paris',
            title: 'AS'
          },
          
          title: 'Активный отдых',
          content: {
            cover: "http://loremflickr.com/741/304/marocco",
            activities: [
              {
                type: 'activity',
                title: "Горные лыжи",
                name: "skiing", 
              },
              {
                type: 'activity',
                title: "Дайвинг",
                name: 'diving'
              },
              {
                type: 'activity',
                title: "Сафари",
                name: 'safari'
              }
            ]
          }


        }
      end

      def locations_list
        name = Faker::Address.country.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        {
          type: 'locations_list',
          id: name,
          
          object: {
            type: 'location',
            name: name,
            geo_prefix: '',
            title: "Африка"
          },
          
          title: 'Африка',
          
          content: {
            cover: photo,
            locations: [
              {
                title: "Марокко",
                type: 'location',
                name: "morocco",
                geo_prefix: 'earth/africa',
                regions: [
                  {
                    type: 'location',
                    title: "Рабат",
                    name: "rabat",
                    geo_prefix: 'earth/africa/morocco',
                  },
                  {
                    type: 'location',
                    title: "Рабат",
                    name: "rabat",
                    geo_prefix: 'earth/africa/morocco',
                  }
                ]
              },
              {
                type: 'location',
                title: "Марокко",
                name: "morocco",
                geo_prefix: 'earth/africa',
              },
              {
                type: 'location',
                title: "Марокко",
                name: "morocco",
                geo_prefix: 'earth/africa',
              }
            ]
          }
        }
      end

      
      def tour
        id = rnd
        {
          type: 'tour',
          id: id,
          title: 'Шикарный тур',
          object: {
            type: 'tour',
            id: id,
            geo_prefix: 'marocco/rabat',
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
        tour,
        tour
      ]
    end

    get '/locations_lists' do
      [
        locations_list,
        locations_list,
        locations_list,
      ]
    end

    get '/activities_lists' do
      [
        activities_list,
        activities_list,
        activities_list
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
          id = rnd
          {
            id: params.id,
            type: 'tour',
            title: title,
            object: {
              type: 'tour',
              id: params.id,
              geo_prefix: 'marocco/rabat',
              slug: 'awesome-tour'
            },
            meta_info: {
              title: "Самый лучший тур",
              description: "Описание самого лучшего тура",
              image: photo_url,
              
              open_graph: {
                title: "Самый лучший тур для facebook"
              },
              schema_org: {
                
              },
              twitter: {

              }
            },
            price: price,

            content: {
              main: [
                title_card,
                peoples_card,
                dates_card,
                accomodation_card,
                media_card
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

    resource :locations do
      get do
      {
        foo: 'bar'
      }
      end
      
      # params do
      #   requires :name, type: String, desc: "Location name"
      # end
      get '/:name'do 
        id = rnd
       {
         id: id,
         type: 'location',
         title: Faker::Address.country,
         object: {
           type: 'location',
           id: id,
           name: params.name,
           geo_prefix: 'marocco/rabat',
         },
         meta_info: {
           title: "Марокко",
           description: "Описание марокко",
           
           open_graph: {
             title: "Описание марокко facebook"
           },
           schema_org: {

           },
           twitter: {

           }
         },
         content: {
           main: [
             # title_card,
             title_norway,
             content_5_ways,
             single_object_with_preview,
             single_object_with_photo,
             sing_object_without_content,
             list_of_articles,
             # peoples_card,
             # dates_card,
             # accomodation_card,
             media_card
           ],
           aside: [
            locations_list,
            tour
           ]
         }
       }
      end
      # route_param :name do
    
      # end
    end

    resource :activities do
      get do
      {
        foo: 'bar'
      }
      end
      
      # params do
      #   requires :name, type: String, desc: "Location name"
      # end
      get '/:name'do 
        id = rnd
       {
         id: id,
         type: 'location',
         title: Faker::Address.country,
         object: {
           type: 'location',
           id: id,
           name: params.name,
           geo_prefix: 'marocco/rabat',
         },
         meta: {
           title: "Марокко",
           description: "Описание марокко",
           
           open_graph: {
             title: "Описание марокко facebook"
           },
           schema_org: {

           },
           twitter: {

           }
         },
         content: {
           main: [
             title_card,
             # peoples_card,
             # dates_card,
             # accomodation_card,
             media_card
           ],
           aside: [
            locations_list,
            tour
           ]
         }
       }
      end
      # route_param :name do
    
      # end
    end

    resource :articles do
      params do
        requires :id, type: Integer, desc: "Status id."
      end
      route_param :id do
        get do
          id = params.id
          {
            id: id,
            type: 'article',
            title: 'jaja',
            object: {
              type: 'article',
              id: id,
              slug: 'jaja-article'
            },
            content: {}
          }
        end
      end
    end
  end
end