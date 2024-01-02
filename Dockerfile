ARG BUILD_FROM
FROM $BUILD_FROM
ENV LANG C.UTF-8

# Build arugments
ARG BUILD_VERSION
ARG BUILD_ARCH


COPY requirements.txt ./
RUN apk add --no-cache python3-dev py3-pip g++
RUN pip install --upgrade pycryptodomex~=3.11.0
RUN pip install --upgrade PyYAML==5.3.1
RUN pip install --upgrade requests==2.26.0
RUN pip install --upgrade paho-mqtt==1.5.1
RUN pip install --upgrade pymodbus==2.5.3
RUN pip install --upgrade SungrowModbusTcpClient==0.1.6
RUN pip install --upgrade SungrowModbusWebClient==0.3.2
RUN pip install --upgrade readsettings==3.4.5
# RUN pip install --upgrade pycryptodomex==3.11.0 --no-cache-dir -r requirements.txt
# Modified cryptodomex to ~= from == GRL

COPY SunGather/ /
COPY SunGather/exports/ /exports
COPY run.sh /
COPY config_generator.py /

VOLUME /logs
VOLUME /config
# Install requirements for add-on
RUN chmod a+x /run.sh

CMD ["/run.sh"]

LABEL \ 
    io.hass.name="ModbusTCP2MQTT" \
    io.hass.description="Sungrow-SMA Solar inverter communication Addon" \
    io.hass.version=${BUILD_VERSION} \
    io.hass.type="addon" \
    io.hass.arch=${BUILD_ARCH}
