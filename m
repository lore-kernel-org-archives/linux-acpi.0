From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sun, 9 Nov 2008 00:33:37 +0100
Message-ID: <20081108233337.GA21200@gamma.logic.tuwien.ac.at>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <20081108213414.579e178d@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:53596 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbYKHXdj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 18:33:39 -0500
Content-Disposition: inline
In-Reply-To: <20081108213414.579e178d@mjolnir.drzeus.cx>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: linux-acpi@vger.kernel.org

Hi Pierre,

On Sa, 08 Nov 2008, Pierre Ossman wrote:
> The reader worked once you had a card in there in those cases. Could
> you enable MMC_DEBUG in the kernel config and see what you get in dmesg
> when you insert a card.

I have inserted a card and did a reboot into the kernel with MMC_DEBUG
enabled and got that (irrelevant lines removed):


[    2.797345] sdhci: Secure Digital Host Controller Interface driver
[    2.797399] sdhci: Copyright(c) Pierre Ossman
[    2.797461] sdhci-pci 0000:0b:04.2: SDHCI controller found [1180:0822] (rev 21)
[    2.797533] sdhci-pci 0000:0b:04.2: found 1 slot(s)
[    2.797542] sdhci-pci 0000:0b:04.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    2.896956] mmc0: Reset 0x1 never completed.
[    2.897008] sdhci: ============== REGISTER DUMP ==============
[    2.897019] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    2.897023] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    2.897027] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    2.897031] sdhci: Present:  0x00030000 | Host ctl: 0x00000000
[    2.897034] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    2.897038] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[    2.897042] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    2.897046] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    2.897049] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    2.897052] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    2.897053] sdhci: ===========================================
[    2.897057] sdhci-pci 0000:0b:04.2: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.897129] sdhci-pci 0000:0b:04.2: setting latency timer to 64
[    2.996456] mmc0: Reset 0x1 never completed.
[    2.996507] sdhci: ============== REGISTER DUMP ==============
[    2.996510] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    2.996513] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    2.996516] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    2.996520] sdhci: Present:  0x00030000 | Host ctl: 0x00000000
[    2.996523] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    2.996526] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[    2.996529] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    2.996532] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    2.996535] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    2.996538] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    2.996539] sdhci: ===========================================
[    2.996541] sdhci: ============== REGISTER DUMP ==============
[    2.996543] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    2.996547] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    2.996550] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    2.996553] sdhci: Present:  0x00030000 | Host ctl: 0x00000000
[    2.996556] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    2.996559] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[    2.996562] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    2.996565] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    2.996568] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    2.996572] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    2.996573] sdhci: ===========================================
[    2.996581] PM: Adding info for No Bus:mmc0
[    2.996632] Registered led device: mmc0
[    2.996729] PM: Adding info for No Bus:mmc0
[    2.996755] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    3.000612] mmc0: Reset 0x1 never completed.
[    3.000612] sdhci: ============== REGISTER DUMP ==============
[    3.000612] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[    3.000612] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    3.000612] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    3.000612] sdhci: Present:  0x00030000 | Host ctl: 0x00000000
[    3.000612] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    3.000612] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[    3.000612] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    3.000612] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[    3.000612] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    3.000612] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[    3.000612] sdhci: ===========================================
[    3.096174] mmc0: SDHCI controller on PCI [0000:0b:04.2] using DMA
[    3.096208] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    3.098194] mmc0: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    3.100184] mmc0: clock 128906Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    3.101179] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    3.101223] ricoh-mmc: Ricoh MMC Controller disabling driver
[    3.101282] ricoh-mmc: Copyright(c) Philip Langdale
[    3.488968] usb 1-2: New USB device found, idVendor=05ca, idProduct=18b0
[    3.489028] usb 1-2: New USB device strings: Mfr=1, Product=0, SerialNumber=0
[    3.489084] usb 1-2: Manufacturer: Ricoh co. Ltd.

[   13.104029] mmc0: Timeout waiting for hardware interrupt.
[   13.104083] sdhci: ============== REGISTER DUMP ==============
[   13.104087] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   13.104090] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   13.104093] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   13.104096] sdhci: Present:  0x00030000 | Host ctl: 0x00000000
[   13.104100] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   13.104103] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   13.104106] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   13.104109] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   13.104112] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   13.104116] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   13.104117] sdhci: ===========================================
[   13.108026] mmc0: Reset 0x2 never completed.
[   13.108026] sdhci: ============== REGISTER DUMP ==============
[   13.108026] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   13.108026] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   13.108026] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   13.108026] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000000
[   13.108026] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   13.108026] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   13.108026] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   13.108026] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   13.108026] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   13.108026] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   13.108026] sdhci: ===========================================
[   13.108026] mmc0: Reset 0x4 never completed.
[   13.108026] sdhci: ============== REGISTER DUMP ==============
[   13.108026] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   13.108026] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   13.108026] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   13.108026] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000000
[   13.108026] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   13.108026] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   13.108026] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   13.108026] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   13.108026] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   13.108026] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   13.108026] sdhci: ===========================================
[   13.302923] mmc0: req done (CMD0): -110: 00000000 00000000 00000000 00000000
[   13.303937] mmc0: clock 128906Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[   13.304933] mmc0: starting CMD8 arg 000001aa flags 000002f5

[   23.300042] mmc0: Timeout waiting for hardware interrupt.
[   23.300096] sdhci: ============== REGISTER DUMP ==============
[   23.300100] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   23.300103] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   23.300106] sdhci: Argument: 0x000001aa | Trn mode: 0x00000000
[   23.300109] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   23.300112] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   23.300115] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   23.300118] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   23.300121] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   23.300124] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   23.300127] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   23.300129] sdhci: ===========================================
[   23.302120] mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[   23.302129] mmc0: starting CMD5 arg 00000000 flags 000002e1

[   33.300096] mmc0: Timeout waiting for hardware interrupt.
[   33.300179] sdhci: ============== REGISTER DUMP ==============
[   33.300187] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   33.300193] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   33.300200] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   33.300206] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   33.300212] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   33.300219] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   33.300225] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   33.300231] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   33.300237] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   33.300244] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   33.300248] sdhci: ===========================================
[   33.302244] mmc0: req failed (CMD5): -110, retrying...

[   43.304038] mmc0: Timeout waiting for hardware interrupt.
[   43.304108] sdhci: ============== REGISTER DUMP ==============
[   43.304115] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   43.304122] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   43.304128] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   43.304135] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   43.304141] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   43.304148] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   43.304154] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   43.304160] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   43.304166] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   43.304173] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   43.304177] sdhci: ===========================================
[   43.306172] mmc0: req failed (CMD5): -110, retrying...

[   53.684073] mmc0: Timeout waiting for hardware interrupt.
[   53.684080] sdhci: ============== REGISTER DUMP ==============
[   53.684087] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   53.684094] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   53.684100] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   53.684106] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   53.684113] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   53.684119] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   53.684125] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   53.684132] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   53.684138] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   53.684145] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   53.684148] sdhci: ===========================================
[   53.686167] mmc0: req failed (CMD5): -110, retrying...

[   63.684044] mmc0: Timeout waiting for hardware interrupt.
[   63.684126] sdhci: ============== REGISTER DUMP ==============
[   63.684134] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   63.684140] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   63.684147] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   63.684154] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   63.684161] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   63.684167] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   63.684173] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   63.684180] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   63.684186] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   63.684192] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   63.684196] sdhci: ===========================================
[   63.686193] mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[   63.686219] mmc0: starting CMD55 arg 00000000 flags 000000f5

[   73.684092] mmc0: Timeout waiting for hardware interrupt.
[   73.684175] sdhci: ============== REGISTER DUMP ==============
[   73.684182] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   73.684188] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   73.684195] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   73.684201] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   73.684207] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   73.684214] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   73.684220] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   73.684226] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   73.684233] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   73.684239] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   73.684243] sdhci: ===========================================
[   73.686260] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[   73.686305] mmc0: starting CMD55 arg 00000000 flags 000000f5

[   83.684054] mmc0: Timeout waiting for hardware interrupt.
[   83.684124] sdhci: ============== REGISTER DUMP ==============
[   83.684132] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
[   83.684138] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   83.684145] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   83.684151] sdhci: Present:  0x01ff0001 | Host ctl: 0x00000001
[   83.684157] sdhci: Power:    0x0000000e | Blk gap:  0x00000000
[   83.684164] sdhci: Wake-up:  0x00000000 | Clock:    0x00008007
[   83.684170] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   83.684176] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   83.684183] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   83.684189] sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
[   83.684193] sdhci: ===========================================
[   83.686190] mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
[   83.686215] mmc0: starting CMD55 arg 00000000 flags 000000f5

Let me know if I can be of any other help, and big thanks for taking a
look at it.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CORRIEARKLET (n.)
The moment at which two people approaching from opposite ends of a
long passageway, recognise each other and immediately pretend they
haven't. This is to avoid the ghastly embarrassment of having to
continue recognising each other the whole length of the corridor.
			--- Douglas Adams, The Meaning of Liff
