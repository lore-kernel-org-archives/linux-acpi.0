From: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>
Subject: Re[4]: HP nw8000 never wakes up from acpi suspend
Date: Sat, 9 Oct 2004 18:02:04 +0200 (Romance Daylight Time)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1CGJfS-0000dE-00@smtp.tt-solutions.com>
References: <3ACA40606221794F80A5670F0AF15F8405BD1225@pdsmsx403>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: INLINE
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405BD1225@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 9 Oct 2004 23:38:02 +0800 "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

YL> > I should say that nothing happens when I do "echo -n disk (or 
YL> >standby) >
YL> >/sys/power/state" but when I do "echo mem > /sys/power/state" I can see
YL> >messages on the console saying "PM entering sleep state" (I'm not sure,
YL> >they disappear too quickly and syslog is apparently not written to any
YL> >more) and the machine does indeed fall asleep -- but doesn't wake up.
YL> 
YL> It sounds like VGA issue.

 Is there any workaround?

YL> >YL> There is a known S3 VGA resume issue on some laptop. 
YL> >YL> Maybe you will hit that bug. Please verify.
YL> >
YL> > What should I do to verify this? Just in case, the video card is ATI
YL> >OpenGL T2.
YL> 
YL> Please try "echo mem > /sys/power/state" from X window.

 Same thing: it goes to sleep and doesn't wake up.

 I've recompiled the kernel with ACPI debugging turned on and did (please
tell me if it was wrong as I don't really understand it, just found on
in this list archives):

	echo 0x10 > /proc/acpi/debug_level 
	echo 0x1f > /proc/acpi/debug_layer

However this didn't give any useful messages (or I couldn't see it).

 What else can I do?

 Thanks again!
VZ



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
