From: Richard Jelinek <rj-SPYDw57wZyZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Multiple problems on Thinkpad A31p
Date: Sun, 5 Dec 2004 16:20:29 +0100
Message-ID: <20041205162029.A994@petamem.com>
References: <20041204124734.A22065@petamem.com> <1102212367.9384.5.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1102212367.9384.5.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Garett,

thanks for your answer.

On Sun, Dec 05, 2004 at 02:06:07AM +0000, Matthew Garrett wrote:
> Not all hardware seems to switch the backlight off sensibly on entering
> ACPI suspend. Your suspend script probably tries to trigger the X DPMS
> call, which will blank the screen - the kernel then switches back to a
> console and turns the backlight on again. Can you try the program
> attached to 
> http://bugzilla.kernel.org/show_bug.cgi?id=2576 ?

downloaded, renamed (comes as attachement.cgi with Firefox 1.0)

standby, suspend & off: switch the display off completely - no backlight
reduced: no effect
on: switches screen on again

Don't know whether there should be more parameters, the syntax
description doesn't end with a ']'

What do the results tell us?

> 2.6.9 has better USB power management.

Hopefully it handles then Unplug (DVD-RAM) & Plug (USB-Craddle for
Palm) of the Ultrabay as good as the 2.4.26 did: without freezing the
machine. ;-)

> I think this has been fixed, but I don't know whether it'll hit 2.6.10.
> Adding hwclock --hctosys in the resume script ought to work around it.

Ok.

-- 
best regards,

     Dipl.-Inf. Richard Jelinek

     - The PetaMem Group - Prague/Nuremberg - www.petamem.com -
		       -= 3394928 Mind Units =-


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
