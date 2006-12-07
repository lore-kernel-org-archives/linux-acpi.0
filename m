From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Thu, 7 Dec 2006 20:47:30 +0100
Message-ID: <200612072047.31473.rjw@sisk.pl>
References: <E3C0BCA40296C347AF7142161DB9FC828618B8@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50204 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163237AbWLGTon (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 14:44:43 -0500
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC828618B8@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

Hi,

On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
> Hi,
> 
> Unfortunately, I cannot reproduce this bug on my system, but the problem
> could be solved by adding a resume handler for AC adapter device. Could
> you try the attached patch to see if it helps.

I can reproduce it and the patch doesn't help.

Greetings,
Rafael


> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Andrey Borzenkov
> >Sent: Sunday, December 03, 2006 7:01 PM
> >To: Alexey Starikovskiy
> >Cc: Pavel Machek; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> >Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
> >
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >On Sunday 03 December 2006 17:35, Alexey Starikovskiy wrote:
> >> Andrey Borzenkov wrote:
> >> > -----BEGIN PGP SIGNED MESSAGE-----
> >> > Hash: SHA1
> >> >
> >> > On Sunday 03 December 2006 16:11, Pavel Machek wrote:
> >> >> Hi!
> >> >>
> >> >>> I started to notice it some time ago; I can't say exactly if this
> was
> >> >>> not present in earlier versions because recently I switched from
> STR
> >> >>> (which gave me no end of troubles) to STD. So I may have not seen
> it
> >> >>> before.
> >> >>>
> >> >>> Suspend to disk while on battery. Plug in AC, resume. ACPI
> continues
> >to
> >> >>> show AC adapter as not present:
> >> >>>
> >> >>> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> >> >>> state:                   off-line
> >> >>>
> >> >>> replugging AC correctly changes state to on-line.
> >> >>
> >> >> try echo platform > /sys/power/disk.
> >> >
> >> > Nope.
> >> >
> >> > {pts/0}% pmsuspend disk
> >> > ... after resume
> >> > {pts/0}% cat /sys/power/disk
> >> > platform
> >> > {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> >> > state:                   off-line
> >>
> >> please look if patches in 7122 work  for you.
> >
> >No. I applied patches from comments 38 and 52 (modified, it did not
> apply
> >cleanly to 2.6.19). As far as I understood, those two were final.
> >-----BEGIN PGP SIGNATURE-----
> >Version: GnuPG v1.4.5 (GNU/Linux)
> >
> >iD8DBQFFcvS3R6LMutpd94wRAp9oAKCM7+6G4SsgFEGLgkW1jxM3VMQHqQCdFSDQ
> >14w+QsgDtxWusmfdzCMOdqo=
> >=QDyt
> >-----END PGP SIGNATURE-----
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
