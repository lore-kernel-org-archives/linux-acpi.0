From: Vadim Zeitlin <vadim-oC9ebduGu/Fg9hUCZPvPmw@public.gmane.org>
Subject: how to find what the given ACPI device corresponds to?
Date: Tue, 12 Oct 2004 02:11:36 +0200 (Romance Daylight Time)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1CHAGG-0006HY-00@smtp.tt-solutions.com>
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

 continuing my attempts to make ACPI suspend work on HP nw8000, I've
noticed the following:

% cat /proc/acpi/wakeup
Device  Sleep state     Status
C057       5            disabled

It looks strange that neither sleep button (C13A, although it doesn't seem
to generate ACPI events anyhow) nor lid switch (C139, does generate events)
nor power button (PWRF, also generates events) appears in this file. Could
someone please tell me:

1. if this is normal?
2. how can I find what the device C057 corresponds to?

I'm starting to think that maybe the system is simply not configured to be
waken up at all, is it plausible?

 Note that I can enable C057 (whatever it is) by doing "echo C057 > wakeup"
but doing "echo PWRF" or C13A or C139 do not work, i.e. they don't appear
in the file no matter what I do.

 Thanks in advance for any enlightment!
VZ



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
