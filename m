From: Rathgeb Markus <maggu2810@web.de>
Subject: Re: amd64 brightness has lowest value after boot
Date: Sat, 01 Jul 2006 11:39:04 +0000
Message-ID: <44A65ED8.4020206@web.de>
References: <449FBAC8.1060509@web.de> <44A39A07.20408@web.de> <86802c440606302359t406b7dd3g39a6fec2943799a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:1438 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S932567AbWGAJjj
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Jul 2006 05:39:39 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B7B0D604017
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jul 2006 11:39:38 +0200 (CEST)
Received: from [84.157.253.71] (helo=[192.168.0.100])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1Fwbww-0005Qh-00
	for linux-acpi@vger.kernel.org; Sat, 01 Jul 2006 11:39:38 +0200
In-Reply-To: <86802c440606302359t406b7dd3g39a6fec2943799a7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am still using a modified dsdt.

Here the method to decrease the brightness
                Method (_Q12, 0, NotSerialized)
                {
                    Store (0x12, ^^PIB.Z002)
                    Store (0x86, PSCM)
                    Store (Zero, SMIC)
                }

Here the method to increase the brightness
                Method (_Q13, 0, NotSerialized)
                {
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                }

So i changed it to that:
                Method (_Q13, 0, NotSerialized)
                {
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                    Store (0x13, ^^PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                }
Now i press the "increase brightness" key only once and have the highest
value.
But how can i do it automaticly at boot-time.
When i insert the "Store lines" in a other Method that is executed at
boot it do not work.

yhlu wrote:
> You may try to dump the dsdt and modify it and put one compiled
> modified dsdt in your initrd.
> 
> YH
> 

