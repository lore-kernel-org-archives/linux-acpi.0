From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 12:14:43 -0300
Message-ID: <20070320151443.GB13042@khazad-dum.debian.net>
References: <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070319120455.GI11371@thunk.org> <20070319232419.GC5932@khazad-dum.debian.net> <20070320145722.GB6043@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60669 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933681AbXCTPOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:14:48 -0400
Content-Disposition: inline
In-Reply-To: <20070320145722.GB6043@thunk.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Tue, 20 Mar 2007, Theodore Tso wrote:
> > The disconnect-or-not needs to be user-configurable, as the user may well
> > swap devices in the bay while the system is sleeping, AND this is supposed
> > to be a valid thing to do from a usercase PoV (earlier ThinkPad laptops only
> > had warm-swap bays, for example).  So must be the powerdown, I suppose, just
> > in case.
> 
> Maybe, but then the suspend mail have to fail if there are processes
> that are keeping the filesystem from being unmounted.  Or the

Yes. But this is standard functionality on the suspend path, anyway.

> processes hanging out on the hard drive or CD-ROM could get all of
> their file descriptors revoked on resume, I suppose, if the bay has
> been switched out.....

Urk.  It is better to either fail the suspend, or to not power down the bay.
Or to give the user a choice of which he'd rather happen.  Hmm...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
