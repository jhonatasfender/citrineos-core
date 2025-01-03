module.exports = {
  development: {
    url: process.env.DATABASE_URL,
    dialect: 'postgres',
    seederStorage: 'sequelize',
    migrationStorage: 'sequelize'
  }
}; 