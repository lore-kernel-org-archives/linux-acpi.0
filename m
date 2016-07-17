From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5] DPTF Platform power participant driver
Date: Sun, 17 Jul 2016 13:45:31 -0700
Message-ID: <1468788332-32518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51927 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcGQUrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Jul 2016 16:47:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The Intel =C2=AE Dynamic Platform and Thermal Framework (Intel =C2=AE D=
PTF) platform
Power Participant is responsible for exposing platform telemetry such a=
s
-Platform Power
-Battery Information such as State of Charge, estimated maximum
sustainable power (PMax), SMART battery spec information

The Platform Power related objects are exported via sysfs, but the batt=
ery
information objects are not exposed as they are already exposed by the
current ACPI battery driver.

v5:
Removed battery common part. No more changes to acpi battery driver.
The only platform power related attributes are presented via sysfs. For
battery status releated information, the user space need to look at the
acpi battery power supply information.

v4:
When both INT3407 and ACPI battery objects are present, then it will
cause two batteries to appear in Linux desktop. There is no way to
avoid this as long as we register with power_supply class. In this
version all battery information and state is presented in sysfs
instead using power_supply class for the DPTF power driver. DPTF
power driver will not register to the power supply class if ACPI_BATTER=
Y
config is defined.=20

v3:
Moved dptf_power to drivers/acpi/dptf folder.

v2:
When both CONFIG_ACPI_BATTERY and CONFIG_DPTF_POWER are defined and
platform has support for INT3407, then dptf power registration is
delayed for 100ms. In 100 ms, if there is no ACPI battery is registered
then dptf power will be registered. Since both can be modules and
battery driver loads in async thread, there can be race even if we
specify loading order for initialization.=20


Srinivas Pandruvada (1):
  acpi: dptf_power: Add DPTF power participant

 drivers/acpi/Kconfig           |   1 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/dptf/Kconfig      |  16 ++++++
 drivers/acpi/dptf/Makefile     |   3 +
 drivers/acpi/dptf/dptf_power.c | 128 +++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 drivers/acpi/dptf/Kconfig
 create mode 100644 drivers/acpi/dptf/Makefile
 create mode 100644 drivers/acpi/dptf/dptf_power.c

--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
