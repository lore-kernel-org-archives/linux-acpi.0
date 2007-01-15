From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [PATCH 0/11] sony_acpi: prepare for prime time (resend)
Date: Mon, 15 Jan 2007 04:01:14 -0500
Message-ID: <3877989d0701150101y1098e27ep26c1df0798292997@mail.gmail.com>
References: <11687258812893-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:62430 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbXAOJBQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jan 2007 04:01:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1695886wxd
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jan 2007 01:01:16 -0800 (PST)
In-Reply-To: <11687258812893-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "malattia@linux.it" <malattia@linux.it>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Patch series is not clean against 2.6.20-rc5.

patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_va
io.patch
patching file Documentation/acpi/sony_acpi.txt
patching file drivers/acpi/Kconfig
Hunk #1 succeeded at 252 with fuzz 2 (offset -9 lines).
patching file drivers/acpi/Makefile
Hunk #1 FAILED at 54.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/Makefile.rej
patching file drivers/acpi/sony_acpi.c


patch -p1 < ../malattia_sony/2_avoid_dimness_on_resume.patch
patching file drivers/acpi/sony_acpi.c
Hunk #1 succeeded at 46 with fuzz 2.
Hunk #2 FAILED at 56.
Hunk #3 FAILED at 228.
Hunk #4 succeeded at 353 with fuzz 1.
Hunk #5 succeeded at 375 with fuzz 1.
2 out of 5 hunks FAILED -- saving rejects to file drivers/acpi/sony_acpi.c.rej

patch -p1 < ../malattia_sony/3_fix_sony_acpi_resume_call.patc
h
patching file drivers/acpi/sony_acpi.c
Hunk #1 FAILED at 233.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/sony_acpi.c.rej

patch -p1 < ../malattia_sony/4_add_backlight_support_to_the_s
ony_acpi.patch
patching file drivers/acpi/Kconfig
Hunk #1 FAILED at 264.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/Kconfig.rej
patching file drivers/acpi/sony_acpi.c
Hunk #2 succeeded at 55 with fuzz 2.
Hunk #3 FAILED at 77.
Hunk #4 FAILED at 284.
Hunk #5 FAILED at 312.
Hunk #6 FAILED at 373.
Hunk #7 succeeded at 371 with fuzz 2 (offset -22 lines).
4 out of 7 hunks FAILED -- saving rejects to file drivers/acpi/sony_acpi.c.re




On 1/13/07, malattia@linux.it <malattia@linux.it> wrote:
> Hello again,
>
> as said the following patchset starts to take care of sony_acpi:
> 1 to 7  are currently in -mm
> 8 to 10 are my local changes to make sony_acpi make some more interesting
>         things on recent vaios
> 11      initializes the real brightness value in the backlight props (should
>         this go in the backlight class itself?) and fixes the error exit path
>         for the backlight_device registration
>
> will follow shortly with a patch that makes sony_acpi a platform device driver.
>
> --
> mattia
> :wq
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
