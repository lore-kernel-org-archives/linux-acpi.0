From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Date: Wed, 11 Jan 2006 19:40:28 +0100
Message-ID: <20060111184027.GB4735@inferi.kami.home>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <15632.83.103.117.254.1136989660.squirrel@picard.linux.it> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15632.83.103.117.254.1136989660.squirrel-UBpYxYsHrkCaHsy+v9mlyw@public.gmane.org> <20060111100016.GC2574-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> <20060110170037.4a614245.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I gave -mm3 a run:

On Tue, Jan 10, 2006 at 05:00:37PM -0800, Andrew Morton wrote:
> Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org> wrote:
[...]
> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> >    reproducible (have some activity on the fs and suspend)
> 
> No significant reiser3 changes in there, so I'd be suspecting something
> else has gone haywire.

It's still there. But I caught it during normal runtime, a couple more
pictures (yes, I'm going to try to setup a netconsole):

the oops (sorry, it sucks, probably useless):
http://oioio.altervista.org/linux/dsc03136.jpg

a screen with the call traces, the keyboard was still active and sysrq
combos worked. It showed many processes stuck within reiser's log writer:
http://oioio.altervista.org/linux/dsc03138.jpg

going to revert the 

> > 3- This laptop experienced 2 long stalls (20~25 sec) during boot,
> >    apparently after scanning usb_storage devices and starting portmap.

umph... it's still here call traces:
http://oioio.altervista.org/linux/portmap_stall_trace1

[...]
> There's not much point in fiddling with -mm2.  If git7 is OK then please
> test the next -mm and if it still fails then yes, doing a bisection would
> really help.
> 
> <types madly>
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

give me some hours for this.
Anyway I'd like to try to revert some reiser3 changes first and see if
the oops goes (I can leave with a longer boot but I'm worried about my
root fs :))

> > 4- I'm also affected by the ACPI Misaligned resource pointer error.

still here:
# grep -e 'Jan 11.*Misaligned.*' /var/log/syslog
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b7e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b7e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b2e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657902 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657602 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657402 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657402 Type 07 Len 0
Jan 11 18:18:53 inferi kernel: **** SET: Misaligned resource pointer: cf657d02 Type 07 Len 0
Jan 11 18:21:14 inferi kernel: **** SET: Misaligned resource pointer: cf657d02 Type 07 Len 0

DSDT and lspci can be found here if useful:
http://oioio.altervista.org/linux/DSDT.aml
http://oioio.altervista.org/linux/DSDT.dsl
http://oioio.altervista.org/linux/lspci-v

On Wed, Jan 11, 2006 at 11:00:16AM +0100, Pavel Machek wrote:
[...]
> > > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> > >    reproducible (have some activity on the fs and suspend)
[...]
> Suspend to *RAM*? That really does not do anything that should kill

Sorry, it seems it has nothing to do with s2ram.

-- 
mattia
:wq!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
