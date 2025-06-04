# Use a Maven image to build the application
FROM maven:3.8.7-eclipse-temurin-17 AS builder

# Set working directory inside the container
WORKDIR /app

# Copy everything to the container
COPY . .

# Build the application (creates target/*.jar)
RUN mvn clean package -DskipTests

# -------------------------

# Use a lightweight JRE to run the app
FROM eclipse-temurin:17-jre

# Set working directory for the app
WORKDIR /app

# Copy the jar from the build stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port (change if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
