From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 25 Feb 2004 05:01:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077700687.5912.188.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.25/acpi-20040211-2.4.25.diff.gz

This will update the following files:

 drivers/acpi/Config.in             |    3 --
 drivers/acpi/dispatcher/dsmthdat.c |    9 ++++--
 drivers/acpi/dispatcher/dsobject.c |    5 +++
 drivers/acpi/dispatcher/dsopcode.c |    6 ++--
 drivers/acpi/dispatcher/dsutils.c  |    3 +-
 drivers/acpi/dispatcher/dswstate.c |    2 -
 drivers/acpi/executer/exconvrt.c   |   35 ++++++++++++++++---------
 drivers/acpi/executer/exfldio.c    |    4 +-
 drivers/acpi/executer/exmisc.c     |    8 +++--
 drivers/acpi/executer/exoparg2.c   |    4 ++
 drivers/acpi/executer/exprep.c     |    2 -
 drivers/acpi/executer/exresolv.c   |    6 ++--
 drivers/acpi/executer/exresop.c    |    4 +-
 drivers/acpi/executer/exstore.c    |   29 ++++++++++++++------
 drivers/acpi/executer/exstoren.c   |    8 +++++
 drivers/acpi/namespace/nsaccess.c  |    2 -
 drivers/acpi/parser/psargs.c       |    4 +-
 include/acpi/acconfig.h            |    2 -
 18 files changed, 87 insertions(+), 49 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/13 1.1063.46.74)
   [ACPI] ACPICA 20040211 udpate from Bob Moore
   
   Completed investigation and implementation of the
   call-by-reference mechanism for control method arguments.
   
   Fixed a problem where a store of an object into an indexed
   package could fail if the store occurs within a different
   method than the method that created the package.
   
   Fixed a problem where the ToDecimal operator could return
   incorrect results.
   
   Fixed a problem where the CopyObject operator could fail
   on some of the more obscure objects (e.g., Reference objects.)
   
   Improved the output of the Debug object to display buffer,
   package, and index objects.
   
   Fixed a problem where constructs of the form "RefOf (ArgX)"
   did not return the expected result.
   
   Added permanent ACPI_REPORT_ERROR macros for all instances of the
   ACPI_AML_INTERNAL exception.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/13 1.1063.46.73)
   [ACPI] revert previous AML param patch for ACPICA update

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/10 1.1063.46.72)
   [ACPI] CONFIG_ACPI_NUMA depends on CONFIG_IA64






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
