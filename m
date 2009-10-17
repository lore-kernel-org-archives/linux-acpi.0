From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [kernel 2.6.31.4] backlight controls gone mad
Date: Sat, 17 Oct 2009 17:58:40 +0100
Message-ID: <9b2b86520910170958o7b2348f9x751f5e89b59d2cf3@mail.gmail.com>
References: <f1ac5a50910161546t6eeef710q6d40f22a61d15d1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:44494 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZJQQ6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Oct 2009 12:58:36 -0400
In-Reply-To: <f1ac5a50910161546t6eeef710q6d40f22a61d15d1a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9lson_=ABVuDu=BB_Cunha?= <vudu.curse@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kernel Testers List <kernel-testers@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 10/16/09, N=E9lson =ABVuDu=BB Cunha <vudu.curse@gmail.com> wrote:
> Hello,
>
> I'm using ArchLinux (here's the "downstream" bug report:
> http://bugs.archlinux.org/task/16698) and with the last update to
> kernel 2.6.31.4 my backlight/brightness controls have gone mad.
>
> My laptop's screen keeps blinking, slowly increasing or decreasing it=
s
> luminosity randomly. Sometimes it stays still for a couple of minutes
> at any random brightness level, but it's very uncomfortable for the
> eyes when it's blinking.
> Here's a video of what's happening:
> http://www.mediafire.com/download.php?z4mi4uzidjn
>
> I've tried to use /proc/acpi/video/VGA/LCDD/brightness and
> /sys/class/backlight/acpi_video0/brightness but with no luck, because
> they make no changes and when I cat them I get wrong values.
>
> I tried using xbacklight but it gives me "No outputs have backlight
> property".
>
> With the previous (2.6.30.6) version I had no problems and after
> getting this problem I installed Arch's "kernel26-lts" package
> (2.6.27.37) and I'm having no issues with that kernel.
>
> My laptop is an ASUS M51VA with an Intel C2D and an ATI HD 3650. I
> tried fglrx, radeon and radeonhd and it made no difference.
>
> If you need more details, please say so.
>
>. Best Regards.

The ACPI people tend to use the kernel bugzilla to track these sorts
of bugs (and it's also used to keep track of regressions).  It would
be great if you could enter this on bugzilla.kernel.org.  Sounds like
you want to file it under the acpi video driver.

Please include the result of "dmesg" on both 2.6.31.4 and 2.6.30.6.
"acpidump" output would also be very helpful.

Thanks
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
