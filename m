From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 12:08:15 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030806100815.GH16091@fs.tum.de>
References: <200308060621.06216.d.nuetzel@wearabrain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308060621.06216.d.nuetzel-VZcQ4qwp+CzQLMG2gba6HQ@public.gmane.org>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <d.nuetzel-VZcQ4qwp+CzQLMG2gba6HQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Linux Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter N=FCtzel wrote:
> Hello,

Hi Dieter,

> I had it running very well on my dual Athlon MP 1900+ for several mon=
ths=20
> before. Latest Kernel was 2.4.22-pre5+ACPI patch.
>=20
> Any changes?
> I changed lm_sensors from 2.7.0 (?) to 2.8.0
>=20
> System:
> dual Athlon MP 1900+
> MSI K7D Master-L
>=20
> 2.4.22-rc1
> acpi-20030730-2.4.22-pre8.diff
> preempt-kernel-rml-2.4.21-1.patch
>...

does an unpatched 2.4.22-rc1 work?

If yes, please check which of the two patches causes the problem.

> Thanks.

cu
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
