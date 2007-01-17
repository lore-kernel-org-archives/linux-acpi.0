From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [PATCH 0/11] sony_acpi: prepare for prime time (resend)
Date: Wed, 17 Jan 2007 00:50:30 -0500
Message-ID: <3877989d0701162150k63640835n4489f87279d8fc6f@mail.gmail.com>
References: <11687258812893-git-send-email-malattia@linux.it>
	 <3877989d0701150101y1098e27ep26c1df0798292997@mail.gmail.com>
	 <20070115191250.GA6912@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:1594 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXAQFub (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 00:50:31 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2393467wxd
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jan 2007 21:50:31 -0800 (PST)
In-Reply-To: <20070115191250.GA6912@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On 1/15/07, Mattia Dongili <malattia@linux.it> wrote:
> Hello and sorry for the delay
>
> On Mon, Jan 15, 2007 at 04:01:14AM -0500, Luming Yu wrote:
> > Patch series is not clean against 2.6.20-rc5.
> >
> > patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_va
> > io.patch
> > patching file Documentation/acpi/sony_acpi.txt
> > patching file drivers/acpi/Kconfig
> > Hunk #1 succeeded at 252 with fuzz 2 (offset -9 lines).
> > patching file drivers/acpi/Makefile
> > Hunk #1 FAILED at 54.
> > 1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/Makefile.rej
> > patching file drivers/acpi/sony_acpi.c
> ...
>
> uh. I'm developing on the acpi tree test branch, however I just tried
> the patches on a freshly unpacked/patched .20-rc5 and the patches apply
> without any reject.

I was using linus's linux-2.6 git tree.
Then, I tried the patch series on a fresh unpacked 2.6.20-rc5.
I still got :

#  patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_vaio.patch
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

Is 2_avoid_dimness_on_resume.patch a right patch, or in right order?
