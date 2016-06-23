From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] acpi: dptf_power: Add DPTF power participant
Date: Fri, 24 Jun 2016 00:31:28 +0200
Message-ID: <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com>
References: <1466718134-29921-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37201 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcFWWba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 18:31:30 -0400
Received: by mail-wm0-f47.google.com with SMTP id a66so2373827wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2016 15:31:29 -0700 (PDT)
In-Reply-To: <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jun 23, 2016 at 11:42 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This driver adds support for Dynamic Platform and Thermal Framework
> (DPTF) Platform Power Participant device support.
> This participant is responsible for exposing platform telemetry such =
as
> platform Power, battery Information such as state of Charge, estimate=
d
> maximum sustainable power (PMax), SMART battery spec information.
>
> This driver is implemented as a platform driver for INT3407 and prese=
nted
> as power_supply device. Since this has common features with the ACPI
> battery, existing interface provide by battery_common driver are reus=
ed
> to present as a battery power supply device.
>
> When both CONFIG_ACPI_BATTERY and CONFIG_DPTF_POWER are defined and
> platform has support for INT3407, then dptf power registration is
> delayed for 100ms. In 100 ms, if there is no ACPI battery is register=
ed
> then dptf power will be registered. Since both can be modules and
> battery driver loads in async thread, there can be race even if we
> specify loading order for initialization.

=46irst, does the waiting actually help, though?

Second, to my eyes, even if acpi_battery load first, the dptf_power
thing will still bind to the same device, but via the platform bus
instead of the ACPI bus type.  I don't see anything preventing that
from happening in the patch, but maybe I missed something?

Also please put the part of the changelog below into a comment in
dptf_power.c (if you don't want to add a separate doc for that).

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
>
> For example representing AC/adapter properties as a power_supply
> properties will not make sense for a battery device. In some case
> when there is an existing property, the meaning is different.
> For example charger_type has a equivalent power_supply property,
> which has different symantics than INT3407.
>
> ACPI methods description used in this driver:
> PSOC: Platform Battery State Of Charge as a percentage.
> PMAX: Maximum platform power that can be supported by the battery in =
mW.
> PSRC: System charge source,
>         0x00 =3D DC
>         0x01 =3D AC
>         0x02 =3D USB
>         0x03 =3D Wireless Charger
> ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no AC
>         Adaptor is plugged in.
> CTYP: Charger Type,
>         Traditional : 0x01
>         Hybrid: 0x02
>         NVDC: 0x03
> PBSS: Returns max sustained power for battery in milliWatts.
> DPSP: Sets the polling interval in 10ths of seconds. A value of 0 tel=
ls
>         the driver to use event notification for PMAX and PBSS
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
