From: "H. Brunsting" <h_brunsting-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: ACPI, klaptopdaemon patch - battery status in KDE3
Date: Wed, 14 Aug 2002 17:16:34 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815001634.36933.qmail@web14203.mail.yahoo.com>
Reply-To: h_brunsting-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Just some information from a user experience:

I installed acpi on my Sony Vaio Laptop, and my
/proc/acpi system was
working fine - I could read most things using the
'cat' command. However,
the Power Control settings tab in KDE 3 still reported
acpi to be installed,
but missing modules for batteries and ac-adapters. I
patched klaptopdaemon
using Robert Parrott's patch
(http://www.fas.harvard.edu/~parrott/klaptopdaemon-portable.cpp.diff),
but
still it didn't work. I started to examine
portable.cpp from the
klaptopdaemon package and I discovered some
differences between my acpi proc
system and the ones pointed to in the source:

In 2 instances of the source code, the patch adds a
check for the new Intel
acpi system, this is the first one:

if (!f) f = fopen("/proc/acpi/ac_adapter/AC/state",
"r"); /* INTEL ACPI
version. REPADDED */

It refers to proc/acpi/ac_adapter/AC/state, and on my
system this entry
shows up as proc/acpi/ac_adapter/ACAD/state - ACAD
instead of AC. I don't
know if this is being caused by my laptop not
conforming to the standard or
the standard acpi software, either case it's worth
noting, because I am sure
I am not the only one having this problem (which is
now solved by editing
the source of portable.cpp). I'm not really a cpp
coder, but I'm sure
another line checking proc/acpi/ac_adapter/ACAD/state
in the same way as it
is done with AC will solve the problem for most
people.

I hope I have informed you about something useful, if
not, consider this
mail to be junkmail :)

Best regards,

H.Brunsting

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
