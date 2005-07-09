From: Markus Demleitner <msdemlei-APKjHxrCF0f0LxEIJ2PtDHqWYbMAw+HU@public.gmane.org>
Subject: Re: JVC XP-731, display doesn't sleep
Date: Sat, 9 Jul 2005 10:14:04 +0200
Message-ID: <20050709081404.GA3606@tucana.cl.uni-heidelberg.de>
References: <20050709030113.5F3BF13980@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050709030113.5F3BF13980-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org>
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

[Sorry to reply to myself, excuse below]

On Fri, Jul 08, 2005 at 08:00:25PM -0700, msdemlei-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org wrote:
> Like some people before me, I'm having rather unpleasant encounters
> with ACPI on a JVC XP-731.  For other people just wanting the box to
> suspend, let me say that suspending with apm works flawlessly (as far
> as I can tell now).  But of course, having ACPI would be nice anyway.
Unfortunately, that doesn't really help, since the device in part
relies on ACPI to sort out PCI IRQs.

So, my interest in getting ACPI suspend to work has suddenly surged :-)

> With kernel 2.6.8 provided by Debian sarge, acpi suspend works once
> one removes the usb drivers (ehci_hci, usb_uhci) that otherwise veto
> the suspend, except for a video problem (yes, I've read
> power/video.txt): The LCD isn't powered off, and lacking an input
> signal it just displays blue streaks flickering all over the place.
With a self-built 2.6.11.12 kernel, suspend works without a hitch,
and the display is sent to sleep...

> Waking up gets the video back up, but the machine is unresponsive
> (which is probably unrelated and could be fixed rather easily).
...but now it won't wake up.

I've loaded the video extension, and it sees the LCD.  The following
is present in 
/proc/acpi/video/VGA/LCDD

LCDD > cat brightness 
<not supported>
[Well, that's not a problem, the keys work, it's clearly not a
software thing]

LCDD > cat EDID
<not supported>
[Hm...]

LCDD > cat info 
device_id:    0x0400
type:         LCD
known by bios: no

LCDD > cat state
state:     0x1f
query:     0x01

Now, here's the beef: the contents of state is the same before a
suspend (to memory) as it is after -- in both cases state is 1f, only
that before a suspend the display is working, and after it's not.  I
don't understand this, because from what I see in actypes.h, that
state isn't even defined.  Do I really have to plough through the
ACPI specs to understand this (please not!)?

In case it's important, I used
echo mem > /sys/power/state
to send the machine to sleep.

Any help, hints, debugging aid greatly appreciated -- without
sleeping capability, the thing is only half as useful.

Thanks,

           Markus


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
