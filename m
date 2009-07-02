From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Thu, 2 Jul 2009 10:20:00 +0200
Message-ID: <200907021020.00786.jdelvare@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <200907012319.53021.trenn@suse.de> <4911F71203A09E4D9981D27F9D8308582EA040F1@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50511 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbZGBIT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 04:19:59 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582EA040F1@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Robert,

Le jeudi 02 juillet 2009, Moore, Robert a =E9crit=A0:
> could still detect most i2c/smbus/hwmon devices conflicts.
>=20
> What exactly are these conflicts?

Native Linux drivers trying to access devices which ACPI also wants
to access. Most frequently these are SMBus master drivers or hardware
monitoring drivers (for Super I/O chips) but virtually any other
device type could be affected, due to the fact that ACPI I/O
resources do not show up in /proc/ioports and /proc/iomem.

The workaround written by Thomas would let the native drivers which
are more frequently affected by the problem ask the ACPI subsystem,
on a voluntary basis, if a given I/O range is safe to use. While not
perfect, it worked reasonably well in practice.

Your upstream commit broke this safety mechanism, and now all the
past bugs resulting of native driver vs. ACPI conflicts show up
again, so you will have to fix it now. Either by reverting your
commit, or by coming up with a better safety. I don't know much about
ACPI so I can't really comment on a technical perspective. All I care
about is the functionality: either concurrent access from native
drivers and ACPI must be doable safely, or it must be prevented
altogether (which Thomas' code was doing.)

I will be happy to answer your questions about the native Linux
drivers for SMBus master devices and hardware monitoring devices.
I can also help with testing if you want.

--=20
Jean Delvare
Suse L3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
