FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Install Git (needed for Maven)
RUN apk add --no-cache git

# Copy pom.xml first for better caching
COPY backend/pom.xml ./backend/pom.xml
WORKDIR /app/backend
RUN mvn dependency:go-offline -f pom.xml

# Copy source code and build
COPY backend/src ./src
RUN mvn clean package -DskipTests -f pom.xml

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built JAR
COPY --from=build /app/backend/target/*.jar app.jar

# Expose port (Railway sets PORT env var)
EXPOSE ${PORT:10000}

# Set active profile AND PORT
ENV SPRING_PROFILES_ACTIVE=production
ENV PORT=${PORT:10000}
ENV SERVER_PORT=${PORT:10000}

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
