From: Johan Braennlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Savage backlight control
Date: Wed, 13 Apr 2005 23:07:42 -0700 (PDT)
Message-ID: <20050414060742.71711.qmail@web50205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: 6667
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


--- Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:
> On Wed, 2005-04-13 at 15:13 -0700, Johan Braennlund wrote:
> > Hi. With recent kernel releases, I see that there's now a file
> > /proc/acpi/video/VGA0/LCD0/brightness. Unfortunately that file says
> > "<not supported>" - what's missing for this feature to be
> > supported?

> It requires your machine's BIOS to provide standard brightness
> control methods.

I see. I do have two working ways of controlling the backlight:

1. Through the graphics card driver, at least to the extent of turning
it on/off.

2. Smoothly changing the brightness using an Fn key combination.

Would it be possible to connect either of those methods to the /proc
interface? My interest in all this comes from a desire to be able to
script brightness control, depending on whether I'm on AC or batteries.

Regards,

Johan




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
