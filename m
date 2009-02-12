From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Temperature ridicuously high
Date: Thu, 12 Feb 2009 10:10:08 +0800
Message-ID: <1234404608.3652.54.camel@localhost.localdomain>
References: <1234370060.4341.9.camel@nepomuk.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6921 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757895AbZBLB6Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Feb 2009 20:58:25 -0500
In-Reply-To: <1234370060.4341.9.camel@nepomuk.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "k.lichtenwalder@computer.org" <k.lichtenwalder@computer.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-02-12 at 00:34 +0800, Klaus Lichtenwalder wrote:
> Hi,
>=20
> I'm a bit of a loss, I can't find anything about that on google or in
> the archive. I do have to machines with a foxconn G31MX motherboard.
> Everything is working fine, except the thermal_zone temperature is
> ridicuously high. I get a continous reading of about 200=C2=B0... Som=
etimes a
> machine shuts down because of too high values. In the same time, the
> cores (Intel 5200 DualCore) have a temperature of ca. 52=C2=B0. If I =
shut
> down the machine and check the bios reading, the temperature is at ab=
out
> 50=C2=B0... There's been a discussion with broken bioses on foxconn (=
mine
> have an award bios), but the problem there was suspend.
>=20
> I'm on Fedora 10. I activated the debug kernel and got the following =
log
> from acpi:
>=20
> Feb 11 16:13:21 nepomuk kernel: Execute Method: [\_TZ_.THRM._TMP] (No=
de
> ffff8800ceea8ea0)
> Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
> ex_system_memory_space: System-Memory (width 16) R/W 0
> Address=3D00000000000FF81A
> Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
> ex_system_memory_space: System-Memory (width 8) R/W 0
> Address=3D00000000000FF81C
> Feb 11 16:13:21 nepomuk kernel: exregion-0289 [00]
> ex_system_io_space_han: System-IO (width 8) R/W 1
> Address=3D0000000000000295
> Feb 11 16:13:21 nepomuk kernel: exregion-0289 [00]
> ex_system_io_space_han: System-IO (width 8) R/W 0
> Address=3D0000000000000296
> Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
> ex_system_memory_space: System-Memory (width 8) R/W 0
> Address=3D00000000000FF81C
> Feb 11 16:13:21 nepomuk kernel: exregion-0186 [00]
> ex_system_memory_space: System-Memory (width 8) R/W 0
> Address=3D00000000000FF840
> Feb 11 16:13:21 nepomuk kernel:   utils-0291 [00]
> evaluate_integer      : Return value [4772]
> Feb 11 16:13:21 nepomuk kernel: thermal-0262 [00]
> thermal_get_temperatur: Temperature is 4772 dK
>=20
> If somebody could help besides manipulating the kernel routine, this
> would be greatly appreciated.
Will you please attach the output of acpidump?
   Will you please also attach the output of /proc/acpi/thermal_zone/*/=
*
Thanks.
>=20
> thanks,
> Klaus

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
