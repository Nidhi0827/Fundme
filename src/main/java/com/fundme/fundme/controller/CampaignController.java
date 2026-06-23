package com.fundme.fundme.controller;

import com.fundme.fundme.model.Campaign;
import com.fundme.fundme.repository.CampaignRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/campaigns")
public class CampaignController {

    @Autowired
    private CampaignRepository campaignRepository;

    // API 1 - Create a new campaign
    @PostMapping
    public ResponseEntity<Campaign> createCampaign(@RequestBody Campaign campaign) {
        Campaign saved = campaignRepository.save(campaign);
        return ResponseEntity.ok(saved);
    }

    // API 2 - Get all campaigns
    @GetMapping
    public ResponseEntity<List<Campaign>> getAllCampaigns() {
        List<Campaign> campaigns = campaignRepository.findAll();
        return ResponseEntity.ok(campaigns);
    }

    // API 3 - Donate to a campaign
    @PostMapping("/{id}/donate")
    public ResponseEntity<Campaign> donate(
            @PathVariable Long id,
            @RequestParam Double amount) {

        Optional<Campaign> optional = campaignRepository.findById(id);

        if (optional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Campaign campaign = optional.get();
        campaign.setRaisedAmount(campaign.getRaisedAmount() + amount);
        campaignRepository.save(campaign);

        return ResponseEntity.ok(campaign);
    }
}
