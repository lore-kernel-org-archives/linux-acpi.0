From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: git pull on Linux/ACPI release tree
Date: Sat, 7 Jan 2006 10:54:36 -0500
Message-ID: <200601071054.37741.len.brown@intel.com>
References: <200512010305.43469.len.brown@intel.com> <200512060317.53925.len.brown@intel.com> <200512230042.17903.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200512230042.17903.len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-3NddpPZAyC0@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

please pull this batch of trivial patches from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

thanks!

-Len

 Documentation/DocBook/kernel-api.tmpl |    1 
 Documentation/kernel-parameters.txt   |    4 +++
 Documentation/pm.txt                  |    2 -
 MAINTAINERS                           |    2 -
 drivers/acpi/Kconfig                  |    2 -
 drivers/acpi/scan.c                   |   27 +++++++++++++---------
 drivers/acpi/tables.c                 |    4 +--
 7 files changed, 26 insertions(+), 16 deletions(-)

through these commits:

Borislav Petkov:
      [ACPI] remove Kconfig "default y" for laptop drivers

Len Brown:
      [ACPI] document processor.nocst parameter
      [ACPI] linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org replaces acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
      [ACPI] reduce kernel size: move 5BK .bss to 2.5KB .init.data
      [ACPI] linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org replaces acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Randy Dunlap:
      [ACPI] fix kernel-doc warnings in acpi/scan.c

with this log:

commit f9a204e1de73a7007de66fb289e1d64a7665c9b4
Author: Borislav Petkov <bbpetkov-LWAfsSFWpa4@public.gmane.org>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] remove Kconfig "default y" for laptop drivers
    
    Signed-off-by: Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit d758a8fa8ce0566947677f7e70bf70c57ad9445c
Author: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] fix kernel-doc warnings in acpi/scan.c
    
    Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 036d25f79ddfbc9878da24ef8e468a6d22caa605
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jan 6 16:19:26 2006 -0500

    [ACPI] linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org replaces acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 04348e69e7e78ad69a09b2e1157f628d6c764370
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Dec 30 02:44:59 2005 -0500

    [ACPI] reduce kernel size: move 5BK .bss to 2.5KB .init.data
    
    put __initdata on sdt_entry[], as it is accessed only by __init functions.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=1311
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 6968e50c2b53805219618203db3d98566dfa1fdd
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Dec 30 00:32:49 2005 -0500

    [ACPI] linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org replaces acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 41c0d8680f7f24e1abaaeeabc6723277b2e34b81
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Dec 28 12:43:51 2005 -0500

    [ACPI] document processor.nocst parameter
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
