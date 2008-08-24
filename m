From: Thomas Renninger <trenn@suse.de>
Subject: Re: Thermal zone names
Date: Mon, 25 Aug 2008 00:06:08 +0200
Message-ID: <200808250006.09106.trenn@suse.de>
References: <20080820223423.37f31780@hyperion.delvare> <1219282580.3209.140.camel@rzhang-dt> <20080821174852.0689681d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37913 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbYHXWGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 18:06:47 -0400
In-Reply-To: <20080821174852.0689681d@hyperion.delvare>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Thursday 21 August 2008 05:48:52 pm Jean Delvare wrote:
> Hi Rui,
>
> On Thu, 21 Aug 2008 09:36:20 +0800, Zhang Rui wrote:
> > On Thu, 2008-08-21 at 04:34 +0800, Jean Delvare wrote:
> > > Hi Rui,
> > >
> > > The ACPI thermal zones in /proc/acpi/thermal_zone have a name. The
> > > ACPI
> > > thermal zones in /sys/class/thermal do not.
> >
> > First, the name used in procfs doesn't make sense.
> > It just uses the arbitrary stings exported by BIOS. Some of them is
> > meaningless, and even there may be duplicate names.
>
> I thought that these names were unique identifiers for ACPI?
Theoretically no: You can have the same device name in different scopes.
e.g. XYZ.THERM and ZYX.THERM
while THERM could always be a thermal device.

In practice they must not be identical or we have duplicate names in:
/proc/acpi/thermal_zone/*
The only place where we really saw duplicate entries of the same device type
was for video devices. But this showed the broken design of /proc/acpi which
cannot happen for /sys/bus/acpi/devices/* anymore.

But Zhang is right, the assumption in /proc/ that the names are always unique
was wrong.
>
> > The only benefit is that we can easily figure out which device in the
> > ACPI namespace this interface is for.
> >
> > Second, /sys/class/thermal/thermal_zoneX/device is the symbol link to
> > the real device node, and there is a sysfs I/F named "path" which can be
> > used for the same purpose (find corresponding devices in ACPI namespace)
> >
> > so it's okay that the ACPI thermal zones in /sys/class/thermal doesn't
> > have a name.
>
> For lm-sensors users, the fact that the information is available
> somewhere in sysfs isn't too interesting. Either the name is used as
> the default label, or it's not.
I found a function inside a thermal zone on an HP which seem to be the name.
It is not mentioned in the spec, but we could document that and tell vendors 
to use it. Hmm, it should start with "_" if this should get specified at 
later time?

I post a little RFC patch which makes use of this one as a hwmon thermal 
device/zone name.
Totally untested...

        Thomas
