From: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>
Subject: HP nw8000 never wakes up from acpi suspend
Date: Sat, 9 Oct 2004 16:29:45 +0200 (Romance Daylight Time)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1CGIE8-0000S1-00@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: INLINE
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

 Hello,

 I've installed Debian (2.6.8-1 kernel, first without, then with ACPI
patch) on HP nw8000 notebook. Everything worked perfectly out of the box
except for suspend. All ACPI modules load successfully and, in general,
things like monitoring fans and thermal zones work great. Also, cat
/sys/power/state outputs the expected "standby mem disk".

 But standby (S1 state?) doesn't work at all:

[sunrise:/sys/power]# echo standby > state
echo: write error: operation not permitted

and in syslog I see just the following:

PM: Preparing system for suspend
Stopping tasks: =========================================================|
Restarting tasks... done


 Doing "echo mem > state" does work if I unload the USB modules (otherwise
it stops with an error but this is ok): I see the messages about drivers
being stopped and then the machine goes to sleep. The trouble is, it never
wakes up. Pressing keys on the keyboard, opening/closing the lid, pressing
the power button and cursing loudly all have the same effect: none at all.
I can only hard reset the notebook by holding the power button for 5
seconds.


 Needless to say, a notebook which can't be suspended is a bit annoying so
I'd really like to fix this. Unfortunately I don't know where/how to start
debugging this. All I could do was to build a minimal kernel with nothing
except absolutely needed stuff (i.e. IDE) in it but not even graphics card
support included but this didn't help at all.

 Any help would be really appreciated, thanks in advance!
VZ



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
