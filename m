From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 04:56:06 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A971@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61526 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1946378AbWJTL5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 07:57:47 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Sune M=F8lgaard [mailto:sune@molgaard.org]=20
>Sent: Friday, October 20, 2006 12:34 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Pallipadi, Venkatesh wrote:
>> Make sure you have properly configured speedstep-centrino=20
>(You should select X86_SPEEDSTEP_CENTRINO_ACPI along with=20
>X86_SPEEDSTEP_CENTRINO).
>
>I have enabled all options in the make menuconfig menu under cpufreq=20
>(except the one marked deprecated). Still no go :-(
>

Hmm... You must have CPU_FREQ_DENUG enabled in CONFIG already. Can you =
pass cpufreq.debug=3D3 in boot option and send me the output of dmesg a=
fter that.

Thanks,
Venki
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
