From: "Neil Watson" <nowatson@gmail.com>
Subject: Re: RF devices disabled after returning from suspend to disk
Date: Sat, 6 Feb 2010 00:07:05 -0000
Message-ID: <1F0B887000944B21B56E783F643EB07D@BENQ>
References: <de254a1a1002051235p6b9ce4edm79bd46a58f46eb40@mail.gmail.com> <20100205212932.GA15643@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46733 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933870Ab0BFAHd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2010 19:07:33 -0500
Received: by ewy28 with SMTP id 28so638688ewy.28
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2010 16:07:31 -0800 (PST)
In-Reply-To: <20100205212932.GA15643@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

----- Original Message ----- 
From: "Matthew Garrett" <mjg59@srcf.ucam.org>
To: "Neil Watson" <nowatson@gmail.com>
Cc: <linux-acpi@vger.kernel.org>
Sent: Friday, February 05, 2010 9:29 PM
Subject: Re: RF devices disabled after returning from suspend to disk

>
>A description of the hardware would be helpful.
>


It is a Novatech laptop, model X65- a rebranded FIC PMN70D - 
http://www.fic.com.tw/product/pmn70d.aspx

# lspci
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory 
Controller Hub (rev 07)
00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI Express 
Graphics Port (rev07)
00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #5 (rev 03)
00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #6 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #2 (rev03)
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio 
Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 
1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 
2 (rev 03)
00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 
6 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #1 (rev03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller (rev 
03)
00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI Controller 
(rev 03)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 
03)
01:00.0 VGA compatible controller: nVidia Corporation Device 0652 (rev a1)
04:00.0 Network controller: Atheros Communications Inc. AR928X Wireless 
Network Adapter (PCIExpress) (rev 01)
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B 
PCI Express Gigabit Ethernet controller (rev 03)


computer
  net_0a_b4_81_ff_97_53
  computer_logicaldev_input_4
  acpi_CPU0
  acpi_CPU1
  computer_alsa_timer
  computer_alsa_sequencer
  net_computer_loopback
  computer_logicaldev_input_3
  computer_backlight
  computer_logicaldev_input_2
  computer_logicaldev_input_1
  computer_power_supply_battery_BAT0
  computer_logicaldev_input_0
  computer_power_supply_ac_adapter_ACAD
  computer_logicaldev_input
  pnp_PNP0c02_0
  pnp_PNP0f13
  pnp_PNP0303
  pnp_PNP0b00
  pnp_PNP0c02
  pnp_PNP0c04
  pnp_PNP0103
  pnp_INT0800
  pnp_PNP0200
  pnp_PNP0a08
  platform_vesafb_0
  platform_serial8250
  platform_regulatory_0
  platform_pcspkr
  platform_iTCO_wdt
  platform_i8042
    platform_i8042_i8042_AUX3_port
      platform_i8042_i8042_AUX3_port_logicaldev_input_0
      platform_i8042_i8042_AUX3_port_logicaldev_input
    platform_i8042_i8042_AUX2_port
    platform_i8042_i8042_AUX1_port
    platform_i8042_i8042_AUX0_port
    platform_i8042_i8042_KBD_port
      platform_i8042_i8042_KBD_port_logicaldev_input
  platform_Fixed_MDIO_bus_0
  pci_8086_2930
  pci_8086_2929
    pci_8086_2929_scsi_host_4
    pci_8086_2929_scsi_host_3
    pci_8086_2929_scsi_host_2
    pci_8086_2929_scsi_host_1
      pci_8086_2929_scsi_host_1_scsi_host
      pci_8086_2929_scsi_host_1_scsi_device_lun0
        storage_model_BDDVDRW_CT10N
          volume_label_VCD7232
        pci_8086_2929_scsi_host_1_scsi_device_lun0_scsi_generic
    pci_8086_2929_scsi_host_0
      pci_8086_2929_scsi_host_0_scsi_host
      pci_8086_2929_scsi_host_0_scsi_device_lun0
        storage_serial_ST9160310AS_5SV4EW92
          volume_part4_size_49351680
          volume_part1_size_1024
          volume_uuid_UDFo6n_Q2v1_Y2lq_WgD2_fh0Y_Z7oz_neIFJc
          volume_uuid_fb8d5fd8_8cc9_45a1_92d3_1cd7d599fd90
          volume_uuid_CCED_990E
          volume_uuid_A000B2F200B2CF12
        pci_8086_2929_scsi_host_0_scsi_device_lun0_scsi_generic
    pci_8086_2929_scsi_host
      pci_8086_2929_scsi_host_scsi_host
      pci_8086_2929_scsi_host_scsi_device_lun0
        storage_serial_ST9500420AS_5VJ19E6S
          volume_uuid_DUP2Fm_Zu65_s0kQ_RrAA_3zE4_hJ1C_ilEgrY
          volume_uuid_92bb4a0b_281d_4f26_a685_6d818a818848
          volume_uuid_7E704D85704D455D
        pci_8086_2929_scsi_host_scsi_device_lun0_scsi_generic
  pci_8086_2919
  pci_8086_2448
  pci_8086_293a
    usb_device_1d6b_2_0000_00_1d_7
      usb_device_1d6b_2_0000_00_1d_7_if0
  pci_8086_2936
    usb_device_1d6b_1_0000_00_1d_2
      usb_device_45e_53_noserial
        usb_device_45e_53_noserial_if0
          usb_device_45e_53_noserial_if0_logicaldev_input
      usb_device_1d6b_1_0000_00_1d_2_if0
  pci_8086_2935
    usb_device_1d6b_1_0000_00_1d_1
      usb_device_1d6b_1_0000_00_1d_1_if0
  pci_8086_2934
    usb_device_1d6b_1_0000_00_1d_0
      usb_device_1d6b_1_0000_00_1d_0_if0
  pci_8086_294a
    pci_10ec_8168
      net_00_14_0b_66_67_60
  pci_8086_2942
    pci_168c_2a
      net_00_25_d3_99_bf_56
      leds_ath9k_phy0_tx
      leds_ath9k_phy0_rx
      leds_ath9k_phy0_radio
      leds_ath9k_phy0_assoc
      pci_168c_2a_rfkill_phy0_wlan
  pci_8086_2940
  pci_8086_293e
    pci_8086_293e_sound_card_0
      pci_8086_293e_sound_card_0_alsa_capture_2
      pci_8086_293e_sound_card_0_alsa_playback_1
      pci_8086_293e_sound_card_0_alsa_playback_0
      pci_8086_293e_sound_card_0_alsa_capture_0
      pci_8086_293e_sound_card_0_alsa_hw_specific_0
      pci_8086_293e_sound_card_0_alsa_control__1
    pci_8086_293e_logicaldev_input
  pci_8086_293c
    usb_device_1d6b_2_0000_00_1a_7
      usb_device_1d6b_2_0000_00_1a_7_if0
  pci_8086_2939
    usb_device_1d6b_1_0000_00_1a_2
      usb_device_a12_1_noserial
        usb_device_a12_1_noserial_if1
        usb_device_a12_1_noserial_if0
          usb_device_a12_1_noserial_if0_bluetooth_hci_0
            usb_device_a12_1_noserial_if0_bluetooth_hci_0_rfkill_hci0_bluetooth
      usb_device_1d6b_1_0000_00_1a_2_if0
  pci_8086_2938
    usb_device_1d6b_1_0000_00_1a_1
      usb_device_1d6b_1_0000_00_1a_1_if0
  pci_8086_2937
    usb_device_1d6b_1_0000_00_1a_0
      usb_device_1d6b_1_0000_00_1a_0_if0
  pci_8086_2a41
    pci_10de_652
  pci_8086_2a40 

