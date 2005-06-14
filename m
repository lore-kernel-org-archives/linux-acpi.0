From: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Subject: Display black after s3 resume, vbetool not working (was: Re: S3 test tool)
Date: Tue, 14 Jun 2005 21:38:04 +0200
Message-ID: <200506142138.04603.chefturner@web.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <200506130101.20005.chefturner@web.de> <1118618000.6648.459.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118618000.6648.459.camel@tyrosine>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again,

On Monday 13 June 2005 01:13, Matthew Garrett wrote:
> On Mon, 2005-06-13 at 01:01 +0200, Christoph Tavan wrote:
> > My Samsung X30 Laptop "suspends" and "resumes" fine with the patch, so
> > kernel-code seems to be OK.
>
> Try vbetool.

Thanks for the tip, I've tried that, unfortunately without success. 

I'm going to describe, what happens, when I suspend and resume and I would be 
glad about every help. My laptop is a Samsung X30 with nvidia geforce fx go 
5200 vga-adapter.

- Booted normally to console (no framebuffer, no X), only module loaded is 
evdev.

- saved vbestate:
  # vbetool vbestate save > path/to/vbefile

- # sync

- suspend to ram:
  # echo -n mem > /sys/power/state

=== Now the Laptop properly suspends! ===

- wake up the laptop by pressing the appropriate button, now display stays 
black but I can type commands blindly

- # sync

- try to post video-bios
  # vbetool post

=== Now the screen turns white with strange couloured lines. The white screen 
slowly gets darker and darker... I took a photo:
http://bugme.osdl.org/attachment.cgi?id=4029&action=view

- # vbetool vbestate restore < path/to/vbefile
  has no visible effect :(

Switching terminals and starting X works (according to the logfiles), but has 
no effect on the display!

Here the last lines of the kernel-log:

Jun 14 20:38:56 spock Stopping tasks: ============================|
Jun 14 20:38:56 spock hwsleep-0296 [06] acpi_enter_sleep_state: Entering sleep 
state [S3]
Jun 14 20:38:56 spock Back to C!
Jun 14 20:38:56 spock ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> 
GSI 10 (level, low) -> IRQ 10
Jun 14 20:38:56 spock ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKD] -> 
GSI 10 (level, low) -> IRQ 10
Jun 14 20:38:56 spock Restarting tasks... done
Jun 14 20:38:56 spock Disabling BM access before entering C3


Any suggestions how one could find out what's going wrong there?

Thanks in advance, Christoph Tavan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
