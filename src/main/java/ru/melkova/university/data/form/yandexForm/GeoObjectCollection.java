package ru.melkova.university.data.form.yandexForm;

import lombok.Data;

import java.util.List;

@Data
public class GeoObjectCollection {
    private List<FeatureMember> featureMember;
}
