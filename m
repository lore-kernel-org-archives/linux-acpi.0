From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Multiple problems on Thinkpad A31p
Date: Sun, 05 Dec 2004 02:06:07 +0000
Message-ID: <1102212367.9384.5.camel@tyrosine>
References: <20041204124734.A22065@petamem.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041204124734.A22065-SPYDw57wZyZBDgjK7y7TUQ@public.gmane.org>
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

On Sat, 2004-12-04 at 12:47 +0100, Richard Jelinek wrote:

> * Closing the lid, the machine goes down and the "moon"-led goes on
>   indicating the suspend state. All is quiet, however, the machine
>   generates significant heat. Examining the situation, all fans, the
>   HD etc. are switched off, even the display, but some second after
>   the display has been switched off completely, THE BACKLIGHT GOES ON
>   AGAIN! Uhhh... So after 2hours in this "suspend" mode, the battery
>   is just 70% charged. (Took 8hours with APM)

Not all hardware seems to switch the backlight off sensibly on entering
ACPI suspend. Your suspend script probably tries to trigger the X DPMS
call, which will blank the screen - the kernel then switches back to a
console and turns the backlight on again. Can you try the program
attached to 
http://bugzilla.kernel.org/show_bug.cgi?id=2576 ?

>   Even worse, the external (USB Radio) mouse doesn't work
>   anymore. Neither did the ethernet (e100), but somehow I managed to
>   configure it (mungled the PCI latencies of the ethernet controller),
>   so that ethernet is not lost after S3 resume. And there's no way to
>   bring the mouse back to life again but reboot. The internal PS/2
>   mouse (trackpoint) works fine.

2.6.9 has better USB power management.

> * S5 works as described, unfortunately after resume, the clock shows
>   exactly the time, when the shutdown did happen.

I think this has been fixed, but I don't know whether it'll hit 2.6.10.
Adding hwclock --hctosys in the resume script ought to work around it.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
