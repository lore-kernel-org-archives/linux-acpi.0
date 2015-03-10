From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 13/22] ACPI: Change power supply ownership from driver
 to core
Date: Tue, 10 Mar 2015 15:17:59 +0100
Message-ID: <20150310141759.GD11992@earth>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-14-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60076 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbbCJOSR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2015 10:18:17 -0400
Content-Disposition: inline
In-Reply-To: <1425976046-20973-14-git-send-email-k.kozlowski@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael and Len,

On Tue, Mar 10, 2015 at 09:27:17AM +0100, Krzysztof Kozlowski wrote:
> Change the ownership of power_supply structure from each driver
> implementing the class to the power supply core.
>=20
> The patch changes power_supply_register() function thus all drivers
> implementing power supply class are adjusted.
>=20
> Each driver provides the implementation of power supply. However it
> should not be the owner of power supply class instance because it is
> exposed by core to other subsystems with power_supply_get_by_name().
> These other subsystems have no knowledge when the driver will unregister
> the power supply. This leads to several issues when driver is unbound -
> mostly because user of power supply accesses freed memory.
>=20
> Instead let the core own the instance of struct 'power_supply'.  Other
> users of this power supply will still access valid memory because it
> will be freed when device reference count reaches 0. Currently this
> means "it will leak" but power_supply_put() call in next patches will
> solve it.
>=20
> This solves invalid memory references in following race condition
> scenario:
>=20
> Thread 1: charger manager
> Thread 2: power supply driver, used by charger manager
>=20
> THREAD 1 (charger manager)         THREAD 2 (power supply driver)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> psy =3D power_supply_get_by_name()
>                                    Driver unbind, .remove
>                                      power_supply_unregister()
>                                      Device fully removed
> psy->get_property()
>=20
> The 'get_property' call is executed in invalid context because the driver=
 was
> unbound and struct 'power_supply' memory was freed.
>=20
> This could be observed easily with charger manager driver (here compiled
> with max17040 fuel gauge):
>=20
> $ cat /sys/devices/virtual/power_supply/cm-battery/capacity &
> $ echo "1-0036" > /sys/bus/i2c/drivers/max17040/unbind
> [   55.725123] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> [   55.732584] pgd =3D d98d4000
> [   55.734060] [00000000] *pgd=3D5afa2831, *pte=3D00000000, *ppte=3D00000=
000
> [   55.740318] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
> [   55.746210] Modules linked in:
> [   55.749259] CPU: 1 PID: 2936 Comm: cat Tainted: G        W       3.19.=
0-rc1-next-20141226-00048-gf79f475f3c44-dirty #1496
> [   55.760190] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   55.766270] task: d9b76f00 ti: daf54000 task.ti: daf54000
> [   55.771647] PC is at 0x0
> [   55.774182] LR is at charger_get_property+0x2f4/0x36c
> [   55.779201] pc : [<00000000>]    lr : [<c034b0b4>]    psr: 60000013
> [   55.779201] sp : daf55e90  ip : 00000003  fp : 00000000
> [   55.790657] r10: 00000000  r9 : c06e2878  r8 : d9b26c68
> [   55.795865] r7 : dad81610  r6 : daec7410  r5 : daf55ebc  r4 : 00000000
> [   55.802367] r3 : 00000000  r2 : daf55ebc  r1 : 0000002a  r0 : d9b26c68
> [   55.808879] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
> [   55.815994] Control: 10c5387d  Table: 598d406a  DAC: 00000015
> [   55.821723] Process cat (pid: 2936, stack limit =3D 0xdaf54210)
> [   55.827451] Stack: (0xdaf55e90 to 0xdaf56000)
> [   55.831795] 5e80:                                     60000013 c01459c=
4 0000002a c06f8ef8
> [   55.839956] 5ea0: db651000 c06f8ef8 daebac00 c04cb668 daebac08 c034686=
4 00000000 c01459c4
> [   55.848115] 5ec0: d99eaa80 c06f8ef8 00000fff 00001000 db651000 c027f25=
c c027f240 d99eaa80
> [   55.856274] 5ee0: d9a06c00 c0146218 daf55f18 00001000 d99eaa80 db4c18c=
0 00000001 00000001
> [   55.864468] 5f00: daf55f80 c0144c78 c0144c54 c0107f90 00015000 d99eaab=
0 00000000 00000000
> [   55.872603] 5f20: 000051c7 00000000 db4c18c0 c04a9370 00015000 0000100=
0 daf55f80 00001000
> [   55.880763] 5f40: daf54000 00015000 00000000 c00e53dc db4c18c0 c00e548=
c 0000000d 00008124
> [   55.888937] 5f60: 00000001 00000000 00000000 db4c18c0 db4c18c0 0000100=
0 00015000 c00e5550
> [   55.897099] 5f80: 00000000 00000000 00001000 00001000 00015000 0000000=
3 00000003 c000f364
> [   55.905239] 5fa0: 00000000 c000f1a0 00001000 00015000 00000003 0001500=
0 00001000 0001333c
> [   55.913399] 5fc0: 00001000 00015000 00000003 00000003 00000002 0000000=
0 00000000 00000000
> [   55.921560] 5fe0: 7fffe000 be999850 0000a225 b6f3c19c 60000010 0000000=
3 00000000 00000000
> [   55.929744] [<c034b0b4>] (charger_get_property) from [<c0346864>] (pow=
er_supply_show_property+0x48/0x20c)
> [   55.939286] [<c0346864>] (power_supply_show_property) from [<c027f25c>=
] (dev_attr_show+0x1c/0x48)
> [   55.948130] [<c027f25c>] (dev_attr_show) from [<c0146218>] (sysfs_kf_s=
eq_show+0x84/0x104)
> [   55.956298] [<c0146218>] (sysfs_kf_seq_show) from [<c0144c78>] (kernfs=
_seq_show+0x24/0x28)
> [   55.964536] [<c0144c78>] (kernfs_seq_show) from [<c0107f90>] (seq_read=
+0x1b0/0x484)
> [   55.972172] [<c0107f90>] (seq_read) from [<c00e53dc>] (__vfs_read+0x18=
/0x4c)
> [   55.979188] [<c00e53dc>] (__vfs_read) from [<c00e548c>] (vfs_read+0x7c=
/0x100)
> [   55.986304] [<c00e548c>] (vfs_read) from [<c00e5550>] (SyS_read+0x40/0=
x8c)
> [   55.993164] [<c00e5550>] (SyS_read) from [<c000f1a0>] (ret_fast_syscal=
l+0x0/0x48)
> [   56.000626] Code: bad PC value
> [   56.011652] ---[ end trace 7b64343fbdae8ef1 ]---
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>=20
> [for the nvec part]
> Reviewed-by: Marc Dietrich <marvin24@gmx.de>
>=20
> [for compal-laptop.c]
> Acked-by: Darren Hart <dvhart@linux.intel.com>
>=20
> [for the mfd part]
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  [...]
>  drivers/acpi/ac.c                         |  32 ++--
>  drivers/acpi/battery.c                    |  55 ++++---
>  drivers/acpi/sbs.c                        |  68 +++++----
>  [...]
>  82 files changed, 2296 insertions(+), 1839 deletions(-)

I would like to merge this patch via power-supply tree. Can you
please provide your Acked-By?

-- Sebastian

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/v0XAAoJENju1/PIO/qafKUP/R6b3RmvJvt0sCCxiLXOmmEz
Lau6PrINSfDXCNEQYgAMW6mpmjLM73LGL2+qmAxn0eQWH8qw9f4/TM3QT6O3txJw
tYIMZNH0r96W3yD2HqYyEjVktLKcJUqUJEePG+zHOCoKCCUw7/hWwpUXYa2NuXKQ
soFiUVvp99Xou5BPXF5mlAqYySKlP5kvgd5Fsknoj+05kO6ws3tD33+Xv+emCVUT
CsSQkHXC5K73hk6cMUKWe/3qAUK68rDrf4/Zg6JmrO1eRBQpfsD3LPHjn9Duvv0R
z84tGWE2aPboidH+69EJxRflxrwl5/4myVm6j9R7e9IzT4XjwqlmO8y4qj0E8UPb
q4t6uISkVHb+RSGqoucolegftDPWifp9yxsaM31UnjEolVI22w4VKU8FX5R+zzNS
XtQO55NpUxNV0vbWGrLeh7msS5/zIc8GQSCz1fe9eGAsPr8Tdy5b9PlV9GkyOGeH
RHtUmKnMuucD/SDdA+VJcDg5/5zPsqnAngVGv6cz1/ZiJl573vPjUwMJLONrhYwb
8PFucn5tu9MerkvZKyqnljabtP3tCB3zpYLUGEuQyO5wQYXX4q4WDMqPE+zv6iVr
CsIpDXQ4XNNkiqr2V9tbwl3BkXbBmfs/w1rCmnHtLnw0qOu5cL6kJv12OgbA13F1
aoY0UsyQhsApShWmv79m
=mXL2
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
