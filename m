From: Jamie Kitson <jamie@kitten-x.com>
Subject: /sys/class/power_supply/BAT0/ charge_ vs energy_
Date: Mon, 9 Jan 2012 11:31:59 +0000
Message-ID: <CA+z-pWGmiRvpYQWQwb-f9TjH18k1pvu1rbOPUuF1t9-m3HvHqA@mail.gmail.com>
References: <CA+z-pWGrhtT3m=tOXcCDph3TC6AcbTVQJTF35V-o5MHeAB=HCg@mail.gmail.com>
 <CA+z-pWHyhVO16AGz-fxmDhTyO0xXGfOB-_pPQZjMqf4vBUZw_g@mail.gmail.com>
 <CA+z-pWHPj-_ZA0v+siLaVtwFtyd-tDFM5+71s3j6ng3=pWGu0Q@mail.gmail.com>
 <CA+z-pWGJ_sFh138kgZh-oX=rwv3t_LRDvgCvdGxuxnMDegxgaA@mail.gmail.com> <CA+z-pWEtiW9Rc9yjXNZSc7daFRwDieYb3Bnxt6=m+G+k_ELL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57757 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2AILcV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2012 06:32:21 -0500
Received: by wgbdr10 with SMTP id dr10so1658066wgb.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2012 03:32:20 -0800 (PST)
In-Reply-To: <CA+z-pWEtiW9Rc9yjXNZSc7daFRwDieYb3Bnxt6=m+G+k_ELL8g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

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
