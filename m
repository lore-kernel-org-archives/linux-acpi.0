From: Chris Vine <chris@cvine.freeserve.co.uk>
Subject: Suspend/hibernate wireless regression with 2.6.33 kernel
Date: Wed, 17 Mar 2010 01:51:13 +0000
Message-ID: <20100317015113.4e833e1c@boulder.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a Lenovo S12 (Ideapad) netbook with a BCM4312 802.11b/g
[14e4:4315] wireless device.  Although this works using the PIO option
in kernel 2.6.33/2.6.33.1 (not with DMA) using the in-kernel b43 driver,
and also works with the broadcom proprietary wl driver, it breaks after
a suspend or hibernate. Attempts to bring up the wlan0 interface with
'ifconfig wlan0 up' after suspension or hibernation results in the
following message (although nothing is revealed by dmesg):

  SIOCSIFFLAGS: Unknown error 132

More worryingly, when suspending or hibernating, acpi sometimes
but not always appears to write to the CMOS.  On two occasions I
have observed that although a reboot into 2.6.33 would work (until there
is another suspension or hibernation), wireless becomes permanently
switched off when rebooting into 2.6.32 or earlier - when reading
from the BIOS, kernel 2.6.32 and below appears to think that the radio
has been disabled even though the BIOS set-up screen disagrees. When
this occurs, I have to restore all defaults in the BIOS to get wireless
to come on again in kernel 2.6.32 and less.

This is not b43 specific, as I get exactly the same effect using the
broadcom wl driver.  Suspension works in kernel 2.6.32 and
below with the wl driver, but not with kernel 2.6.33/2.6.33.1.

If I unload the b43 and related modules before suspending or
hibernating, and then reload them on resuming, I get more information
from dmesg, namely that it thinks that the wireless has been turned off
by the rfkill button, which it definitely has not:

*****

Restarting tasks ... done.
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: 00
    (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
    (2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
    (2457000 KHz - 2482000 KHz @ 20000 KHz), (600 mBi, 2000 mBm)
    (2474000 KHz - 2494000 KHz @ 20000 KHz), (600 mBi, 2000 mBm)
    (5170000 KHz - 5250000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
    (5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
cfg80211: Calling CRDA to update world regulatory domain
b43-pci-bridge 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
b43-pci-bridge 0000:03:00.0: setting latency timer to 64
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x16, vendor 0x4243)
ssb: Core 1 found: IEEE 802.11 (cc 0x812, rev 0x0F, vendor 0x4243)
ssb: Core 2 found: PCMCIA (cc 0x80D, rev 0x0A, vendor 0x4243)
ssb: Core 3 found: PCI-E (cc 0x820, rev 0x09, vendor 0x4243)
ssb: Sonics Silicon Backplane found on PCI device 0000:03:00.0
b43-phy0: Broadcom 4312 WLAN found (core revision 15)
b43-phy0 debug: Found PHY: Analog 6, Type 5, Revision 1
b43-phy0 debug: Found Radio: Manuf 0x17F, Version 0x2062, Revision 2
phy0: Selected rate control algorithm 'minstrel'
Registered led device: b43-phy0::tx
Registered led device: b43-phy0::rx
Registered led device: b43-phy0::radio
Broadcom 43xx driver loaded [ Features: PMLS, Firmware-ID: FW13 ]
b43 ssb0:0: firmware: requesting b43/ucode15.fw
b43 ssb0:0: firmware: requesting b43/lp0initvals15.fw
b43 ssb0:0: firmware: requesting b43/lp0bsinitvals15.fw
b43-phy0: Loading firmware version 478.104 (2008-07-01 00:50:23)
b43-phy0 debug: b2062: Using crystal tab entry 19200 kHz.
b43-phy0 debug: Chip initialized
b43-phy0 debug: PIO initialized
b43-phy0 debug: QoS enabled
b43-phy0 debug: Wireless interface started
b43-phy0 debug: Adding Interface type 2
b43-phy0: Radio hardware status changed to DISABLED
b43-phy0: Radio turned on by software
b43-phy0: The hardware RF-kill button still turns the radio physically
off. Press the button to turn it on. b43-phy0 debug: Removing Interface
type 2 b43-phy0 debug: Wireless interface stopped

*****

The rfkill button on this netbook is a slider switch with 'on' and
'off' positions.  As far as I can tell, bluetooth works normally
although I have not tested this extensively (I got a bit spooked when I
found the CMOS was being interfered with).

Chris
