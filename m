From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: acpi-cpufreq; Intel Johnstown (Atom N270)
Date: Thu, 13 Aug 2009 14:29:08 -0400
Message-ID: <20090813182908.GC9385@alittletooquiet.net>
References: <20090813172556.GB9385@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:47145 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbZHMS3H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 14:29:07 -0400
Content-Disposition: inline
In-Reply-To: <20090813172556.GB9385@alittletooquiet.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2009 at 01:25:57PM -0400, Forest Bond wrote:
> I'm using an Intel Johnstown board with an Atom N270 processor.  Performa=
nce
> seems to improve dramatically with acpi-cpufreq loaded.  This caught me by
> surprise.  I had assumed that without loading acpi-cpufreq the CPU would =
be
> running at its maximum speed all the time.

I ran some tests to get some numbers.  My findings indicate that before
acpi-cpufreq is loaded the CPU is running at 800MHz even though /proc/cpuin=
fo
indicates 1.6GHz.

My test just runs `yes | head -n10000000' and times the execution.  Three r=
eps
are done for each set of conditions.  Here's a break down of the results:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Conditions              Average Time
----------------------- ------------
acpi-cpufreq not loaded 2.641s

acpi-cpufreq loaded     1.349s
performance governor

acpi-cpufreq loaded     2.640s
userspace governor
scaling_max_freq 800000
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Actual results follow.

Here's my test script:

  #!/bin/bash
 =20
  set -o xtrace
 =20
  for rep in 1 2 3; do
    grep '^cpu MHz' /proc/cpuinfo
    uptime
    time yes | head -n10000000 >/dev/null
  done


Results without acpi-cpufreq:

  root@platform:~# ./test.sh
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1596.060
  cpu MHz         : 1596.060
  + uptime
   18:08:37 up 6 min,  1 user,  load average: 0.06, 0.66, 0.43
  + yes
  + head -n10000000
 =20
  real    0m2.647s
  user    0m2.844s
  sys     0m0.420s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1596.060
  cpu MHz         : 1596.060
  + uptime
   18:08:40 up 6 min,  1 user,  load average: 0.13, 0.66, 0.43
  + yes
  + head -n10000000
 =20
  real    0m2.655s
  user    0m2.748s
  sys     0m0.528s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1596.060
  cpu MHz         : 1596.060
  + uptime
   18:08:43 up 6 min,  1 user,  load average: 0.13, 0.66, 0.43
  + yes
  + head -n10000000
 =20
  real    0m2.622s
  user    0m2.872s
  sys     0m0.428s


Then with acpi-cpufreq and the default performance governor:

  root@platform:~# modprobe acpi-cpufreq
  root@platform:~# ./test.sh
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1600.000
  cpu MHz         : 1600.000
  + uptime
   18:09:11 up 6 min,  1 user,  load average: 0.13, 0.61, 0.42
  + yes
  + head -n10000000
 =20
  real    0m1.354s
  user    0m1.392s
  sys     0m0.240s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1600.000
  cpu MHz         : 1600.000
  + uptime
   18:09:12 up 6 min,  1 user,  load average: 0.13, 0.61, 0.42
  + yes
  + head -n10000000
 =20
  real    0m1.339s
  user    0m1.440s
  sys     0m0.284s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 1600.000
  cpu MHz         : 1600.000
  + uptime
   18:09:14 up 6 min,  1 user,  load average: 0.13, 0.61, 0.42
  + yes
  + head -n10000000
 =20
  real    0m1.354s
  user    0m1.404s
  sys     0m0.264s
  root@platform:~# grep '' /sys/devices/system/cpu/cpu0/cpufreq/*
  /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0 1
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1600000
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1600000
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:160000=
0 1333000 1067000 800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:performa=
nce
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1600000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1600000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:800000


Then with the userspace governor and the frequency set to 800MHz:

  root@platform:~# modprobe cpufreq_userspace
  root@platform:~# echo 800000 >/sys/devices/system/cpu/cpu0/cpufreq/scalin=
g_max_freq
  root@platform:~# grep '' /sys/devices/system/cpu/cpu0/cpufreq/*
  /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0 1
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:800000
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1600000
  /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:160000=
0 1333000 1067000 800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:userspac=
e performance
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:800000
  /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:800000
  root@platform:~# echo 800000 >/sys/devices/system/cpu/cpu1/cpufreq/scalin=
g_max_freq
  root@platform:~# ./test.sh
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 800.000
  cpu MHz         : 800.000
  + uptime
   18:12:32 up 9 min,  1 user,  load average: 0.00, 0.32, 0.34
  + yes
  + head -n10000000
 =20
  real    0m2.627s
  user    0m2.808s
  sys     0m0.496s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 800.000
  cpu MHz         : 800.000
  + uptime
   18:12:35 up 10 min,  1 user,  load average: 0.00, 0.32, 0.34
  + yes
  + head -n10000000
 =20
  real    0m2.643s
  user    0m2.732s
  sys     0m0.544s
  + for rep in 1 2 3
  + grep '^cpu MHz' /proc/cpuinfo
  cpu MHz         : 800.000
  cpu MHz         : 800.000
  + uptime
   18:12:37 up 10 min,  1 user,  load average: 0.16, 0.34, 0.34
  + yes
  + head -n10000000
 =20
  real    0m2.651s
  user    0m2.848s
  sys     0m0.424s

Thoughts?

-Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKhFt0RO4fQQdv5AwRAnLwAKC6Jxl7pgyaibc085Ib5TRN3P9bngCeIUnm
LcNztWBRO+v6yFFLQmhIKVM=
=CH7z
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
