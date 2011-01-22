From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 07:11:02 -0800
Message-ID: <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
 <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com> <201101221110.17786.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53443 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951Ab1AVPLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jan 2011 10:11:24 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0MFBNMG029801
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 07:11:24 -0800
Received: by iyj18 with SMTP id 18so2622762iyj.19
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 07:11:22 -0800 (PST)
In-Reply-To: <201101221110.17786.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sat, Jan 22, 2011 at 2:10 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> I have a theory, which is that on failing runs your system doesn't ev=
en try
> to enter S3 and it's trying to enter a bogus S1 instead.

Hmm. I can certainly believe in the "BIOS is confused" idea, but I
don't see where that gets us.

> The reason why I think so is that the "Back to C!" message is not pre=
sent in
> the failing log

It's not present in the good logs either.

> A couple of things may be done to verify this. =A0First, before suspe=
nding for
> the first time after a reboot, you can check if there's "standby" in
> /sys/power/state (it shouldn't be there, because your "good" dmesg sa=
ys S1
> isn't supported).

No, just "mem".

>=A0Second, after a failing run that was revived by a key press
> you can check if there's S1 instead of S3 in the "ACPI: Preparing to =
enter
> system sleep state ..." message.

Nope, all log messages say S3.

>=A0Finally, which I suspect is the case, it is
> possible that we don't even try to enter S1, but something confuses t=
he BIOS
> which thinks it should go into S1 although it's told to go into S3.

Now this I can believe in.

> Now, if the BIOS is confused, I have no idea what may be the reason, =
but I
> think it would be good to rule out the change from ioremap() to
> ioremap_cache() in ACPI (as I said before, it's sufficient to modify
> include/linux/acpi_io.h for this purpose so that ioremap() is called =
by
> acpi_os_ioremap() - unless you have done that already in which case s=
orry for
> the noise).

Tried it. First boot was fine, second boot had the "press key to make
suspend continue" problem on the first suspend, and then (as
apparently always happens after that half-suspend) locked up
completely on the second.

Oh well.

                   Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
