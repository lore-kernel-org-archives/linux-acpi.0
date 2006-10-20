From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 05:25:00 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28430 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S964797AbWJTMZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 08:25:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Sune M=F8lgaard [mailto:sune@molgaard.org]=20
>Sent: Friday, October 20, 2006 5:09 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Pallipadi, Venkatesh wrote:
>>=20
>> Hmm... You must have CPU_FREQ_DENUG enabled in CONFIG=20
>already. Can you pass cpufreq.debug=3D3 in boot option and send=20
>me the output of dmesg after that.
>>=20
>> Thanks,
>> Venki
>
>I am currently on 2.6.17.13 ubuntu version, that includes a lot of=20
>2.6.18 code.
>
>It seems it tries to load acpi-cpufreq which complains about=20
>cpu_online_map, bu I also tried explicitly to load speedstep-centrino,=
=20
>which resulted in
>
>sune@tommelise:~$ sudo modprobe speedstep-centrino
>Password:
>FATAL: Error inserting speedstep_centrino=20
>(/lib/modules/2.6.17.13-ubuntu1-pentium4m-1/kernel/arch/i386/ke
rnel/cpu/cpufreq/speedstep-centrino.ko):=20
>No such device
>sune@tommelise:~$
>
>But nothing in dmesg, which is attached.
>

Puzzling..=20
Just to make sure, do you have CPU_FREQ_DEBUG enabled in your config an=
d boot parameter? There are a bunch of dprintk debug messages in speeds=
tep_centrino that should get printed in this case..
Do you have est flag displayed in your /proc/cpuinfo under flags?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
