From: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: strange buzzing sound after the 2.6.10 patch
Date: Wed, 23 Feb 2005 21:31:42 -0500
Message-ID: <f11de95f050223183134a74bda@mail.gmail.com>
Reply-To: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello,

I vaguely remember someone else mentioning this problem on the list
before, but I don't recall if there were any answers to the solution.

I'm running a vanilla 2.6.10 kernel patched with the acpi-2005-01-25 patch.  

When running the patched kernel, I noticed that my laptop makes a very
strange and faint buzzing sound.  I've determined that the buzzing
sound is somewhat related to CPU and HD load.  When the CPU load is
heavy, or when the HD is busy, the buzzing stops.  But when the system
idles, the buzzing continues.  I've also tried forcing the HD to go
into suspension using hdparm, but the buzzing continues.

Any hints or clues?
If this problem hasn't been encountered before, I'd appreciate it if
someone could give hints for how I can best go about isolating the
problem.

-Jing


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
