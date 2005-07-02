From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bug 4833] New: ACPI: C2 no longer detected for CPU
Date: Sat, 2 Jul 2005 10:13:16 -0700
Message-ID: <20050702101316.4f5f0868.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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



Begin forwarded message:

Date: Sat, 2 Jul 2005 07:26:58 -0700
From: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org
Subject: [Bug 4833] New: ACPI: C2 no longer detected for CPU


http://bugzilla.kernel.org/show_bug.cgi?id=4833

           Summary: ACPI: C2 no longer detected for CPU
    Kernel Version: 2.6.13-rc1-mm1
            Status: NEW
          Severity: normal
             Owner: akpm-3NddpPZAyC0@public.gmane.org
         Submitter: makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org


Distribution: Debian Sid
Hardware Environment: Athlon XP-M 2600+, EPoX 8K9A3+ (VIA KT400)
Problem Description:

With 2.6.13-rc1-mm1, ACPI does no longer detect C2 power state for CPU, only C1,
leaving CPU running full throttle all the time. 2.6.12-mm2 still uses C2.

Steps to reproduce: happens always on my machine. config attached.

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
