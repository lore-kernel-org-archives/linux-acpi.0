From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] 2.4.23 ACPI 20030918
Date: 01 Oct 2003 01:46:42 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064987202.2583.196.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0D56318@hdsmsx402.hd.intel.com>
	 <1064986198.2574.190.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1064986198.2574.190.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

	This batch includes the config change you requested to decouple
	ACPI and HT, ACPICA 20030918, and more platform fixes.

thanks,
-Len

ps. for folks w/o BK, a plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-pre5/acpi-20030918-2.4.23-pre5.diff.gz

This will update the following files:

 Documentation/Configure.help       |    3 
 MAINTAINERS                        |   10 
 drivers/acpi/Config.in             |   52 +---
 drivers/acpi/asus_acpi.c           |  294 +++++++++++++------------
 drivers/acpi/bus.c                 |    4 
 drivers/acpi/dispatcher/dsfield.c  |   42 ++-
 drivers/acpi/dispatcher/dsinit.c   |    4 
 drivers/acpi/dispatcher/dsopcode.c |   35 +-
 drivers/acpi/dispatcher/dsutils.c  |  114 +++++----
 drivers/acpi/dispatcher/dswload.c  |   18 +
 drivers/acpi/dispatcher/dswscope.c |   11 
 drivers/acpi/dispatcher/dswstate.c |   30 +-
 drivers/acpi/executer/excreate.c   |    8 
 drivers/acpi/namespace/nsdump.c    |    4 
 drivers/acpi/namespace/nssearch.c  |    8 
 drivers/acpi/namespace/nsutils.c   |    9 
 drivers/acpi/parser/psparse.c      |   31 +-
 drivers/acpi/pci_irq.c             |    3 
 drivers/acpi/pci_link.c            |    6 
 include/acpi/acconfig.h            |    2 
 include/acpi/acdisasm.h            |    4 
 include/acpi/acstruct.h            |    3 
 22 files changed, 392 insertions(+), 303 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/30 1.1063.43.20)
   [ACPI] deal with lack of acpi prt entries gracefully (Jesse Barnes)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/30 1.1063.43.19)
   [ACPI] build fix: remove 2nd __exit from asus_acpi.c

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/30 1.1063.43.18)
   [ACPI] acpi4asus-0.25-0.26 (Karol Kozimor)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/30 1.1063.43.17)
   [ACPI] acpi4asus-0.24a-0.25-2.4 (Karol Kozimor)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/30 1.1063.43.16)
   [ACPI] acpi_pci_link_allocate() should stick with irq.active if set. 
(Andrew de Quincey)
   Fixes OSDL #1186 "broken USB" and others

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/29 1.1063.43.15)
   [ACPI] CONFIG_ACPI is no longer necessary to enable HT
   if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/29 1.1063.43.14)
   [ACPI] ACPI Component Architecture 20030918 (Bob Moore)
   
   Found and fixed a longstanding problem with the late execution of
   the various deferred AML opcodes (such as Operation Regions,
   Buffer Fields, Buffers, and Packages)...
   This fixes the "region size computed incorrectly" problem.
   
   Fixed several 64-bit issues with prototypes, casting and data types.
   
   Removed duplicate prototype from acdisasm.h

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/25 1.1063.43.13)
   [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi
Kleen)






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
