From: Jeff Pitman <symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Subject: Re: Source of buzzing determined for hp tc1100
Date: Tue, 7 Dec 2004 07:28:56 +0800
Message-ID: <200412070728.57179.symbiont@berlios.de>
References: <41B4E721.1040601@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41B4E721.1040601-NtISFavHD68j5TC/SZClsA@public.gmane.org>
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

On Tuesday 07 December 2004 07:11, Joshua Wise wrote:
> Has anyone any insight?

I still think it's thermal.ko, but i've got it statically compiled in 
here.

It's been reported before for Dell:
http://seclists.org/lists/linux-kernel/2003/Dec/1037.html

I'm going to recompile as module tonight and play around with the 
throttling. I think most people have too much ambient noise in their 
work areas to hear it.  Otherwise, this has got to be happening all the 
time.

-- 
-jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
