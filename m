From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: 03 Aug 2002 14:32:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028381521.31718.26.camel@irongate.swansea.linux.org.uk>
References: <OF4415334C.6C7486B8-ON86256C0A.00081BB4@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF4415334C.6C7486B8-ON86256C0A.00081BB4-yJlKWOkj9xhBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Bishop Brock <bcbrock-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2002-08-03 at 03:29, Bishop Brock wrote:
> On the first point, we're concerned with system-wide power management,
> which includes the
> memory subsystem.  Our processors are so power-efficient today that we burn
> more power

IBM's may be, but this isnt an IBM PPC specific operating system
project. If the servers are for example AMD dual Athlons or 1U Pentium
IV rack boxes then it -really- begins to matter. To put the scale of
this into perspective on x86 - I can run another entire system in the
power differential between idle and full running dual athlon.

In some respects the Athlon is closer to what you claim since there is a
chunk of power saving that occurs only when both cpus are stopped.

I'm not arguing against your claim. I want to be sure we can support
both.behaviours.

> power management policy lead to slack, i.e., idle time.  Our proposal
> allows the system to
> capture the slack by aggressively idling the processor for short periods,
> e.g., between video
> frames, without any effect on the application, and with significant energy
> reduction.

Some processes show short interactive behaviours. You can quantify and
measure that, indeed the scheduler already has an extremely good idea
what is and is not an interactive process that will execute short bursts
then sleep a lot. Whether that is enough I don't know.

Alan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
