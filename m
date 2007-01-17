From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH 0/11] sony_acpi: prepare for prime time (resend)
Date: Wed, 17 Jan 2007 10:34:57 +0100 (CET)
Message-ID: <54970.85.47.20.193.1169026497.squirrel@picard.linux.it>
References: <11687258812893-git-send-email-malattia@linux.it>
    <3877989d0701150101y1098e27ep26c1df0798292997@mail.gmail.com>
    <20070115191250.GA6912@inferi.kami.home>
    <3877989d0701162150k63640835n4489f87279d8fc6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:53980 "EHLO picard.linux.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbXAQJ6L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jan 2007 04:58:11 -0500
In-Reply-To: <3877989d0701162150k63640835n4489f87279d8fc6f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Wed, January 17, 2007 6:50 am, Luming Yu said:
> On 1/15/07, Mattia Dongili <malattia@linux.it> wrote:
>> Hello and sorry for the delay
>>
>> On Mon, Jan 15, 2007 at 04:01:14AM -0500, Luming Yu wrote:
>> > Patch series is not clean against 2.6.20-rc5.
>> >
>> > patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_va
>> > io.patch
>> > patching file Documentation/acpi/sony_acpi.txt
>> > patching file drivers/acpi/Kconfig
>> > Hunk #1 succeeded at 252 with fuzz 2 (offset -9 lines).
>> > patching file drivers/acpi/Makefile
>> > Hunk #1 FAILED at 54.
>> > 1 out of 1 hunk FAILED -- saving rejects to file
>> drivers/acpi/Makefile.rej
>> > patching file drivers/acpi/sony_acpi.c
>> ...
>>
>> uh. I'm developing on the acpi tree test branch, however I just tried
>> the patches on a freshly unpacked/patched .20-rc5 and the patches apply
>> without any reject.
>
> I was using linus's linux-2.6 git tree.
> Then, I tried the patch series on a fresh unpacked 2.6.20-rc5.
> I still got :
>
> #  patch -p1 < ../malattia_sony/1_snc_device_support_for_sony_vaio.patch
> patching file Documentation/acpi/sony_acpi.txt
> patching file drivers/acpi/Kconfig
> Hunk #1 succeeded at 252 with fuzz 2 (offset -9 lines).
> patching file drivers/acpi/Makefile
> Hunk #1 FAILED at 54.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/Makefile.rej
> patching file drivers/acpi/sony_acpi.c

can you show the contents of the rejects on Makefile? and also the next
one with the second patch on sony_acpi.c?

> patch -p1 < ../malattia_sony/2_avoid_dimness_on_resume.patch
> patching file drivers/acpi/sony_acpi.c
> Hunk #1 succeeded at 46 with fuzz 2.
> Hunk #2 FAILED at 56.
> Hunk #3 FAILED at 228.
> Hunk #4 succeeded at 353 with fuzz 1.
> Hunk #5 succeeded at 375 with fuzz 1.
> 2 out of 5 hunks FAILED -- saving rejects to file
> drivers/acpi/sony_acpi.c.rej
>
> Is 2_avoid_dimness_on_resume.patch a right patch, or in right order?

yes, this is how I have the patches as created by git-format-patch:

0001-SNC-device-support-for-Sony-Vaios.txt
0002-Avoid-dimness-on-resume.txt
0003-Fix-sony_acpi_resume-call.txt
0004-Add-backlight-support-to-the-sony_acpi.txt
0005-Add-backlight-support-to-the-sony_acpi-v2.txt
0006-Video-sysfs-support-take-2.txt
0007-Add-acpi_bus_generate-event.txt
0008-Allow-easier-debugging-for-the-unknown-SNC-methods.txt
0009-Add-lanpower-and-audiopower-controls.txt
0010-Allow-multiple-sony_acpi_values-for-the-same-.name.txt
0011-Fix-sony_acpi-backlight-registration-and-unregistration.txt

don't know, I put them all here, if useful:
http://oioio.altervista.org/linux/to_len.tar.gz

-- 
mattia
:wq!


