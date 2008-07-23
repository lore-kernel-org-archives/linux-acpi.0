From: TJ <linux@tjworld.net>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 23 Jul 2008 08:13:25 +0100
Message-ID: <1216797205.8160.15.camel@hephaestion.lan.tjworld.net>
References: <1216148382.6135.21.camel@alok-dev1>
	 <1216330272.32324.26.camel@alok-dev1> <1216663147.26169.5.camel@alok-dev1>
	 <200807221450.52114.jbarnes@virtuousgeek.org>
	 <1216767168.5693.31.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1216767168.5693.31.camel@alok-dev1>
Sender: linux-pci-owner@vger.kernel.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Alok's observations about the ACPI PCI0._CRS() package ResourceProducer
AddressRangeMemory definitions is the same approach as my optional
PCI-DRAM approach. Possibly where we differ is in how much weight is
given to the DSDT values since I found whilst analysing several hundred
DSDTs over the past year or so that the values returned could often be
'iffy' or over-vealous.

For example, there's a bug in the DSDT of many Sony Vaios whereby the
Intel 945 PCI Root Bridge's TOLUD (Top Of Low User Dynamic ram) register
is defined as a 6-bit wide field rather than the actual 5 bits, and is
then used in _CRS() by the AML to calculate and set the min, max, and
length of a range that represents installed RAM.

I've also seen instances of large areas being reserved 'just in case'
which might be all very well for servers with realistic hot-plug
opportunities but definitely cramps the style for notebooks and most
desktops.

I've decided to publish my code so at least others evaluate it and get
some experience of real-world situations. It provides command-line
over-rides for all options so it is easy to try different policies, and
via sysfs it can be changed on-the-fly. I'm not going to propose it as a
patch-set for submission yet, though.

It'll be next week before I get chance to publish - so much to do, too
much fun to be had!

TJ.
