From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 11:56:58 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41543 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946356AbWJSS5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 14:57:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Sune M=F8lgaard [mailto:sune@molgaard.org]=20
>Sent: Thursday, October 19, 2006 11:19 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Thanks for taking an interest, if I haven't said so before.
>
>Now, I was about to write that I couldn't open /dev/mem, but luckily=20
>remembered to try sudo'ing acpidump :-$
>
>Enclosed is the dump, created while running 2.6.18.1.
>

OK. Things seem to be fine with the BIOS.=20

You said it was working with 2.6.15. Do you remember whether kernel was=
 using acpi-cpufreq or speedstep-centrino?

One change that has happened in this region is that If your BIOS suppor=
ts both speedstep-centrino and acpi-cpufreq, with 2.6.15 any one of tho=
se drivers would have worked. But now with 2.6.18, acpi-cpufreq will no=
t work in the above case and you have to use speedstep_centrino. This w=
as done because, speedstep-centrino has more features than acpi-cpufreq=
 and also doing this helped to elimiate issues with lot of systems with=
 kernel trying to do multiple ACPI PDC writes when BIOS doesn't expect =
it to.=20

In short:
(1) If you were using acpi-cpufreq in 2.6.15, there is a high chance th=
at it wont work with 2.6.18 and you should be able to use speedstep-cen=
trino in its place. Make sure you have properly configured speedstep-ce=
ntrino (You should select X86_SPEEDSTEP_CENTRINO_ACPI along with X86_SP=
EEDSTEP_CENTRINO).

(2) If you were using speedstep-centrino in 2.6.15 and now it doesn't w=
ork with 2.6.18, then we have a new regression here and we need to root=
 cause it further by enabling cpufreq.debug and getting more debug mess=
ages to see where it is failing....

Thanks,
Venki
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
