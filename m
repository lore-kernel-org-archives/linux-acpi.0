From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Tue, 13 Feb 2018 09:32:58 +0200
Message-ID: <20180213073258.GX27191@lahna.fi.intel.com>
References: <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws>
 <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com>
 <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
 <20180211134510.GB1521@wunner.de>
 <CAJZ5v0jXwNx7-O_icxAqHwEvki0mZDK_VijDU-hcVM7CtG46Tg@mail.gmail.com>
 <9ae8628a5a9649afaadfa4dda5d896af@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0hUz-+0+_Buobx1Y9d8YVzObsJ4r=Zm61wdm-F7ffhBKg@mail.gmail.com>
 <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35625 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933489AbeBMHdE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Feb 2018 02:33:04 -0500
Content-Disposition: inline
In-Reply-To: <81dad01f354e4dcab852d145ce5d9fb3@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: rafael@kernel.org, lukas@wunner.de, alex.hung@canonical.com, andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com, jdelvare@suse.de, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, f.fainelli@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

On Mon, Feb 12, 2018 at 11:14:42PM +0000, Mario.Limonciello@dell.com wrote:
> > So something like "Do you support native PCI power management?" would
> > be fine, because native PCI power management is defined by the PCI
> > standard and it should be clear what supporting it means and it
> > doesn't depend on what platform the kernel runs on.
> > 
> 
> The problem is this is in conflict with the documentation.
> As quoted:
> 
> ```
> _OSI("Linux-OEM-my_interface_name")
> where 'OEM' is needed if this is an OEM-specific hook,
> and 'my_interface_name' describes the hook, which could be a
> quirk, a bug, or a bug-fix.
> ```
> 
> Quite literally from an OEM perspective this is a quirk.  The affected
> platforms as configured by default won't work properly with Linux.
> 
> We apply a code deviation if the OSPM responds yes to that OSI string.
> 
> It's entirely possible that the Linux kernel could not store a quirk table
> to match the affected platforms and instead give a blanket simple fast 
> "Yes" answer to "Linux-Dell-Video", but I think that is no better than
> _OSI("Linux").  This is at least an attestation from the OEM perspective
> that we have only changed one thing by this string.
> 
> The alternative (and what has been done in the past) was the ACPI
> _OSI rev hack marking those platforms for quirks and other things
> before that and.  I really don't want to go down that road again.

I have not followed this thread too closely so I might be missing
something but why do we need to do this in the first place? Does this
work in Windows and if yes, why we can't do the the same in Linux
without any sort of hacks and/or quirks?
