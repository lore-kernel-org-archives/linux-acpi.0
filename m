From: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>
Subject: Re[2]: HP nw8000 never wakes up from acpi suspend
Date: Sat, 9 Oct 2004 17:24:59 +0200 (Romance Daylight Time)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1CGJ5Z-0000X8-00@smtp.tt-solutions.com>
References: <3ACA40606221794F80A5670F0AF15F8405BD1223@pdsmsx403>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: INLINE
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405BD1223@pdsmsx403>
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

On Sat, 9 Oct 2004 23:10:11 +0800 "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

YL> S1 is less important than S3 and S4.
YL> So, please verify S4 is ok, then S3. 
YL> S1 is nice-to-have.

 Thank you for your reply! I realize that S1 is less important, I'd mostly
like to have S3 work.

YL> try command " echo -n 4 > /proc/acpi/sleep" for s4
YL> echo -n 3 > /proc/acpi/sleep" for  s3
YL> echo -n 1 > /proc/acpi/sleep"  for s1.

 Hmm, all of these commands do nothing here. I.e. the command succeeds
without any observable effect.

 I should say that nothing happens when I do "echo -n disk (or standby) >
/sys/power/state" but when I do "echo mem > /sys/power/state" I can see
messages on the console saying "PM entering sleep state" (I'm not sure,
they disappear too quickly and syslog is apparently not written to any
more) and the machine does indeed fall asleep -- but doesn't wake up.
 
YL> There is a known S3 VGA resume issue on some laptop. 
YL> Maybe you will hit that bug. Please verify.

 What should I do to verify this? Just in case, the video card is ATI
OpenGL T2.

 Thanks again,
VZ



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
