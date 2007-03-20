From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 10:57:22 -0400
Message-ID: <20070320145722.GB6043@thunk.org>
References: <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070319120455.GI11371@thunk.org> <20070319232419.GC5932@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:40631 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbXCTO5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 10:57:30 -0400
Content-Disposition: inline
In-Reply-To: <20070319232419.GC5932@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Mon, Mar 19, 2007 at 08:24:19PM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 19 Mar 2007, Theodore Tso wrote:
> > One more thing I would add from a power management perspective.  It
> > should be able to powerdown the bay cleanly on suspend-to-ram, without
> > necessarily disconnecting libata or unmounting the filesystem.  
> 
> The disconnect-or-not needs to be user-configurable, as the user may well
> swap devices in the bay while the system is sleeping, AND this is supposed
> to be a valid thing to do from a usercase PoV (earlier ThinkPad laptops only
> had warm-swap bays, for example).  So must be the powerdown, I suppose, just
> in case.

Maybe, but then the suspend mail have to fail if there are processes
that are keeping the filesystem from being unmounted.  Or the
processes hanging out on the hard drive or CD-ROM could get all of
their file descriptors revoked on resume, I suppose, if the bay has
been switched out.....

							- Ted
