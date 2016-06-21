From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] acpi: dptf_power: Add DPTF power participant
Date: Tue, 21 Jun 2016 18:15:24 +0200
Message-ID: <3608744.BspMuIr5nt@vostro.rjw.lan>
References: <1462589984-27253-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1462589984-27253-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64269 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751863AbcFUQRr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2016 12:17:47 -0400
In-Reply-To: <1462589984-27253-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday, May 06, 2016 07:59:43 PM Srinivas Pandruvada wrote:
> This driver adds support for Dynamic Platform and Thermal Framework
> (DPTF) Platform Power Participant device support.
> This participant is responsible for exposing platform telemetry such =
as
> platform Power, battery Information such as state of Charge, estimate=
d
> maximum sustainable power (PMax), SMART battery spec information.
>=20
> This driver is implemented as a platform driver for INT3407 and prese=
nted
> as power_supply device. Since this has common features with the ACPI
> battery, existing interface provide by battery_common driver are reus=
ed
> to present as a battery power supply device.
>=20
> Since this driver will also register a battery power supply device,th=
is
> driver will exit if CONFIG_ACPI_BATTERY is defined.
>=20
> There are two types of objects in INT3407:
> - Same as ACPI Battery objects: _BST and _BIX. These are exposed as
> standard power supply attributes.
> - Specific to INT3407, which are related to platform power
> There are some objects, for which it doesn't make sense to enhance
> power_supply class and add attributes there. They are represented as
> sysfs attribute under acpi device. Here the bid for INT3407 is TPWR
> in the following example.
> /sys/class/power_supply/TPWR
> =E2=94=9C=E2=94=80=E2=94=80 alarm
> =E2=94=9C=E2=94=80=E2=94=80 capacity
> =E2=94=9C=E2=94=80=E2=94=80 capacity_level
> =E2=94=9C=E2=94=80=E2=94=80 cycle_count
> =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../INT3407:00
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 dptf_power
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 adapter_rating
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 battery_steady_po=
wer
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 charger_type
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 max_platform_powe=
r
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 platform_power_so=
urce
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power_sampling_pe=
riod
>=20
> For example representing AC/adapter properties as a power_supply
> properties will not make sense for a battery device. In some case
> when there is an existing property, the meaning is different.
> For example charger_type has a equivalent power_supply property,
> which has different symantics than INT3407.
>=20
> ACPI methods description used in this driver:
> PSOC: Platform Battery State Of Charge as a percentage.
> PMAX: Maximum platform power that can be supported by the battery in =
mW.
> PSRC: System charge source,
> 	0x00 =3D DC
> 	0x01 =3D AC
> 	0x02 =3D USB
> 	0x03 =3D Wireless Charger
> ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no AC
> 	Adaptor is plugged in.
> CTYP: Charger Type,
> 	Traditional : 0x01
> 	Hybrid: 0x02
> 	NVDC: 0x03
> PBSS: Returns max sustained power for battery in milliWatts.
> DPSP: Sets the polling interval in 10ths of seconds. A value of 0 tel=
ls
> 	the driver to use event notification for PMAX and PBSS
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> ---
>  drivers/acpi/Kconfig      |  19 ++++++
>  drivers/acpi/Makefile     |   1 +
>  drivers/acpi/dptf_power.c | 157 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 drivers/acpi/dptf_power.c
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index bc5af2c..ac5cfe8 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -526,4 +526,23 @@ config XPOWER_PMIC_OPREGION
> =20
>  endif
> =20
> +config DPTF_POWER
> +	tristate "DPTF Platform Power Participant"
> +	depends on X86 && !ACPI_BATTERY

After a closer look, distros won't like this.

They need to have a binary image that will work on all systems, so they=
 need
to be able to build both modules at the same time.

I guess the DPTF one can be made look if there is a driver attached to =
the
battery device object already and bail out if that's the case.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
