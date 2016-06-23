From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3 2/3] acpi: dptf_power: Add DPTF power participant
Date: Thu, 23 Jun 2016 16:19:30 -0700
Message-ID: <1466723970.8970.69.camel@linux.intel.com>
References: <1466718134-29921-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43491 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcFWXSA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 19:18:00 -0400
In-Reply-To: <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, 2016-06-24 at 00:31 +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2016 at 11:42 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > This driver adds support for Dynamic Platform and Thermal Framework
> > (DPTF) Platform Power Participant device support.
> > This participant is responsible for exposing platform telemetry
> > such as
> > platform Power, battery Information such as state of Charge,
> > estimated
> > maximum sustainable power (PMax), SMART battery spec information.
> >=20
> > This driver is implemented as a platform driver for INT3407 and
> > presented
> > as power_supply device. Since this has common features with the
> > ACPI
> > battery, existing interface provide by battery_common driver are
> > reused
> > to present as a battery power supply device.
> >=20
> > When both CONFIG_ACPI_BATTERY and CONFIG_DPTF_POWER are defined and
> > platform has support for INT3407, then dptf power registration is
> > delayed for 100ms. In 100 ms, if there is no ACPI battery is
> > registered
> > then dptf power will be registered. Since both can be modules and
> > battery driver loads in async thread, there can be race even if we
> > specify loading order for initialization.
> First, does the waiting actually help, though?
Yes, if the acpi_battery registered then
if (!battery_registered) will be false.

>=20
> Second, to my eyes, even if acpi_battery load first, the dptf_power
> thing will still bind to the same device, but via the platform bus
> instead of the ACPI bus type.=C2=A0=C2=A0I don't see anything prevent=
ing that
> from happening in the patch, but maybe I missed something?
>=20
The INT3407 object also has battery=C2=A0_BST and _BIX, so driver will =
bind
to this device not with=C2=A0PNP0C0A battery device. Either of them sho=
uld
be able to register and provide battery information. But the names are
different (BAT vs TPWR on my platform)
The check=C2=A0if (!battery_registered) will fail, so dptf_power will n=
ot
register. So we will not see two batteries registered with power supply
class (and hence no two batteries in desktop UI).

Thanks,
Srinivas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
