From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: How to replace missing /proc/acpi/button/lid/LID/state ?
Date: Mon, 25 Jul 2005 22:17:59 +0200
Message-ID: <20050725201759.GA4304@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
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

Hi!
 As I wrote in one of my mails, I was using /proc/acpi/button/lid/LID/state
in my STR script. My lid button generates 2 events: one per closing the lid
and the other for opening it. However, not always :-), it sometimes generates
2 events per one action and sometimes vice versa, it forgets to generate one
of these events, so I cannot just drop every second event.
 In the event message, there is nothing indicating the actual status of the
button, just a stupidly counting counter (at the contrary with for example
AC adaptor, where, instead of the counter, I can see 0/1 telling whether the
adapter is off or on).
 I tried to change the script to suspend on odd numbers and ignore even ones,
but it lose its sync with reality very soon and now when I close my lid,
nothing happens, and when I open it again, the machine goes to sleep. Very
frustrating.
 I hoped that missing /proc/button/* is just another bug in -rc3, but 
inspecting the patch, I've found the procfs code tossed out. I know that
there is a "generic hotkey" interface now, but its description is too 
cryptic for me to configure it just to be able to get the status of my
lovely lid button from a shell script (if it's possible at all)... So I'm
asking some "button guru" for help...
                                  With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
