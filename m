From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Fri, 29 Oct 2004 15:28:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16770.21398.497934.189008@aber.ac.uk>
References: <16768.60745.952949.338093@aber.ac.uk>
	<16769.6764.210990.366655@aber.ac.uk>
	<Pine.LNX.4.60.0410282005580.4042@frog.athome>
	<16769.64228.751344.828301@aber.ac.uk>
	<Pine.LNX.4.60.0410291255100.1318@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0410291255100.1318-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
 > I attached you my config.gz. So you might want to give it a try. I would 
 > be nice, if this brings you forward, to dig down the differences in your 
 > current config and mine and elaborate later on the list.
 > 

Since my last email, my machine froze, which hadn't happened for a very
long time.  I rebooted it, recompiled my kernel with your config file
(slightly modified because apparently my network card is not the same as
yours and because I need devfs (for gentoo).  I had to manually insert the
acpi modules (I have them in the kernel).  I unplugged the laptop from the
mains and about 2 minutes after, it froze...

Rebooted and redid the experiment: booting while plugged in, then unplug
from the mains.  After a few minutes, both temperatures show 46 and ... THE
BATTERY SHOWS 46% CHARGED...

/sbin/halt displays "Power down" but doesn't power down...

That's with the same config as yours (Hartwig) apart from devfs on,
/dev/pts off and 8139too as a module (network card).

Does that help?

Fred



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
