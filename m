From: Markus Demleitner <msdemlei-APKjHxrCF0f0LxEIJ2PtDHqWYbMAw+HU@public.gmane.org>
Subject: JVC XP-731, display doesn't sleep
Date: Fri, 8 Jul 2005 11:39:58 +0200
Message-ID: <20050708093958.GA822@tucana.cl.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

Like some people before me, I'm having rather unpleasant encounters
with ACPI on a JVC XP-731.  For other people just wanting the box to
suspend, let me say that suspending with apm works flawlessly (as far
as I can tell now).  But of course, having ACPI would be nice anyway.

With kernel 2.6.8 provided by Debian sarge, acpi suspend works once
one removes the usb drivers (ehci_hci, usb_uhci) that otherwise veto
the suspend, except for a video problem (yes, I've read
power/video.txt): The LCD isn't powered off, and lacking an input
signal it just displays blue streaks flickering all over the place.

Waking up gets the video back up, but the machine is unresponsive
(which is probably unrelated and could be fixed rather easily).

I'm not actually surprised this problem occurs, since the LCD appears
to be attached rather oddly -- the X servers (both x.org and Xfree86)
can't determine its size to begin with --, so I guess ACPI simply
doesn't know about the device.

Are there any trick I could play so ACPI does see the LCD after all?
Could it be that Linux' ACPI subsystem has trouble parsing the
respective entries in the device's ACPI tables?  If that were the
case, what useful data could I provide to facilitate an analysis?

Thanks,

         Markus


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
