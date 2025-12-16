// COUNT: db.sessions.countDocuments({ expiresAt: { $lt: new Date() } })

db.sessions.deleteMany({ expiresAt: { $lt: new Date() } })
