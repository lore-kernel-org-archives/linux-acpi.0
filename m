From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Source of buzzing determined for hp tc1100
Date: Tue, 07 Dec 2004 07:42:13 -0800
Message-ID: <41B5CF55.6090908@root.org>
References: <41B4E721.1040601@joshuawise.com> <41B4EB17.5010702@root.org> <41B4F13B.6060304@joshuawise.com> <200412071143.13460.symbiont@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412071143.13460.symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
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

Jeff Pitman wrote:
> On Tuesday 07 December 2004 07:54, Joshua Wise wrote:
> 
>>I then googled for acpi c3 noise, which gave me some information
>>about Thinkpads and sound card noise, but the noise occurs regardless
>>of soundcard-osity. In fact, it seems to be coming from near the CPU
>>fan.
> 
> 
> This is not coming from the soundcard on my Thinkpad T30.  It's from the 
> thermal unit located around the CPU fan on the upper left of the unit.
> 
> 
>>While the system is connected to the USB keyboard, the it will never
>>go into C3 state, and bus master activity is always ffffffff.
> 
> 
> I have a USB external HD connected and it stays in C2 all the time.
> 
> 
>>However, when I connect AC power, the buzzing goes away, but the
>>system still spends most of its time in C3 state.
> 
> 
> Whether I'm on AC or Battery, it's always in C2.  Usage for C3 is 
> extremely low.  AC or Battery there's still buzzing.  Albeit, mine is 
> very quiet.

Perhaps my previous email wasn't clear enough.  If you search the 
archives for "noise C3", you'll find more about it.  It's capacitor 
noise due to stop GNT.  Changing the kernel timer frequency (kern.hz on 
FreeBSD) will change the rate.  I use 100, which is not audible.  The 
normal rate of 1000 hz is a very audible tone.  So either disable C3 or 
change your HZ rate to something not audible.

-- 
Nate



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
