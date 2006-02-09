From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Date: Thu, 9 Feb 2006 17:47:49 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0602091747070.30108@yvahk01.tjqt.qr>
References: <20060207133456.GA2452@srcf.ucam.org> <20060208090757.GB11895@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:13261 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161073AbWBIQr6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 11:47:58 -0500
In-Reply-To: <20060208090757.GB11895@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>> The included patch adds support for interacting with the toshiba_acpi 
>> backlight control through the generic backlight interface 
>> (/sys/class/backlight).
>> 
>> ACPI folk: this gives us the benefit of a consistent interface to LCD 
>> brightness. Is it worth me converting the other drivers over?
>
>Not sure if I'm ACPI folk but yes, consistent interface would be nice.
>
Note to self: Don't forget to change 2.6-sony-acpi?.diff from -mm to use 
this /sys/class/backlight instead of /proc/acpi/sony/brightness when it's 
ready.


Jan Engelhardt
-- 
