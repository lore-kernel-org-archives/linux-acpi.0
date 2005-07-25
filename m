From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Mon, 25 Jul 2005 14:07:54 +0200
Message-ID: <200507251407.55454.rjw@sisk.pl>
References: <20050723133726.GA2079@miro.sinus.cz> <20050724142432.GC1778@elf.ucw.cz> <20050725084044.GA22944@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725084044.GA22944-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The problem you describe is not related to the ec_polling patch (see below).

On Monday, 25 of July 2005 10:40, Pavel Troller wrote:
> > Hi!
> > 
> > > 5) After resume from S4:
> > > 
]--snip--[
> > > Disabling IRQ #10
> > > 
> > > ...and then
> > > 
> > > ohci_hcd 0000:00:02.3: Unlink after no-IRQ?  Controller is probably
> > > using the wrong IRQ.
> > 
> > Okay, can you enable debugging in .../usb/core/hcd-pci.c and see what
> > happens? It seems to call request_irq in resume routine, add printk to
> > verify that it really does call it.
> > 
> Hi Pavel,
>   I'm afraid that You're not getting the exact point:
>   1) Before S4 is called (4 written to /proc/acpi/sleep), ohci_hcd module is
> fully unloaded.
>   2) The problem with "nobody cared" is detected during the wake up phase,
> even before the suspend/resume script wakes up and tries to reinsert the
> module. You can see that just the sound card handler is hooked to the irq.
>   3) After a relatively long time (during which the resume script is awaken
> and starts to insert various modules (mouse, modem, irda, bluetooth... which
> were unloaded during suspend to prevent problems), this ohci_hcd tries to
> be inserted, finds the non-functional interrupt and makes problems. Maybe
> there is a bug in it, but it is triggered by another problem with that irq,
> happening just in -rc3.

This happens because the sound card should drop the IRQ during
suspend but it doesn't.  Please try to apply the patch at

http://bugzilla.kernel.org/attachment.cgi?id=5371&action=view

and let me know if that helps.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
