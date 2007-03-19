From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 20:24:19 -0300
Message-ID: <20070319232419.GC5932@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070319120455.GI11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:43710 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965574AbXCSXYX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 19:24:23 -0400
Content-Disposition: inline
In-Reply-To: <20070319120455.GI11371@thunk.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Mon, 19 Mar 2007, Theodore Tso wrote:
> One more thing I would add from a power management perspective.  It
> should be able to powerdown the bay cleanly on suspend-to-ram, without
> necessarily disconnecting libata or unmounting the filesystem.  

The disconnect-or-not needs to be user-configurable, as the user may well
swap devices in the bay while the system is sleeping, AND this is supposed
to be a valid thing to do from a usercase PoV (earlier ThinkPad laptops only
had warm-swap bays, for example).  So must be the powerdown, I suppose, just
in case.

> It should also be possible for the user to be able to powerdown the
> bay (after first unmounting the filesystem and telling libata to let
> go of the device) if the user wishes to power down the bay for battery
> life reasons --- *without* requiring the user to eject the lever or
> remove the bay as a prerequisite to powering down the bay.

Currently the drivers do allow you to do just that, at least for the bay. I
don't know about docks.

> (The T60 burns enough power as it is, without any additional help from
> the bay.  :-)

Agreed :)  I want to add configurable powerdown-if-it-is-not-a-battery to
ibm-acpi, as it is acceptable to Linux.  Either Windows or some dumb
harddisk must dislike this for some stupid reason, as the DSDT doesn't do it
by itself and it could easily do it.

In fact, I suppose password-protected HDs might be a nuisance to power off
during S3, as they will be locked up when the system resumes...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
