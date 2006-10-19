From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 16:27:24 +0200
Message-ID: <45378B4C.1040708@molgaard.org>
References: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com> <453788F9.4000704@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero1.cybercity.dk ([212.242.40.4]:30926 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S1161413AbWJSO1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 10:27:32 -0400
In-Reply-To: <453788F9.4000704@molgaard.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

Sune M=F8lgaard wrote:
> Pallipadi, Venkatesh wrote:
>=20
>> How about acpi-cpufreq? Does it work?
>>
>=20
> I face the same problem on a Dell Inspiron 6000 (sonoma core cpu) and=
=20
> 2.6.17.13. I might add that it was functional on 2.6.15.
>=20
> Upon trying to load acpi-cpufreq instead, I get
>=20
> sune@tommelise:~$ sudo modprobe acpi-cpufreq
> Password:
> FATAL: Error inserting acpi_cpufreq=20
> (/lib/modules/2.6.17.13-ubuntu1-pentium4m-1/kernel/arch/i386/kernel/c=
pu/cpufreq/acpi-cpufreq.ko):=20
> Unknown symbol in module, or unknown parameter (see dmesg)
> sune@tommelise:~$ dmesg
> [snip]
> [4320009.012000] acpi_cpufreq: Unknown symbol cpu_online_map
>=20
> Best regards,
>=20
> Sune M=F8lgaard

And I forgot to mention that it ENODEVs if I comment out the offending =
code.

/sune
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
