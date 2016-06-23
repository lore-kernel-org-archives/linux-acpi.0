From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] DPTF Platform power participant driver
Date: Wed, 22 Jun 2016 20:42:40 -0700
Message-ID: <1466653363-7311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43498 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbcFVUoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 16:44:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This series implements DPTF power participant driver. Intel =C2=AE Dyna=
mic
Platform and Thermal Framework (Intel =C2=AE DPTF) platform Power Parti=
cipant
is responsible for exposing platform telemetry such as
-Platform Power
-Battery Information such as State of Charge, estimated maximum
sustainable power (PMax), SMART battery spec information
Intel =C2=AE DPTF Power Participant loads as an ACPI Device (INT3407). =
This
device utilizes and exposes the platform power and Fuel Gauge informati=
on
and capabilities to the framework and for the policies to take control
action.=20

Implementation wise this is power supply battery driver with additional
attributes for platform power objects.
So the first patch splits the battery driver into two parts, a common p=
art
and a ACPI battery enumeration part.
Next two patches add support for dptf power driver which uses common
battery driver and adds additional attributes for platform power.

v2:
When both CONFIG_ACPI_BATTERY and CONFIG_DPTF_POWER are defined and
platform has support for INT3407, then dptf power registration is
delayed for 100ms. In 100 ms, if there is no ACPI battery is registered
then dptf power will be registered. Since both can be modules and
battery driver loads in async thread, there can be race even if we
specify loading order for initialization.=20

Srinivas Pandruvada (3):
  acpi: battery: Split battery driver for reuse by DPTF power
    participant
  acpi: dptf_power: Add DPTF power participant
  acpi: battery_common: battery present status for INT3407

 drivers/acpi/Kconfig          |   22 +
 drivers/acpi/Makefile         |    2 +
 drivers/acpi/battery.c        | 1199 +--------------------------------=
----
 drivers/acpi/battery.h        |   31 +
 drivers/acpi/battery_common.c | 1299 +++++++++++++++++++++++++++++++++=
++++++++
 drivers/acpi/dptf_power.c     |  184 ++++++
 6 files changed, 1543 insertions(+), 1194 deletions(-)
 create mode 100644 drivers/acpi/battery_common.c
 create mode 100644 drivers/acpi/dptf_power.c

--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
