FROM openjdk:8

ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK_ROOT /opt/android-sdk
ARG ANDROID_SDK_VERSION=4333796
ARG SDKMANAGER=/opt/android-sdk/tools/bin/sdkmanager

# Install the Android SDK
RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    curl -s https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o sdk.zip && \
    unzip sdk.zip && \
    rm sdk.zip && \
    yes | ${SDKMANAGER} --licenses

# Install build tools
ARG ANDROID_VERSION=26
ARG ANDROID_BUILD_TOOLS_VERSION=26.0.2
RUN ${SDKMANAGER} --update
RUN ${SDKMANAGER} "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_VERSION}" "platform-tools"

RUN mkdir src
WORKDIR src
