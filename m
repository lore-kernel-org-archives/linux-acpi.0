From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 16:17:29 +0200
Message-ID: <453788F9.4000704@molgaard.org>
References: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero1.cybercity.dk ([212.242.40.4]:20710 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S1945960AbWJSORe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 10:17:34 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
> How about acpi-cpufreq? Does it work?
>=20

I face the same problem on a Dell Inspiron 6000 (sonoma core cpu) and=20
2.6.17.13. I might add that it was functional on 2.6.15.

Upon trying to load acpi-cpufreq instead, I get

sune@tommelise:~$ sudo modprobe acpi-cpufreq
Password:
=46ATAL: Error inserting acpi_cpufreq=20
(/lib/modules/2.6.17.13-ubuntu1-pentium4m-1/kernel/arch/i386/kernel/cpu=
/cpufreq/acpi-cpufreq.ko):=20
Unknown symbol in module, or unknown parameter (see dmesg)
sune@tommelise:~$ dmesg
[snip]
[4320009.012000] acpi_cpufreq: Unknown symbol cpu_online_map

Best regards,

Sune M=F8lgaard
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
