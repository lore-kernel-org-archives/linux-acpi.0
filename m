From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Re: [giri@lmc.cs.sunysb.edu: Resume from suspend-to-ram]
Date: Sat, 21 Feb 2004 18:40:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040221174049.GA4526@dreamland.darkstar.lan>
References: <20040220235512.GA27779@dreamland.darkstar.lan> <1077321457.9623.27.camel@gaston> <20040221041647.2F8307831D@mail.lmc.cs.sunysb.edu> <1077336792.17072.30.camel@gaston>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1077336792.17072.30.camel-ZSGxbZoyBwc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Il Sat, Feb 21, 2004 at 03:13:12PM +1100, Benjamin Herrenschmidt ha scritto: 
> On Sat, 2004-02-21 at 15:16, Giridhar Pemmasani wrote:
> > Actually there was another patch that I missed. 
> > 
> > I also had to patch radeon driver in XFree86 to softboot/POST. This
> > patch is from
> > http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html (actually
> > there is no patch there, but I didn't want to post his email address
> > here, but if you need to contact him, go to the top of this link). 
> 
> Ahhhh ... that explains it.. yes, we need to re-POST the card.
> 
> I'm afraid in the kernel, that will be a problem, unless we can
> do that from real mode some way... my knowledge of x86 isn't good
> enough. One thing is sure, we can't rely on the PCI ROM of the
> card having a valid useable BIOS image, it's usually hidden
> somewhere with the main BIOS, so either we use the RAM image
> at c0000 or we ask the main BIOS to re-post the card.

Giridhar  look into  your BIOS  for something  like "Run  VGABIOS if  S3
Resume" (I have  it under "Power Management") and set  it to "Yes". With
this option  the firmware  will re-init the  card BIOS  before returning
control to  Linux. If you  don't see  it then it's  a big  problem... we
can't go in real mode once Linux  is running. It may be possible to hack
up something in wakeup.S, before restoring processor state.

Without this option I have a hard lockup (no ping, no sysrq, nothing) on
resume. With it framebuffer is restored fine.

>From syslog:
PM: Preparing system for suspend
Stopping tasks: =============|
[...]
radeonfb: suspending to state: 2...
PM: Entering state.
 hwsleep-0265 [17] acpi_enter_sleep_state: Entering sleep state [S3]
PM: Finishing up.
hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7    hsync_strt_wid = 0x910422
v_total_disp = 0x2ff0325           vsync_strt_wid = 0x860302
pixclock = 15384
freq = 6500
post div = 0x2
fb_div = 0x74
ppll_div_3 = 0x20074
lvds_gen_cntl: 08000008
radeonfb: resumed !

Very nice :)

Luca
-- 
Home: http://kronoz.cjb.net
Windows NT crashed.
I'm the Blue Screen of Death.
No one hears your screams.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
