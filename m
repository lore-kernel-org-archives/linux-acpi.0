From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ACPI: Set flag DOCK_UNDOCKING when triggered via sysfs
Date: Thu, 13 Mar 2008 10:27:57 -0700
Message-ID: <20080313102757.435c9d1a@appleyard>
References: <20080312000727.GB4089@homac>
	<20080311223522.3326b6ee.akpm@linux-foundation.org>
	<20080312104034.GA4371@homac>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755568AbYCMRcl@vger.kernel.org>
In-Reply-To: <20080312104034.GA4371@homac>
Sender: linux-kernel-owner@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 12 Mar 2008 11:40:35 +0100
Holger Macht <hmacht@suse.de> wrote:

> On Di 11. M=C3=A4r - 22:35:22, Andrew Morton wrote:
> > On Wed, 12 Mar 2008 01:07:27 +0100 Holger Macht <hmacht@suse.de>
> > wrote:
> >=20
> > > begin_undock() is only called when triggered via a acpi notify
> > > handler (pressing the undock button on the dock station), but
> > > complete_undock() is always called after the eject. So if a
> > > undock is triggered through a sysfs write, the flag
> > > DOCK_UNDOCKING has to be set for the dock station, too. Otherwise
> > > this will freeze the system hard.
> > >=20
> >=20
> > We prefer not to make systems freeze hard.
> >=20
> > > ---
> > >=20
> > > diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> > > index 307cef6..fa44fb9 100644
> > > --- a/drivers/acpi/dock.c
> > > +++ b/drivers/acpi/dock.c
> > > @@ -710,6 +710,7 @@ static ssize_t write_undock(struct device
> > > *dev, struct device_attribute *attr, if (!count)
> > >  		return -EINVAL;
> > > =20
> > > +	begin_undock(dock_station);
> > >  	ret =3D handle_eject_request(dock_station,
> > > ACPI_NOTIFY_EJECT_REQUEST); return ret ? ret: count;
> > >  }
> >=20
> > I assume that this is needed in 2.6.24.x as well?
>=20
> I tested this, and no, I weren't able to reproduce on 2.6.24.
>=20
> Moreover, it seems that the freeze is related to some libata issue
> because it only freezes when a drive is in the dock station.
>=20
> Nevertheless, I think the patch is correct. Maybe there's a race
> involved somewhere I'm not aware of. I really like to wait for
> Kristen to comment before pushing it into more trees.
>=20
> Thanks,
> 	Holger
>=20

Hum, I'm surprised this caused a freeze - you are sure this fixes your
problem?  This flag is never checked anywhere in the dock code, and if
it's not set, it will not matter, it will still do the undock.  The
flags file is exported to user space via sysfs though, so maybe because
the flag isn't being set, some user space script is doing something it
shouldn't?  The patch does seem correct though, so might as well add it=
=2E

Acked-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
