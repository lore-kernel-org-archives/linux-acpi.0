From: Jeff Pitman <symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Subject: Re: Source of buzzing determined for hp tc1100
Date: Tue, 7 Dec 2004 11:43:13 +0800
Message-ID: <200412071143.13460.symbiont@berlios.de>
References: <41B4E721.1040601@joshuawise.com> <41B4EB17.5010702@root.org> <41B4F13B.6060304@joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41B4F13B.6060304-NtISFavHD68j5TC/SZClsA@public.gmane.org>
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

On Tuesday 07 December 2004 07:54, Joshua Wise wrote:
> I then googled for acpi c3 noise, which gave me some information
> about Thinkpads and sound card noise, but the noise occurs regardless
> of soundcard-osity. In fact, it seems to be coming from near the CPU
> fan.

This is not coming from the soundcard on my Thinkpad T30.  It's from the 
thermal unit located around the CPU fan on the upper left of the unit.

> While the system is connected to the USB keyboard, the it will never
> go into C3 state, and bus master activity is always ffffffff.

I have a USB external HD connected and it stays in C2 all the time.

> However, when I connect AC power, the buzzing goes away, but the
> system still spends most of its time in C3 state.

Whether I'm on AC or Battery, it's always in C2.  Usage for C3 is 
extremely low.  AC or Battery there's still buzzing.  Albeit, mine is 
very quiet.

take care,
-- 
-jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
