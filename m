From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 08:04:55 -0400
Message-ID: <20070319120455.GI11371@thunk.org>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:42161 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965847AbXCSRC6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 13:02:58 -0400
Content-Disposition: inline
In-Reply-To: <20070315193123.GB14394@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Thu, Mar 15, 2007 at 04:31:24PM -0300, Henrique de Moraes Holschuh wrote:
> I will see what I can do.  My "first approach" at a requirements list for a
> proper bay module are as follows:
> 
> 1. It will handle all device types (ATAPI, PATA, SATA, batteries);
> 
> 2. It will do the right thing on plug and unplug.  This means telling the
> rest of the kernel to disable the device in the bay, for example.  Right now
> we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
> leave libata to scream blood murder until it disables its end due to too
> many retries, for example;
> 
> 3. It will allow model-specific drivers (like ibm-acpi) to be notified of
> bay events (callbacks or a notifier chain, since ACPICA doesn't allow for
> more than one driver notifier per handle) and to request an immediate
> attempt of ejection or hotplug/bay device change verification.  Some
> thinkpads benefit from an eject before S3 sleep -- as long as what is inside
> is not a battery...
> 
> I don't see why the generic driver could not do all of the above.  But it
> will take a while to get there :-)  And no, ibm-acpi can't do much more than
> (1).

One more thing I would add from a power management perspective.  It
should be able to powerdown the bay cleanly on suspend-to-ram, without
necessarily disconnecting libata or unmounting the filesystem.  

It should also be possible for the user to be able to powerdown the
bay (after first unmounting the filesystem and telling libata to let
go of the device) if the user wishes to power down the bay for battery
life reasons --- *without* requiring the user to eject the lever or
remove the bay as a prerequisite to powering down the bay.

(The T60 burns enough power as it is, without any additional help from
the bay.  :-)

						- Ted
