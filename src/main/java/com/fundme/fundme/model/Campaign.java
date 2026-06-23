package com.fundme.fundme.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "campaigns")
public class Campaign {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(length = 1000)
    private String description;

    @Column(nullable = false)
    private Double goalAmount;

    private Double raisedAmount = 0.0;

    private String createdBy;

    private LocalDateTime createdAt = LocalDateTime.now();
}
