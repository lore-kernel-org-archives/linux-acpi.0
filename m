From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: dmidecode output from Benq notebook
Date: Tue, 22 Jan 2008 10:29:07 -0500
Message-ID: <20080122152907.GE17804@mit.edu>
References: <web-7724225@backend13.aha.ru> <200801201408.40945.lenb@kernel.org> <20080121075134.GC8105@mit.edu> <200801211822.42787.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56953 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350AbYAVP3b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 10:29:31 -0500
Content-Disposition: inline
In-Reply-To: <200801211822.42787.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Dmitry A. Marin" <corvax@corvax.ru>, linux-acpi@vger.kernel.org

On Mon, Jan 21, 2008 at 06:22:42PM -0500, Len Brown wrote:
> > The one thing I worry about is if you aren't including the BIOS
> > version in the DMI list, you could end up in a situation where one
> > version of the BIOS treats OSI(Linux) as a no-op, but a newer or an
> > older version of the BIOS actually does something with it....
> > 
> > BIOS writers can be sneaky that way.  :-)
> 
> I'm not worried.
> 
> Vendors that want to make a BIOS change to actually benefit Linux
> will actually boot Linux on their machine, and will notice
> that OSI(Linux) has no effect in 2.6.23 and later.

You're giving the vendors far too much credit.  It's very likely that
vendors will only test their BIOS on one distro kernel, probably of
their distro partner.  So they may not notice that OSI(Linux) has no
effect in 2.6.23 and later until it's too late (i.e., after they've
stopped doing active firmware development on that BIOS series).
Hence, it's critical to get the distro kernel people involved, and
have them issue errata kernels that matches the upstream behaviour,
and/or get whoever has back-channel connections into HP, Dell, Lenovo,
etc., involved in talking with the firmware development folks.
Otherwise, we can *NOT* guarantee that the right thing will happen ---
in fact it's fairly likely it won't!

				- Ted
