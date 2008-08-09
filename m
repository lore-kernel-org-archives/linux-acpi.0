From: Thomas Renninger <trenn@suse.de>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Sat, 9 Aug 2008 20:59:47 +0200
Message-ID: <200808092059.47863.trenn@suse.de>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com> <200808081430.43012.trenn@suse.de> <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48349 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYHISn2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Aug 2008 14:43:28 -0400
In-Reply-To: <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: S K <nospamnoham@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday 08 August 2008 08:23:25 pm S K wrote:
> > Try updating the BIOS.
> > I expect your CPU is too new and the BIOS cannot export the correct=
 freq
> > values for the specific CPU yet.
> >
> >      Thomas
>
> The BIOS is already at the latest version :( Is the above comment the
> only possible reason for the issue?

It is very likely.
I did not go through the DSDT table(s) myself, but if this is true:
> According to the online ACPI spec, the BIOS should expose _PCT, _PSS =
and PPC
> objects if it supports multiple CPU performance states (aka P-states,
> cpufreq). =A0I ran your acpidump.txt through acpixtract to generate t=
he DSDT,
> and decompiled it using iasl. =A0It did not contain any of _PCT, _PSS=
 and
> _PPC.

your BIOS does not export basic CPU freq data. The only way to get cpuf=
req=20
working on latest Intel HW is through ACPI and acpi-cpufreq driver.

It may happen that above functions are somewhat hidden in SSDT tables b=
ut=20
loading and finding the CPU freq functions generally works quite well.

Mark Langsdorf reported some acpi breakage in .27-rc1, this could also =
be the=20
reason.

That a BIOS update is needed for latest CPUs is common. I expect your m=
achine=20
is rather new?

There also is a cpufreq list which moved recently, the latest one you s=
hould=20
post to is this one:
cpufreq@vger.kernel.org

       Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
