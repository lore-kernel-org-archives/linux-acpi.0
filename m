From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/3] acpi: dptf_power: Add DPTF power participant
Date: Thu, 23 Jun 2016 15:23:47 +0200
Message-ID: <CAJZ5v0j8ybZRF7AYeXaOqf_Oo7Qnpi53ymRoxzYA5gW7tqMCgw@mail.gmail.com>
References: <1466653363-7311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466653363-7311-3-git-send-email-srinivas.pandruvada@linux.intel.com> <CAJZ5v0g-jZqobJQax-mxBnTnm7ZH2V5=bMLvWTcqVQbraBqxjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36590 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcFWNXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 09:23:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so10973351wme.3
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2016 06:23:49 -0700 (PDT)
In-Reply-To: <CAJZ5v0g-jZqobJQax-mxBnTnm7ZH2V5=bMLvWTcqVQbraBqxjQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>

On Thu, Jun 23, 2016 at 1:48 AM, Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> On Thu, Jun 23, 2016 at 5:42 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> This driver adds support for Dynamic Platform and Thermal Framework
>> (DPTF) Platform Power Participant device support.
>> This participant is responsible for exposing platform telemetry such=
 as
>> platform Power, battery Information such as state of Charge, estimat=
ed
>> maximum sustainable power (PMax), SMART battery spec information.
>>
>> This driver is implemented as a platform driver for INT3407 and pres=
ented
>> as power_supply device. Since this has common features with the ACPI
>> battery, existing interface provide by battery_common driver are reu=
sed
>> to present as a battery power supply device.
>>
>> Since this driver will also register a battery power supply device,t=
his
>> driver will exit if CONFIG_ACPI_BATTERY is defined.
>>
>> There are two types of objects in INT3407:
>> - Same as ACPI Battery objects: _BST and _BIX. These are exposed as
>> standard power supply attributes.
>> - Specific to INT3407, which are related to platform power
>> There are some objects, for which it doesn't make sense to enhance
>> power_supply class and add attributes there. They are represented as
>> sysfs attribute under acpi device.
>
> The below part of the changelog should really go to a doc under Docum=
entation/.
>
>> Here the bid for INT3407 is TPWR
>> in the following example.
>> /sys/class/power_supply/TPWR
>> =E2=94=9C=E2=94=80=E2=94=80 alarm
>> =E2=94=9C=E2=94=80=E2=94=80 capacity
>> =E2=94=9C=E2=94=80=E2=94=80 capacity_level
>> =E2=94=9C=E2=94=80=E2=94=80 cycle_count
>> =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../INT3407:00
>> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 dptf_power
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 adapter_rating
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 battery_steady_p=
ower
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 charger_type
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 max_platform_pow=
er
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 platform_power_s=
ource
>> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power_sampling_p=
eriod
>>
>> For example representing AC/adapter properties as a power_supply
>> properties will not make sense for a battery device. In some case
>> when there is an existing property, the meaning is different.
>> For example charger_type has a equivalent power_supply property,
>> which has different symantics than INT3407.
>>
>> ACPI methods description used in this driver:
>> PSOC: Platform Battery State Of Charge as a percentage.
>> PMAX: Maximum platform power that can be supported by the battery in=
 mW.
>> PSRC: System charge source,
>>         0x00 =3D DC
>>         0x01 =3D AC
>>         0x02 =3D USB
>>         0x03 =3D Wireless Charger
>> ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no A=
C
>>         Adaptor is plugged in.
>> CTYP: Charger Type,
>>         Traditional : 0x01
>>         Hybrid: 0x02
>>         NVDC: 0x03
>> PBSS: Returns max sustained power for battery in milliWatts.
>> DPSP: Sets the polling interval in 10ths of seconds. A value of 0 te=
lls
>>         the driver to use event notification for PMAX and PBSS
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.=
com>
>> ---
>>  drivers/acpi/Kconfig      |  17 +++++
>>  drivers/acpi/Makefile     |   1 +
>>  drivers/acpi/dptf_power.c | 184 +++++++++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 202 insertions(+)
>>  create mode 100644 drivers/acpi/dptf_power.c
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 27ae351..03a34b4 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -526,4 +526,21 @@ config XPOWER_PMIC_OPREGION
>>
>>  endif
>>
>> +config DPTF_POWER
>> +       tristate "DPTF Platform Power Participant"
>> +       depends on X86
>> +       select ACPI_BATTERY_COMMON
>> +       select POWER_SUPPLY
>> +       default y
>> +       help
>> +         This driver adds support for Dynamic Platform and Thermal =
=46ramework
>> +         (DPTF) Platform Power Participant device support.
>> +         This participant is responsible for exposing platform tele=
metry such
>> +         as platform Power, battery Information such as state of Ch=
arge,
>> +         estimated maximum sustainable power (PMax), SMART battery =
spec
>> +         information.
>> +
>> +         To compile this driver as a module, choose M here:
>> +         the module will be called dptf_power.
>> +
>>  endif  # ACPI
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 950bf8e..1c76715 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -75,6 +75,7 @@ obj-$(CONFIG_ACPI)            +=3D acpi_memhotplug=
=2Eo
>>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
>>  obj-$(CONFIG_ACPI_BATTERY_COMMON) +=3D battery_common.o
>>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
>> +obj-$(CONFIG_DPTF_POWER)       +=3D dptf_power.o
>
> Now that I think about it, maybe it would be better to put that into
> drivers/platform/x86?

Or we can create a dptf directory under drivers/acpi/ if you prefer.

I'd rather avoid mixing the DPTF stuff with generic ACPI code in any ca=
se.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
