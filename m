From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI patch status (2.4)
Date: 30 Sep 2003 02:18:12 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064902691.2534.157.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

FYI,
The following changes are currently in the ACPI test trees 
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
available for testing before push to 2.4.23

The associated plain patches are also available here:
ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/

If you see any regressions, please let me know.

thanks,
-Len

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI

-------

ChangeSet-eplTrsLt3hcE9g6RS5sY4A@public.gmane.org, 2003-09-30 00:47:55-04:00, len.brown@intel.com
  [ACPI] acpi_pci_link_allocate() should stick with irq.active if set. 
(Andrew de Quincey)
  Fixes OSDL #1186 "broken USB" and others

ChangeSet-eplTrsLt3hfo67z2DhGOkQ@public.gmane.org, 2003-09-29 23:53:54-04:00, len.brown@intel.com
  [ACPI] CONFIG_ACPI is no longer necessary to enable HT
  if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y

ChangeSet-eplTrsLt3hfv0h3yOEFlqQ@public.gmane.org, 2003-09-29 23:13:17-04:00, len.brown@intel.com
  [ACPI] ACPI Component Architecture 20030918 (Bob Moore)

  Found and fixed a longstanding problem with the late execution of
  the various deferred AML opcodes (such as Operation Regions,
  Buffer Fields, Buffers, and Packages)...
  This fixes the "region size computed incorrectly" problem.

  Fixed several 64-bit issues with prototypes, casting and data types.

  Removed duplicate prototype from acdisasm.h

ChangeSet-eplTrsLt3hcrhlPfI/lAPw@public.gmane.org, 2003-09-25 16:16:51-04:00, len.brown@intel.com
  [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi
Kleen)





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
