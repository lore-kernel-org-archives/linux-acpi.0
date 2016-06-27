From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3 2/3] acpi: dptf_power: Add DPTF power participant
Date: Mon, 27 Jun 2016 11:09:05 -0700
Message-ID: <1467050945.8970.86.camel@linux.intel.com>
References: <1466718134-29921-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com>
	 <1466723970.8970.69.camel@linux.intel.com>
	 <CAJZ5v0ithpoZfHJQwfyLdrsLyU1-M8psrJz12eaOTR9ffCTPOQ@mail.gmail.com>
	 <1466991116.5580.11.camel@linux.intel.com>
	 <CAJZ5v0hR9E-pLkkvbSLwLG8A1ECCVa=+45YJ1+L1cjXHaPaLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32074 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbcF0SHl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 14:07:41 -0400
In-Reply-To: <CAJZ5v0hR9E-pLkkvbSLwLG8A1ECCVa=+45YJ1+L1cjXHaPaLtg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 2016-06-27 at 03:45 +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 27, 2016 at 3:31 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Fri, 2016-06-24 at 02:26 +0200, Rafael J. Wysocki wrote:
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > On Fri, Jun 24, 2016 at 1:19 AM, Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >=20
> > > > On Fri, 2016-06-24 at 00:31 +0200, Rafael J. Wysocki wrote:
> > > > >=20
> > > > > On Thu, Jun 23, 2016 at 11:42 PM, Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > [...]
> >=20
> > >=20
> > > I think what you need is that if acpi_battery is bound to at
> > > least
> > > one
> > > device, you don't want to bind dptf_power to
> > > anything.=C2=A0=C2=A0Conversely,
> > > if
> > > dptf_power has been bound to at least one device, you don't want
> > > to
> > > bind acpi_battery to anything.
> > >=20
> > > That may be achieved with a lock and two counters, one (A)
> > > incremented
> > > only by acpi_battery and the other (B) incremented only by
> > > dptf_power
> > > and such that you can't increment A if B is different from 0 and
> > > you
> > > can't increment B if A is different from 0.=C2=A0=C2=A0Of course,=
 each
> > > driver
> > > would need to specify which counter it wants to use (A or B), so
> > > that
> > > would take an additional argument to acpi_battery_common_add()
> > > and an
> > > additional field in struct acpi_battery (for the remove
> > > operation).
> > >=20
> > > With that, I think it should only be possible to build both
> > > acpi_battery and dptf_power if they are both modules.=C2=A0=C2=A0=
IOW,
> > > DPTF_POWER
> > > should depend on (!ACPI_BATTERY || ACPI_BATTERY=3Dm) or
> > > similar.=C2=A0=C2=A0And
> > > if
> > > they are both modules, let user space manage that.
> > >=20
> > > And the waiting itself doesn't add any value then IMO.
> > Yes. I think the best solution is not to let define DPTF_POWER when
> > the
> > ACPI_BATTERY is defined same as my first version of the patch or
> > let
> > both add as there is no harm as they will show same levels. The
> > reason
> > is:
> > We have some devices with two ACPI_BATTERIES (primary and
> > secondary/backup) and they must be presented as two power supply
> > devices to user space. In those devices DPTF_POWER may be
> > equivalent to
> > only one of the ACPI_BATTERY (Will point to same battery for
> > Battery
> > levels). So we can't simply refuse to add ACPI_BATTERY device
> > addition
> > because DPTF_POWER device is registered before.
> OK
>=20
> Say dptf_power points to the same battery device as acpi_battery.=C2=A0=
=C2=A0Is
> there any way to tell when that happens?
May be we can memcmp the output of _BIX (Battery Information Extended).
If they are same it belongs to same battery.
If there are two ACPI batteries, hope atleast they have difference in
one element in the following package.

Package {
// ASCIIZ is ASCII character string terminated with a 0x00.
Revision
//Integer
Power Unit
//Integer (DWORD)
Design Capacity
//Integer (DWORD)
Last Full Charge Capacity
//Integer (DWORD)
Battery Technology
//Integer (DWORD)
Design Voltage
//Integer (DWORD)
Design Capacity of Warning
//Integer (DWORD)
Design Capacity of Low
//Integer (DWORD)
Cycle Count
//Integer (DWORD)
Measurement Accuracy
Max Sampling Time
Min Sampling Time
Max Averaging Interval
Min Averaging Interval //Integer
//Integer
//Integer
//Integer
//Integer
(DWORD)
(DWORD)
(DWORD)
(DWORD)
(DWORD)
Battery Capacity Granularity 1
Battery Capacity Granularity 2
Model Number
Serial Number
Battery Type
OEM Information
}

Thanks,
Srinivas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
