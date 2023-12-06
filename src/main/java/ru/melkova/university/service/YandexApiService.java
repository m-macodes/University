package ru.melkova.university.service;

import io.netty.handler.logging.LogLevel;
import org.springframework.http.client.reactive.ClientHttpConnector;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;
import reactor.netty.transport.logging.AdvancedByteBufFormat;
import ru.melkova.university.data.form.yandexForm.Component;
import ru.melkova.university.data.form.yandexForm.YandexResponse;

import java.util.List;

@Service
public class YandexApiService {

    private final WebClient webClient;

    public YandexApiService(WebClient.Builder webClientBuilder) {
//        this.webClient = webClientBuilder.baseUrl("https://geocode-maps.yandex.ru/1.x/").build();

        HttpClient httpClient = HttpClient.create()
                .wiretap(this.getClass().getCanonicalName(), LogLevel.DEBUG, AdvancedByteBufFormat.TEXTUAL);
        ClientHttpConnector conn = new ReactorClientHttpConnector(httpClient);

        this.webClient =  WebClient.builder()
                .clientConnector(conn)
                .baseUrl("https://geocode-maps.yandex.ru/1.x/")
                .build();
    }



    public Mono<List<Component>> getComponents(String address) {
        return webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .queryParam("geocode", address)
                        .queryParam("format", "json")
                        .queryParam("apikey", "c64de53a-2a63-4686-a4b4-cb68551ccfce")
                        .build())
                .retrieve()
                .bodyToMono(YandexResponse.class)
                .map(yandexResponse -> yandexResponse.getResponse().getGeoObjectCollection().getFeatureMember().get(0).getGeoObject().getMetaDataProperty().getGeocoderMetaData().getAddress());
    }
}
