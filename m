From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Sun, 8 Jun 2008 01:22:19 +0200
Message-ID: <20080607232219.GA25693@atjola.homenet>
References: <48486920.4040006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753535AbYFGXWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 7 Jun 2008 19:22:24 -0400
Content-Disposition: inline
In-Reply-To: <48486920.4040006@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, cpufreq@lists.linux.org.uk, Dave Jones <davej@codemonkey.org.uk>

On 2008.06.05 15:30:56 -0700, Kok, Auke wrote:
>=20
> I've consistently experienced the following bizarre problem since
> 2.6.20, all the way up to 2.6.25.3 (regressed yesterday and each of
> these kernels exposes this behaviour):
>=20
> /sys/devices/system/cpu/cpu0/cpufreq # grep . *
> affected_cpus:0
> cpuinfo_cur_freq:800000
> cpuinfo_max_freq:1866000
> cpuinfo_min_freq:800000
> scaling_available_frequencies:1866000 1600000 1333000 1066000 800000
> scaling_available_governors:ondemand performance
> scaling_cur_freq:800000
> scaling_driver:acpi-cpufreq
> scaling_governor:ondemand
> scaling_max_freq:800000
> scaling_min_freq:800000
>=20

I also saw that on my T43, didn't have time to investigate any further
and forgot about it shortly after :-(

>=20
> Notice that scaling_mx_freq dropped down to the lowest possible value
> and as such my CPU is only working at 800MHz. At boot time this field
> properly displays 1866MHz and everything works OK. After a certain
> period (?) this value drops down and I cannot manually elevate it bac=
k
> to the normal level:
>=20
> # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> 800000
> # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> 800000

Try with "echo -n", seems that sysfs (or at least that file) doesn't
like newlines.

Bj=F6rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
