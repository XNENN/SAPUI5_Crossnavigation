using {db as db} from '../db/schema';

@path: '/Ui5'
service CrossNavigation {
    entity Cup         as
        projection on db.Cup {
            *
        };

    entity Liquid      as
        projection on db.Liquid {
            *
        };

    entity LiquidInCup as
        projection on db.LiquidInCup {
            *
        };

    entity Alcohol as
        projection on db.Alcohol {
            *
        };

    entity AlcoholInCup as
        projection on db.AlcoholInCup {
            *
        };
}
annotate CrossNavigation.Cup {
    @UI.ExcludeFromNavigationContext : true
    ID;
    @UI.ExcludeFromNavigationContext : true
    Name;
};
