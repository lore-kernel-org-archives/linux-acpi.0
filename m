From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: C2/C3 don't do anything
Date: Wed, 2 Feb 2005 19:46:40 -0800
Message-ID: <20050203034639.GA29164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi all,

I've been playing with Dynamic Tick, where the system timer is
stopped for the idle ticks. This allows the system to stay in sleep
mode inbetween the skipped ticks. [1] The most recent patch for
dynamic-tick is [2]

This works fine on ARM OMAP, but on my i386 boxes I've noticed that
only hlt works, C2 and C3 just spin in a busy loop and consume more
power than C1 with hlt!

I've done an idle module few years ago that enables C2 for dual
Athlon boxes [3], and that involved enabling it in the southbridge.

I thought the current ACPI code enables this already? But it does
not seem to be the case?

Should we have some extra code to scan the southbridges, or what is
the official way of handling that? It would be nice to get it
enabled...

At least my Crusoe based laptop with ALi 1533 chipset and Ali M7101
PMU does not get enabled. (Does anybody have docs to enable it on
1533/1535/7101???)

Cheers,

Tony

[1] http://lkml.org/lkml/2005/1/27/270
[2] http://lkml.org/lkml/2005/1/27/270
[3] http://muru.com/linux/amd-smp-idle/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
