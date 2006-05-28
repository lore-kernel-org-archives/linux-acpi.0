From: Johannes Engel <j-engel@gmx.de>
Subject: Error with ASUS V6V and Ricoh CardReader
Date: Sun, 28 May 2006 12:22:55 +0200
Message-ID: <447979FF.5010707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:38551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750700AbWE1KXL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 May 2006 06:23:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pierre Ossman <drzeus-list@drzeus.cx>

Good morning everyone here!

Beeing just new to this ml Pierre Ossman told me to forward my problem
to you to ask if you know anything about what to do.
The problem is that my ASUS V6V seems not to initialize the SD card
reader in a proper way coming out of suspend. Since there is already an
original dsdt posted on acpi.sf.net I won't add mine (also BIOS revision
1201).
Please let me know if you need any further information.

-------- Original-Nachricht --------
Betreff: 	Re: [Sdhci-devel] Ricoh controller message after suspend and
resume
Datum: 	Sat, 27 May 2006 23:04:13 +0200
Von: 	Johannes Engel <j-engel@gmx.de>
An: 	Pierre Ossman <drzeus-list@drzeus.cx>
CC: 	sdhci-devel@list.drzeus.cx
Referenzen: 	<447889F3.1060704@gmx.de> <447891C8.3040406@drzeus.cx>



Pierre Ossman schrieb:
> Johannes Engel wrote:
>   
>> sdhci: Secure Digital Host Controller Interface driver, 0.12
>> sdhci: Copyright(c) Pierre Ossman
>> sdhci: SDHCI controller found at 0000:03:01.2 [1180:0822] (rev 17)
>> ACPI: PCI Interrupt 0000:03:01.2[C] -> GSI 18 (level, low) -> IRQ 209
>> : Reset 0x1 never completed. Please report this to
>> <sdhci-devel@list.drzeus.cx>.
>> sdhci: ============== REGISTER DUMP ==============
>> sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
>> sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
>> sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
>> sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
>> sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
>> sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
>> sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
>> sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
>> sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
>> sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
>> sdhci: ===========================================
>> sdhci:slot0: Unknown controller version (255). Cowardly refusing to
>> continue.
>>     
>
> I don't suppose this is an Asus machine? :)
>
> The hardware isn't properly set up on resume, so ther isn't much the
> driver can do. You'll have to talk to the guys at acpi.sf.net and see if
> they have any ideas.
This is in fact an ASUS machine: V6V. The problem persited a complete
restart. Booting Windows and again Linux solved the problem.


Greetings, Johannes


