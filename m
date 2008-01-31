From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Thu, 31 Jan 2008 14:17:57 -0500
Message-ID: <200801311417.57469.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <1201714051.1222.131.camel@queen.suse.de> <47A0FBD4.6090603@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54730 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933906AbYAaTSe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 14:18:34 -0500
In-Reply-To: <47A0FBD4.6090603@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>


> > In fact, I added the array some time ago.
> > Not sure whether the latest Version of Eric/Markus can also load several
> > DSDT/SSDTs? Maybe you found a more elegant way?

> Nope. On the website (http://gaugusch.at/kernel.shtml) you can just find 
> two versions of the patch: one simple and one with your addition for 
> SSDTs support. At least with SSDTs support there is even an advantage 
> over the DSDT-in-kernel version :-)


At one point there was a proposal to allow in-kernel SSDT overrides,
but we determined that it was problematic because there can be any
number of SSDTs (so which one does an override apply to?),
some of them auto loaded at RSDT time, and the others
loaded at run-time via Load() in the DSDT (and possibly SSDT) AML.

So we decided that to override an SSDT, you  need to override a DSDT,
incorporate whatever SSDT code you want into your DSDT, and boot with the
"acpi_no_auto_ssdt" cmdline parameter to inhibit autoloading
of the RSDT enumerated SSDTs.  That gives you complete and total
control over what AML gets run.  (you omit that cmdline param
to overide the DSDT but keep the native SSDTs)  It also gives you
just 1 DSDT to keep track of.

I'm not clear on how to use the proposed initrd SSDT override capability,
and why it needs to be different from the simple scheme above,
but I wouldn't want a mess there to hold up the rest of the initrd
DSDT override patch series -- since only very rarely is an SSDT
override needed.

-Len


