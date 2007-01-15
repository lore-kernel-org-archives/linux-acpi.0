From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 0/11] sony_acpi: prepare for prime time (resend)
Date: Mon, 15 Jan 2007 20:12:50 +0100
Message-ID: <20070115191250.GA6912@inferi.kami.home>
References: <11687258812893-git-send-email-malattia@linux.it> <3877989d0701150101y1098e27ep26c1df0798292997@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:49973 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXAOTOS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jan 2007 14:14:18 -0500
Content-Disposition: inline
In-Reply-To: <3877989d0701150101y1098e27ep26c1df0798292997@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hello and sorry for the delay

On Mon, Jan 15, 2007 at 04:01:14AM -0500, Luming Yu wrote:
> Patch series is not clean against 2.6.20-rc5.
> 
> patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_va
> io.patch
> patching file Documentation/acpi/sony_acpi.txt
> patching file drivers/acpi/Kconfig
> Hunk #1 succeeded at 252 with fuzz 2 (offset -9 lines).
> patching file drivers/acpi/Makefile
> Hunk #1 FAILED at 54.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/Makefile.rej
> patching file drivers/acpi/sony_acpi.c
...

uh. I'm developing on the acpi tree test branch, however I just tried
the patches on a freshly unpacked/patched .20-rc5 and the patches apply
without any reject.

# for i in ../*.patch ; do patch -p1 < $i ; done
patching file Documentation/acpi/sony_acpi.txt
patching file drivers/acpi/Kconfig
Hunk #1 succeeded at 252 (offset -9 lines).
patching file drivers/acpi/Makefile
Hunk #1 succeeded at 53 (offset -1 lines).
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/Kconfig
Hunk #1 succeeded at 255 (offset -9 lines).
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c
patching file drivers/acpi/sony_acpi.c

> patch -p1 < ../malattia_sony/2_avoid_dimness_on_resume.patch
> patching file drivers/acpi/sony_acpi.c
> Hunk #1 succeeded at 46 with fuzz 2.
> Hunk #2 FAILED at 56.
> Hunk #3 FAILED at 228.
> Hunk #4 succeeded at 353 with fuzz 1.
> Hunk #5 succeeded at 375 with fuzz 1.
> 2 out of 5 hunks FAILED -- saving rejects to file 
> drivers/acpi/sony_acpi.c.rej

The really strange thing is that since the sony_acpi.c file doesn't
exist in mainline and is created in the first patch, at least the
patches on it shouldn't fail... :)

hummm... could you retry with a fresh tree?
-- 
mattia
:wq!
