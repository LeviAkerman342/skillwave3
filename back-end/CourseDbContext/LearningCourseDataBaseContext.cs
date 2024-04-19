﻿using Domain;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace CourseDbContext;

public class LearningCourseDataBaseContext : DbContext
{
    public DbSet<User> User { get; set; }

    public DbSet<Course> Course { get; set; }

    public DbSet<Rating> Rating { get; set; }

    public DbSet<Subscription> Subscription { get; set; }

    public LearningCourseDataBaseContext()
    {
        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
    }
    
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseNpgsql(
            "Host=localhost;Port=5432;Database=learning_course;Username=postgres;Password=postgres");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>();
        modelBuilder.Entity<Course>();
        modelBuilder.Entity<Rating>();
        modelBuilder.Entity<Subscription>();
        
        ApplyEnumConverterToString<User, UserType>(modelBuilder, nameof(Domain.User.UserType));
    }
    
    private static void ApplyEnumConverterToString<TEntity, TEnum>(ModelBuilder modelBuilder, string propertyName)
        where TEntity : class
        where TEnum : Enum
    {
        var entity = modelBuilder.Entity<TEntity>();
        var property = entity.Metadata.FindProperty(propertyName);

        if (property != null && property.ClrType == typeof(TEnum))
        {
            property.SetValueConverter(
                new ValueConverter<TEnum, string>(
                    v => v.ToString(),
                    v => (TEnum)Enum.Parse(typeof(TEnum), v)
                )
            );
        }
    }
}