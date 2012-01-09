From: Jamie Kitson <jamie@kitten-x.com>
Subject: /sys/class/power_supply/BAT0/ charge_ vs energy_
Date: Mon, 9 Jan 2012 12:10:00 +0000
Message-ID: <CA+z-pWE9LmEiYDxVAbdR7GhO=C5fiDf1QozO2n4v0fQ4V6hrNQ@mail.gmail.com>
References: <CA+z-pWGrhtT3m=tOXcCDph3TC6AcbTVQJTF35V-o5MHeAB=HCg@mail.gmail.com>
 <CA+z-pWHyhVO16AGz-fxmDhTyO0xXGfOB-_pPQZjMqf4vBUZw_g@mail.gmail.com>
 <CA+z-pWHPj-_ZA0v+siLaVtwFtyd-tDFM5+71s3j6ng3=pWGu0Q@mail.gmail.com>
 <CA+z-pWGJ_sFh138kgZh-oX=rwv3t_LRDvgCvdGxuxnMDegxgaA@mail.gmail.com>
 <CA+z-pWEtiW9Rc9yjXNZSc7daFRwDieYb3Bnxt6=m+G+k_ELL8g@mail.gmail.com> <CA+z-pWGmiRvpYQWQwb-f9TjH18k1pvu1rbOPUuF1t9-m3HvHqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59528 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab2AIMKW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2012 07:10:22 -0500
Received: by werm1 with SMTP id m1so2548265wer.19
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2012 04:10:21 -0800 (PST)
In-Reply-To: <CA+z-pWGmiRvpYQWQwb-f9TjH18k1pvu1rbOPUuF1t9-m3HvHqA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hi,

I have an issue with my Arch installation on an X220 laptop.

Linux jamie-laptop 3.1.5-1-ARCH #1 SMP PREEMPT Sat Dec 10 14:43:09 CET
2011 x86_64 Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz GenuineIntel
GNU/Linux

If I boot with AC plugged in the /sys/class/power_supply/BAT0/
directory is populated with charge_*, but if I boot on battery the
directory is populated with energy_*.

Disconnecting/connecting the power after boot does not effect the file names.

Is this a bug or a feature? It makes scripts harder to write than necessary.

Thanks, Jamie

ps, I really think
http://www.lesswatts.org/projects/acpi/mailing-lists.php needs
updating.
