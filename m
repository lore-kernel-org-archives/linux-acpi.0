From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [GIT PATCH] ACPI patches for 2.6.13-rc5
Date: Wed, 03 Aug 2005 19:16:25 -0400
Message-ID: <1123110985.13136.12.camel@toshiba>
References: <1122702560.26850.9.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1122702560.26850.9.camel@toshiba>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus.git

I reverted several things to 2.6.12 behaviour
which should result in a higher quality 2.6.13 release:

1. Fixed the PCI Interrupt Link revert you pulled from the list.
2. Put Embedded Controller back into polling mode by default.
3. Set CONFIG_ACPI_HOTKEY to 'n' by default (updated driver too).
4. Lovingly restored the rudely deleted /proc/acpi/button/:-)

thanks,
-Len

p.s.
Latest ACPI plain patch, including stuff waiting for 2.6.14 is available
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/broken-out/


 drivers/acpi/Kconfig          |    5 
 drivers/acpi/button.c         |  206 ++++++++
 drivers/acpi/ec.c             |   24 -
 drivers/acpi/hotkey.c         |  690 +++++++++++++++++-------------
 drivers/acpi/pci_link.c       |   11 
 drivers/acpi/processor_idle.c |    7 
 6 files changed, 634 insertions(+), 309 deletions(-)


commit 79cda7d0e1c8629996242c036d6fe0466038d8ba
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 18:07:59 2005 -0400

    [ACPI] CONFIG_ACPI_HOTKEY is now "n" by default
    For 2.6.12 behaviour, this (EXPERIMENTAL) driver
    should not be built.
    
    Update the driver source with latest from Luming.
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit b34a8030eeab4d59dcdd86de38f6927b9edd441f
Author: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 17:55:21 2005 -0400

    [ACPI] restore /proc/acpi/button/ (ala 2.6.12)
    
    Signed-off-by Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 7b15f5e7bb180ac7bfb8926dbbd8835fecc07fad
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 17:38:04 2005 -0400

    [ACPI] revert Embedded Controller to polling-mode by default (ala
2.6.12)
    Burst mode isn't ready for prime time,
    but can be enabled for test via "ec_burst=1"
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit ecc21ebe603af31f172c43b8b261df79040790ef
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 11:00:11 2005 -0400

    [ACPI] PCI interrupt link suspend/resume - revert to 2.6.12
behaviour
    
    This patch disables the PCI Interrupt Link refernece counts,
    which should not co-exist with the 2.6.12 irq_router.resume
    method or else a double acpi_pci_link_set() could result
    on resume.
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 3d35600a9de8e2816d0e3726f64b7271af6fdda4
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 00:22:52 2005 -0400

    [ACPI] fix 64-bit build warning in processor_idle.c
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
