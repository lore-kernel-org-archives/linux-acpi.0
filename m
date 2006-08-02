From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Sony ACPI extras mainline inclusion
Date: Wed, 2 Aug 2006 16:34:50 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608021634370.13053@yvahk01.tjqt.qr>
References: <44CB288A.1010702@gmail.com> <20060802100314.GF7601@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:5567 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750922AbWHBOgZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2006 10:36:25 -0400
In-Reply-To: <20060802100314.GF7601@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alessandro Guido <alessandro.guido.box@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


>> I own a Sony VAIO laptop that uses ACPI for setting 
>> screen brightness
>> through the "2.6-sony_acpi4.patch" patch that has been 
>> living in -mm for a while.
>> I'd like this patch to be merged in mainline, so that I 
>> won't be forced anymore to patch
>> the kernel by hand or to use the -mm patchset.
>> Is there something that prevents this to happen?
>
>Wrong interface?
>
>Convert it to use /sys/class/backlight sysfs interface...

FWIW, the patch works without having to apply all of -mm.


Jan Engelhardt
-- 
