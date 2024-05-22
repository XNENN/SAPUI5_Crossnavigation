using {db as db} from '../db/schema';

@path: '/Ui5'
service CrossNavigation {
    entity Cup    as projection on db.Cup;
    entity Liquid as projection on db.Liquid;
}
