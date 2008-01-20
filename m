From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sun, 20 Jan 2008 17:49:19 -0200
Message-ID: <20080120194919.GE19295@khazad-dum.debian.net>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52705 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753449AbYATTtX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:49:23 -0500
Content-Disposition: inline
In-Reply-To: <20080119231916.GK28387@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, 19 Jan 2008, Theodore Tso wrote:
> Sure, and that means they have to *tell* *us* what they are doing so
> we can be compatible with Windows.  The concern is that they may be
> doing stuff that isn't in the standard ACPI spec, but which needs to
> be a certain way in order to be compatible with their proprietary
> Windows drivers.  

Or to be compatible with both Windows XP and Vista ACPI subsystems, *and*
the Windows XP and Vista versions of their proprietary drivers.  This is
probably where half the weirdness in Lenovo ThinkPads come from, IMHO.

> The real problem comes when they decide to do things in a rush.  That
> is, Dell deciding they want to make their laptops compatible with an
> already existing Ubuntu kernel, or Lenovo deciding they want to make
> their laptops compatible with an already existing SUSE kernel.  And,
> so they decide to do a quick and dirty firmware release rather than
> negotiating with the distribution to do an Errata kernel.  If we don't
> agressive move to nip this in the bud, even if a particular Thinkpad
> kernel isn't in the whitelist, I can see them simply documenting a
> workaround of setting acpi_osi=Linux in the boot command line, because
> it's easier than getting a distro to release a new kernel with a patch
> needed to support some new laptop....

Well, in defense of Lenovo, at least they seem to be quite open to changing
future BIOSes if we are really clear on what we request *and* we provide a
solution that won't cause total breakage on the kernels already in the Wild.

But asking any hardware vendor to do something that will work right with the
next version of Linux but will break hideously what distros have been
shipping already just won't fly.  Anything we do has to work well on both
past and current kernels, unfortunately.

Now, the real test will be if we ask for something that would require
changing their Windows drivers.  I sure hope they would do it, but...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
