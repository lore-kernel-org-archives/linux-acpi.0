From: Christoph Lukas <christoph.lukas-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 08:02:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080712934.8580.31.camel@beja>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7-Lp/cVzEoVyYIbgCsDWxlK60bRtRcJeJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Die, den 30.03.2004 schrieb Rockefeller, Harry um 19:33:
> As a user, I'm stuck at first base.  With kernel 2.6.4
> S3 is supposedly supported.  Entering S3 appears to work.
> Exiting S3 (waking up?) the LCD screen comes back when a key is
> depressed, but *nothing* brings my machine back to life.
> The full few-seconds power-button reboot is all that works.
> 
> I admit that there may be a simple one-line web-link answer
> pointing to some ACPI FAQ or How-to.  If that is the case 
> just point me there and I'll read that.

I spent several hours trying to set up S3 on my notebook. The problem
with S3 seems to be that the drivers have to take care for saving /
restoring PCI states and reinitializing hardware components.

The mayor problem for me was that the video card (Nvidia GForce) had to
be reinitialized. I solved that with using the original XFree nv driver
instead of the nvidia one and applying an XFree hack from:

http://www.loria.fr/~thome/d600/

This made S3 working for me from within X. On the same page you can find
a patch for the ATI Radeon M9.

The second problem was that some drivers had to be unloaded before
suspend and reloaded after resume (usb).

The third problem was that I did not get alsa to work after resume. A
similar problem is described here:

http://sourceforge.net/mailarchive/message.php?msg_id=7591163

Using those hints I wrote a small _shell_ script to save the PCI config
space of my alsa and network driver before suspend and to restore it
after resume.

That finally made S3 working for me. :-)

As a recipe I would suggest:
- Start with mostly all drivers unloaded
- Always umount all unnecessary partitions as it is likely that your
system will crash until you find the correct way to deal with your
drivers
- Boot your system with acpi_irq_balance acpi_irq_pci=3,4,5,..
- Get your video card working with S3
- Try one driver after another to deal with S3
- If it does not survive suspend / resume try:
-- unloading / reloading
-- keeping the driver loaded and saving / restoring PCI config space

As the alsa drivers were the worst ones to get working, I tried to
contact the alsa-devel list for some help, but there did not seem to be
any interest in getting S3 working with alsa. No responses so far. :-(

Regards,
Christoph



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
