# Step 1 - Start with Java 21 base image
FROM eclipse-temurin:21-jdk-alpine

# Step 2 - Set working directory inside container
WORKDIR /app

# Step 3 - Copy Maven wrapper and pom.xml first
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Step 4 - Download dependencies
RUN ./mvnw dependency:go-offline -B

# Step 5 - Copy source code
COPY src src

# Step 6 - Build the application
RUN ./mvnw package -DskipTests

# Step 7 - Expose port 8080
EXPOSE 8080

# Step 8 - Run the application
CMD ["java", "-jar", "target/fundme-0.0.1-SNAPSHOT.jar"]