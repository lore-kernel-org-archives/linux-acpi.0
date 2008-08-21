From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Thermal zone names
Date: Thu, 21 Aug 2008 17:48:52 +0200
Message-ID: <20080821174852.0689681d@hyperion.delvare>
References: <20080820223423.37f31780@hyperion.delvare>
	<1219282580.3209.140.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:6507 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYHUPtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 11:49:05 -0400
In-Reply-To: <1219282580.3209.140.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Rui,

On Thu, 21 Aug 2008 09:36:20 +0800, Zhang Rui wrote:
> On Thu, 2008-08-21 at 04:34 +0800, Jean Delvare wrote:
> > Hi Rui,
> >=20
> > The ACPI thermal zones in /proc/acpi/thermal_zone have a name. The
> > ACPI
> > thermal zones in /sys/class/thermal do not.
> First, the name used in procfs doesn't make sense.
> It just uses the arbitrary stings exported by BIOS. Some of them is
> meaningless, and even there may be duplicate names.

I thought that these names were unique identifiers for ACPI?

> The only benefit is that we can easily figure out which device in the
> ACPI namespace this interface is for.
>=20
> Second, /sys/class/thermal/thermal_zoneX/device is the symbol link to
> the real device node, and there is a sysfs I/F named "path" which can=
 be
> used for the same purpose (find corresponding devices in ACPI namespa=
ce)
>=20
> so it's okay that the ACPI thermal zones in /sys/class/thermal doesn'=
t
> have a name.

=46or lm-sensors users, the fact that the information is available
somewhere in sysfs isn't too interesting. Either the name is used as
the default label, or it's not.

> >  Would it be possible to add
> > it there? When these thermal zones are exported to libsensors, the
> > temperatures appear with their default labels (temp1, temp2, etc...=
)
> > Users sometimes wonder what these temperatures correspond to.
> Do you mean making use of "temp[1-*]_label"?

Yes, exactly.

> As we already know the BIOS name (procfs name) of an ACPI thermal sys=
fs
> class device, we can export the name of thermal sysfs class device in
> "=EF=BB=BF=EF=BB=BFtemp[1-*]_label", something like "thermal_zoneX".
> what do you think?

The name "thermal_zoneX" is not useful at all for the user. It's no
more informative than "tempX". What I wanted to print was the ACPI
name. Now you say that it's not meaningful. In that case there's simply
nothing we can do, sorry for the noise.

Thanks,
--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
