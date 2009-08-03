From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH 2/2] acpi_power_meter: hwmon driver for ACPI 4.0 power
	meters
Date: Mon, 3 Aug 2009 13:52:29 -0700
Message-ID: <20090803205229.GB14694@plum>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com> <1248677155.2670.132.camel@rzhang-dt>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:58891 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbZHCUwa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Aug 2009 16:52:30 -0400
Content-Disposition: inline
In-Reply-To: <1248677155.2670.132.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Jul 27, 2009 at 02:45:55PM +0800, Zhang Rui wrote:
> Hi, Darrick,
>=20
> great job. :)

Thanks.

> we should at least send a netlink event for an ACPI power meter
> notification, shouldn't we?

Yes, an event would be useful at the very least for when the system sta=
rts
capping, though unfortunately there doesn't seem to be a Notify event f=
or when
capping ends.

> we should create the hwmon sysfs I/F for the hwmon device,
> i.e. add the hwmon attributes
> under /sys/devices/LINUXSYS:00/.../ACPI000D:00/hwmon0/
> rather than =EF=BB=BF/sys/devices/LINUXSYS:00/.../ACPI000D:00/

Hee, this is a tricky matter.  The other hwmon drivers create sysfs att=
ributes
under the sysfs object, not in a separate "hwmonX" object, and as I rec=
all
libsensors reads symlinks under the device object to figure out which b=
us the
sensor device lives on.  If it can't figure that out, it ignores the hw=
mon
device.

> 	  if (acpi_disable)
> 		return -ENODEV;

Noted.

> plus, _PMD is not supported in this driver, right?
> I agree with Yakui that we can create some ACPI device sysfs attribut=
es
> besides the hwmon ones. e.g. exporting devices measured by the curren=
t
> ACPI power meter device to user space.

I agree.

--D
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
