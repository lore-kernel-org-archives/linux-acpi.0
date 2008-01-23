From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output from Benq notebook
Date: Wed, 23 Jan 2008 00:39:24 -0500
Message-ID: <200801230039.25357.lenb@kernel.org>
References: <web-7724225@backend13.aha.ru> <200801211822.42787.lenb@kernel.org> <20080122152907.GE17804@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57885 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbYAWFkH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 00:40:07 -0500
In-Reply-To: <20080122152907.GE17804@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: "Dmitry A. Marin" <corvax@corvax.ru>, linux-acpi@vger.kernel.org

On Tuesday 22 January 2008 10:29, Theodore Tso wrote:
> On Mon, Jan 21, 2008 at 06:22:42PM -0500, Len Brown wrote:
> > > The one thing I worry about is if you aren't including the BIOS
> > > version in the DMI list, you could end up in a situation where one
> > > version of the BIOS treats OSI(Linux) as a no-op, but a newer or an
> > > older version of the BIOS actually does something with it....
> > > 
> > > BIOS writers can be sneaky that way.  :-)
> > 
> > I'm not worried.
> > 
> > Vendors that want to make a BIOS change to actually benefit Linux
> > will actually boot Linux on their machine, and will notice
> > that OSI(Linux) has no effect in 2.6.23 and later.
> 
> You're giving the vendors far too much credit.  It's very likely that
> vendors will only test their BIOS on one distro kernel, probably of
> their distro partner.  So they may not notice that OSI(Linux) has no
> effect in 2.6.23 and later until it's too late (i.e., after they've
> stopped doing active firmware development on that BIOS series).

I agree it is likely that the laptop vendors would be focused
only on the snapshot of the Linux distro pre-installed on their SKU.

If the customer customer stays with the installed Linux
that was validated, then everybody is happy.

If the vendor supplies an upgrade for a .22 or earlier kernel
to a .23 or later kernel, or if the user takes the initiative
and does so with an upstream kernel, then any OSI(Linux) hook
will stop working, and they'll get a new dmesg warning asking them
to try acpi_osi=Linux.

If they don't read their dmesg, they'll call the vendor
and ask why their mute button stopped working after the ugprade.

> Hence, it's critical to get the distro kernel people involved, and
> have them issue errata kernels that matches the upstream behaviour,
> and/or get whoever has back-channel connections into HP, Dell, Lenovo,
> etc., involved in talking with the firmware development folks.
> Otherwise, we can *NOT* guarantee that the right thing will happen ---
> in fact it's fairly likely it won't!

We know for sure that we have to worry about Lenovo,
and I'd keep my eye on what Dell and HP do, since they also
dabble in Linux.

Everybody else seems to be invoking OSI(Linux) either
by habit, or by accident.

-Len
