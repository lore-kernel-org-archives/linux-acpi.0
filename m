From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Date: Thu, 9 Feb 2006 18:17:28 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0602091815390.30108@yvahk01.tjqt.qr>
References: <20060207133456.GA2452@srcf.ucam.org> <20060208090757.GB11895@elf.ucw.cz>
 <Pine.LNX.4.61.0602091747070.30108@yvahk01.tjqt.qr> <20060209165407.GA20754@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:44950 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965243AbWBIRRd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2006 12:17:33 -0500
In-Reply-To: <20060209165407.GA20754@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>
>> Note to self: Don't forget to change 2.6-sony-acpi?.diff from -mm to use 
>> this /sys/class/backlight instead of /proc/acpi/sony/brightness when it's 
>> ready.
>
>Ah, you're maintaining that now. Here you go (Stelian took a look and 
>seemed happy with it - the /sys/class/backlight stuff is in mainstream)
>
Well, I am not. At least not-yet-officially. But since I happen to have 
that hardware, I use it. (And I even have to postpatch the SUSE KOTD ATM
to get there, heh, heh.)



Jan Engelhardt
-- 
