From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Why do I have a /sys/devices/system/cpu/cpuidle under kernel
 2.6.24 with a Pentium M processor ?
Date: Tue, 5 Feb 2008 02:16:54 -0800
Message-ID: <20080205021654.37286791.akpm@linux-foundation.org>
References: <200801311400.17811.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48120 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754747AbYBEKQl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 05:16:41 -0500
In-Reply-To: <200801311400.17811.toralf.foerster@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toralf =?ISO-8859-1?B?RvZyc3Rlcg==?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>

On Thu, 31 Jan 2008 14:00:14 +0100 Toralf F=F6rster <toralf.foerster@gm=
x.de> wrote:

(suitable cc's added)

> I'm asking b/c this confuses the current sysstat up to version 8.0.4.=
 An

That would be bad.  Please define "confuses"?

> $ ls -lR /sys/devices/system/cpu/
>=20
> gives :
>=20
> /sys/devices/system/cpu/:
> total 0
> drwxr-xr-x 4 root root 0 Jan 30 09:36 cpu0
> drwxr-xr-x 2 root root 0 Jan 30 09:36 cpuidle
>=20
> /sys/devices/system/cpu/cpu0:
> total 0
> drwxr-xr-x 3 root root 0 Jan 30 09:36 cpufreq
> drwxr-xr-x 5 root root 0 Jan 30 09:36 cpuidle
>=20
> /sys/devices/system/cpu/cpu0/cpufreq:
> total 0
> -r--r--r-- 1 root root 4096 Jan 30 09:36 affected_cpus
> -r-------- 1 root root 4096 Jan 30 09:36 cpuinfo_cur_freq
> -r--r--r-- 1 root root 4096 Jan 30 09:36 cpuinfo_max_freq
> -r--r--r-- 1 root root 4096 Jan 30 09:36 cpuinfo_min_freq
> drwxr-xr-x 2 root root    0 Jan 30 09:36 ondemand
> -r--r--r-- 1 root root 4096 Jan 30 09:36 scaling_available_frequencie=
s
> -r--r--r-- 1 root root 4096 Jan 30 09:36 scaling_available_governors
> -r--r--r-- 1 root root 4096 Jan 30 09:36 scaling_cur_freq
> -r--r--r-- 1 root root 4096 Jan 30 09:36 scaling_driver
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 scaling_governor
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 scaling_max_freq
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 scaling_min_freq
>=20
> /sys/devices/system/cpu/cpu0/cpufreq/ondemand:
> total 0
> -rw-r--r-- 1 root root    0 Jan 30 09:36 ignore_nice_load
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 powersave_bias
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 sampling_rate
> -r--r--r-- 1 root root 4096 Jan 30 09:36 sampling_rate_max
> -r--r--r-- 1 root root 4096 Jan 30 09:36 sampling_rate_min
> -rw-r--r-- 1 root root 4096 Jan 30 09:36 up_threshold
>=20
> /sys/devices/system/cpu/cpu0/cpuidle:
> total 0
> drwxr-xr-x 2 root root 0 Jan 30 09:36 state0
> drwxr-xr-x 2 root root 0 Jan 30 09:36 state1
> drwxr-xr-x 2 root root 0 Jan 30 09:36 state2
>=20
> /sys/devices/system/cpu/cpu0/cpuidle/state0:
> total 0
> -r--r--r-- 1 root root 4096 Jan 30 09:36 latency
> -r--r--r-- 1 root root 4096 Jan 30 09:36 name
> -r--r--r-- 1 root root 4096 Jan 30 09:36 power
> -r--r--r-- 1 root root 4096 Jan 30 09:36 time
> -r--r--r-- 1 root root 4096 Jan 30 09:36 usage
>=20
> /sys/devices/system/cpu/cpu0/cpuidle/state1:
> total 0
> -r--r--r-- 1 root root 4096 Jan 30 09:36 latency
> -r--r--r-- 1 root root 4096 Jan 30 09:36 name
> -r--r--r-- 1 root root 4096 Jan 30 09:36 power
> -r--r--r-- 1 root root 4096 Jan 30 09:36 time
> -r--r--r-- 1 root root 4096 Jan 30 09:36 usage
>=20
> /sys/devices/system/cpu/cpu0/cpuidle/state2:
> total 0
> -r--r--r-- 1 root root 4096 Jan 30 09:36 latency
> -r--r--r-- 1 root root 4096 Jan 30 09:36 name
> -r--r--r-- 1 root root 4096 Jan 30 09:36 power
> -r--r--r-- 1 root root 4096 Jan 30 09:36 time
> -r--r--r-- 1 root root 4096 Jan 30 09:36 usage
>=20
> /sys/devices/system/cpu/cpuidle:
> total 0
> -r--r--r-- 1 root root 4096 Jan 30 09:36 current_driver
> -r--r--r-- 1 root root 4096 Jan 30 09:36 current_governor_ro
>=20
> --=20
> MfG/Sincerely
>=20
> Toralf F=F6rster
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
