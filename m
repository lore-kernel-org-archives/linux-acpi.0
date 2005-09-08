From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 04:11:06 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>There are a few bugs which I'd identified as arising from the acpi tree
>while it was in -mm.  Is this patch likely to drag them into mainline?
>
>They include:
>
>
>http://bugzilla.kernel.org/show_bug.cgi?id=3D4977
>            Summary: ACPI 20050708 fails on HP RX2600 platform

This was filed against ACPICA 20050708
which had a known problem with module-level code.
The ACPI patch now contains ACPICA 20050902 which
fixes that issue, and this system needs to be
re-tested with the latest patch.

>http://bugzilla.kernel.org/show_bug.cgi?id=3D4867
>            Summary: bug in ACPI crashes machine when reading
>                     /proc/acpi/thermal_zone/THRM/temperature

UNREPRODUCIBLE.
test system died and is no longer available.

>http://bugzilla.kernel.org/show_bug.cgi?id=3D4980
>            Summary: krash on entering mem sleep

The submitter confirmed that suspend to memory now works on this box.

The remaining issue on this box is related to the EC and battery,
and we're getting contradictory feedback on it.
Frankly, I think we need broader testing, and
pushing the latest ec code into 2.6.14 now is the best
way to get that.  If it turns out to be a mistake
we can always turn back time and revert
drivers/acpi/ec.c to the one that shipped in 2.6.12 --
but the one in the latest patch has proven to be
superior to 2.6.13 on other systems.

>Plus we have all the battery monitor woes, but they're in=20
>2.6.13 already.

Re: 2.6.13 regressions vs 2.6.12, I'm aware of these:

  http://bugzilla.kernel.org/show_bug.cgi?id=3D5165
  smp c-states on Pentium 4 with hyperthreading causes big slow-down

  http://bugzilla.kernel.org/show_bug.cgi?id=3D5171
  2.6.13 SMP kernel crash on boot at pm_idle_save()

I saw lots of transient battery issues from 2.6.13-rc3
until 2.6.13-rc6, but the ones I followed went away
as of 2.6.13 final.  Do you have your eye on others
besides 4980?

thanks,
-Len


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
