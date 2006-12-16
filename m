From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sat, 16 Dec 2006 20:38:49 +0300
Message-ID: <200612162038.54218.arvidjaar@mail.ru>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx28.mail.ru ([194.67.23.67]:1650 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161325AbWLPSNB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 13:13:01 -0500
Received: from mx27.mail.ru (mx27.mail.ru [194.67.23.64])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 976476C0622
	for <linux-acpi@vger.kernel.org>; Sat, 16 Dec 2006 20:39:19 +0300 (MSK)
In-Reply-To: <8E389A5F2FEABA4CB1DEC35A25CB39CE82FE9F@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 December 2006 23:40, Lebedev, Vladimir P wrote:
> Please register new bug, attach acpidump and dmesg.
>

Rafael, do you have bug number (so that I can add my system to it) or should I 
open new bug report?

>
> -----Original Message-----
> From: Alexey Starikovskiy [mailto:alexey.y.starikovskiy@linux.intel.com]
>
> Sent: Thursday, December 07, 2006 10:49 PM
> To: Rafael J. Wysocki
> Cc: Karasyov, Konstantin A; Andrey Borzenkov;
> linux-acpi@vger.kernel.org; Lebedev, Vladimir P
> Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
>
> Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
> >> Hi,
> >>
> >> Unfortunately, I cannot reproduce this bug on my system, but the
>
> problem
>
> >> could be solved by adding a resume handler for AC adapter device.
>
> Could
>
> >> you try the attached patch to see if it helps.
> >
> > I can reproduce it and the patch doesn't help.
> >
> > Greetings,
> > Rafael
>
> Any ACPI errors in dmesg?
>
> Regards,
>     Alex.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFhC8uR6LMutpd94wRAhWkAJ4wyPz95I0NuRy2Wug+xrWEeMSqmACfVkIr
rE+dPs3Dpy6bUvl0OmoTrqA=
=rEV6
-----END PGP SIGNATURE-----
