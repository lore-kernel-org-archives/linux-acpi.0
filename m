From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output from Benq notebook
Date: Mon, 21 Jan 2008 18:22:42 -0500
Message-ID: <200801211822.42787.lenb@kernel.org>
References: <web-7724225@backend13.aha.ru> <200801201408.40945.lenb@kernel.org> <20080121075134.GC8105@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34423 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762420AbYAUXX1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 18:23:27 -0500
In-Reply-To: <20080121075134.GC8105@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: "Dmitry A. Marin" <corvax@corvax.ru>, linux-acpi@vger.kernel.org

On Monday 21 January 2008 02:51, Theodore Tso wrote:
> On Sun, Jan 20, 2008 at 02:08:40PM -0500, Len Brown wrote:
> > 
> > OSI(Linux) has no effect on the AML of this machine,
> > as OSYS is over-written.  So I'll just kill the warning
> > on this box by adding it to the NOP DMI list.
> 
> The one thing I worry about is if you aren't including the BIOS
> version in the DMI list, you could end up in a situation where one
> version of the BIOS treats OSI(Linux) as a no-op, but a newer or an
> older version of the BIOS actually does something with it....
> 
> BIOS writers can be sneaky that way.  :-)

I'm not worried.

Vendors that want to make a BIOS change to actually benefit Linux
will actually boot Linux on their machine, and will notice
that OSI(Linux) has no effect in 2.6.23 and later.

The object here is simply to identify systems which have already
shipped (say they were tested against Linux-2.6.22 or earlier)
that really do require OSI(Linux).

The reason we put in a BenQ DMI entry was simply to prevent
spamming dmesg with requests for DMI info and test results
that we already have.  I have zero interest in spamming users
of every version of the platform's BIOS to confirm that
they are all the same.  Indeed, I'd be more inclined to
wildcard the DMI entries more by deleting some of the
platforms and ignoring entire Vendors w/ a single entry --
as the vendors tend to do the same thing on every product.

thanks,
-Len
