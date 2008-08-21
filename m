From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Thermal zone names
Date: Thu, 21 Aug 2008 09:36:20 +0800
Message-ID: <1219282580.3209.140.camel@rzhang-dt>
References: <20080820223423.37f31780@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21340 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbYHUBgv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2008 21:36:51 -0400
In-Reply-To: <20080820223423.37f31780@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-08-21 at 04:34 +0800, Jean Delvare wrote:
> Hi Rui,
>=20
> The ACPI thermal zones in /proc/acpi/thermal_zone have a name. The
> ACPI
> thermal zones in /sys/class/thermal do not.
=46irst, the name used in procfs doesn't make sense.
It just uses the arbitrary stings exported by BIOS. Some of them is
meaningless, and even there may be duplicate names.
The only benefit is that we can easily figure out which device in the
ACPI namespace this interface is for.

Second, /sys/class/thermal/thermal_zoneX/device is the symbol link to
the real device node, and there is a sysfs I/F named "path" which can b=
e
used for the same purpose (find corresponding devices in ACPI namespace=
)

so it's okay that the ACPI thermal zones in /sys/class/thermal doesn't
have a name.

>  Would it be possible to add
> it there? When these thermal zones are exported to libsensors, the
> temperatures appear with their default labels (temp1, temp2, etc...)
> Users sometimes wonder what these temperatures correspond to.
Do you mean making use of "temp[1-*]_label"?
As we already know the BIOS name (procfs name) of an ACPI thermal sysfs
class device, we can export the name of thermal sysfs class device in
"=EF=BB=BF=EF=BB=BFtemp[1-*]_label", something like "thermal_zoneX".
what do you think?

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
