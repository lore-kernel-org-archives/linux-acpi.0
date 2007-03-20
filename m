From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 14:45:41 -0400
Message-ID: <20070320184541.GB29493@thunk.org>
References: <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070319120455.GI11371@thunk.org> <20070319232419.GC5932@khazad-dum.debian.net> <20070320145722.GB6043@thunk.org> <20070320151443.GB13042@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:58806 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965621AbXCTSpu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 14:45:50 -0400
Content-Disposition: inline
In-Reply-To: <20070320151443.GB13042@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Tue, Mar 20, 2007 at 12:14:43PM -0300, Henrique de Moraes Holschuh wrote:
> > Maybe, but then the suspend mail have to fail if there are processes
> > that are keeping the filesystem from being unmounted.  Or the
> 
> Yes. But this is standard functionality on the suspend path, anyway.

The problem with this is that some users will hit the suspend button,
close the lid, put the laptop into their laptop bag, and then
immediately head off to the next conference talk (or whatever).  If
the suspend is going to fail, they might not notice, and they might
not swap out the bay in any case.  

> > processes hanging out on the hard drive or CD-ROM could get all of
> > their file descriptors revoked on resume, I suppose, if the bay has
> > been switched out.....
> 
> Urk.  It is better to either fail the suspend, or to not power down the bay.
> Or to give the user a choice of which he'd rather happen.  Hmm...

Yeah, I think it needs to be configurable.  In many cases the right
thing to do is for the user to promise not to swap out bay, and in the
exception case where they do, all of the processes that have files
open on that bay will have to get their fd's revoked.  We can try to
make it less likely for there to be data loss, like asking filesystems
that support write_super_lockfs() to quiesce the filesystem before the
suspend, but the assumption should be that users aren't supposed to be
swapping out the bay if they request the suspend code not to
disconnect the filesystem.

						- Ted
