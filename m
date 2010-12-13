From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
	linux-acpi-2.6/test
Date: Mon, 13 Dec 2010 16:35:22 +0800
Message-ID: <1292229322.3983.29.camel@localhost.localdomain>
References: <201012112339.53105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21548 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab0LMIlO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 03:41:14 -0500
In-Reply-To: <201012112339.53105.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
> Hi Len,
>=20
> The following three patches seem to have been dropped from your 'test=
' branch.
>=20
> If that happened by accident, please reapply.  Otherwise, please let =
me know
> what's wrong with the patches so that I can fix them.
>=20
> [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead of
>         acpi_bus_get_power() which is unsafe.

=EF=BB=BFIt seems that the function of acpi_bus_update_power not only o=
btains
the current power state, but also set the corresponding power state.
Right?

If the device reports the bogus power state, maybe we will set the
incorrect power state for the corresponding device when using the
function of acpi_bus_update_power instead of acpi_bus_get_power. In suc=
h
case maybe the device can't work well.=20

The bogus power state is reported for some devices on some laptops. For
example:=20
    http://bugzilla.kernel.org/show_bug.cgi?id=3D8049
    http://bugzilla.kernel.org/show_bug.cgi?id=3D11000

Thanks.
     Yakui

>=20
> [2/3] - Drop acpi_bus_get_power() which is unsafe and has no users.
>=20
> [3/3] - Do not call __acpi_bus_get_power() from acpi_bus_set_power()
>         and remove acpi_power_nocheck that is not necessary any more.=
     =20
>=20
> Without these patches the power resources handling rework is incomple=
te and
> the code will not work correctly in some situations.=20
>=20
> Thanks,
> Rafael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
