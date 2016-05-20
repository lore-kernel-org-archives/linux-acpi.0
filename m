From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Fri, 20 May 2016 15:17:20 +0800
Message-ID: <20160520071720.GA30152@aaronlu.sh.intel.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
 <7208.1463713500@turing-police.cc.vt.edu>
 <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
 <2897.1463727728@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2897.1463727728@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 20, 2016 at 03:02:08AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 20 May 2016 13:45:30 +0800, Aaron Lu said:
> > On 05/20/2016 11:05 AM, Valdis.Kletnieks@vt.edu wrote:
> > > On Thu, 19 May 2016 18:53:17 -0400, Valdis.Kletnieks@vt.edu said:
> > >
> > >>>> next-20160512 sets the screen brightness to about 40%-ish or so, rather
> > >>>> than the 100% intensity I want.
> >
> > Do you mean after boot, the screen brightness is now 40% instead of the
> > previous 100%? Are you using a GUI?
> 
> Nope, even the very first line of output from initramfs is dim, and if I then
> reboot and go into the BIOS settings, the screen intensity is at 40%. While
> it's rebooting, the Dell bios splash will start off bright and then suddenly
> dim down.
> 
> With the patches reverted:
> 
> [/sys/class/backlight/acpi_video0] grep . *bright*
> actual_brightness:95
> brightness:95
> max_brightness:95
> 
> And the weird part inside the kernel - on a kernel that has the problem,
> /sys/class/backlight is *empty* - only '.' and '..' entries.
> 
> No, I don't understand why the acpi_video0 entry isn't created when that
> commit is in place.

The commit probably makes acpi_video_init_brightness bail out for some
reason, adding debug prints under those "if (result)" in
acpi_video_init_brightness should help to identify where it goes wrong.

And your acpidump please, thanks.
