From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: Source of buzzing determined for hp tc1100
Date: Mon, 06 Dec 2004 19:00:50 -0500
Message-ID: <41B4F2B2.8080206@joshuawise.com>
References: <41B4E721.1040601@joshuawise.com> <200412070728.57179.symbiont@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412070728.57179.symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeff Pitman <symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I still think it's thermal.ko, but i've got it statically compiled in 
> here.
Well, recall that thermal.ko depends on processor.ko. rmmod'ing one 
implies rmmod'ing the other.

> I'm going to recompile as module tonight and play around with the 
> throttling. I think most people have too much ambient noise in their 
> work areas to hear it.  Otherwise, this has got to be happening all the 
> time.
The buzzing is actually fairly loud on this device - I can hear it in a 
moderately noisy bus. It's definately audible over the fan (which seems 
to be constantly running when the display is on on this thing...).

I'd get a recording of it, but of course the noise goes away when I try 
to record using the internal sound card. I assume that is for the same 
reason as the USB causing the buzz to cease. Perhaps later, I will fire 
up my big desktop and record from there.

joshua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
