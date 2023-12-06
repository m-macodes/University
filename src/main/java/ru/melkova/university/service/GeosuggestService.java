package ru.melkova.university.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.melkova.university.data.domain.Address;

@Service
@RequiredArgsConstructor
public class GeosuggestService {
    private RestTemplate restTemplate = new RestTemplate();
    private static final String geoApi = "https://suggest-maps.yandex.ru/v1/suggest?apikey=f2ef3431-5c7d-4dba-a196-1882eadbd448&text=%s";

    public Address getFullAddress(String adress) {
        return null;
    }
}
