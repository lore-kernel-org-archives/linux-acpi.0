From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI suspend: test 64-bit waking vector (was Re: [PATCH] ACPI suspend: Always use the 32-bit waking vector)
Date: Wed, 17 Sep 2008 18:58:23 +0200
Message-ID: <200809171858.25264.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809170745.19645.rjw@sisk.pl> <20080917072858.GA2659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37983 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbYIQQx2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 12:53:28 -0400
In-Reply-To: <20080917072858.GA2659@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Suspend-devel list <suspend-devel@lists.sourceforge.net>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Wednesday, 17 of September 2008, Pavel Machek wrote:
> On Wed 2008-09-17 07:45:18, Rafael J. Wysocki wrote:
> > On Monday, 15 of September 2008, Pavel Machek wrote:
> > > Hi!
> > > 
> > > ACPI specificiation tells us that x_firmware_waking_vector is
> > > preffered, and maybe it works better than firmware_waking_vector on
> > > some machines.
> > > 
> > > Unfortunately, it does not seem to work on thinkpad x60... but I am
> > > not sure if I'm not doing something wrong.
> > > 
> > > Testing/ideas would be welcome.
> > 
> > Well, the spec says that if x_firmware_waking_vector is non-zero, the BIOS is
> > supposed to call your wake-up code in Protected Mode ...
> 
> That's why I'm passing physical address of 32-bit code...

Well, that should work in theory.  The BIOS is supposed to set up 4 GB of flat
memory starting from zero before jumping to the wake-up code (at least as far
as I understand the spec).

However, is your FACS version equal to 1?

Rafael
