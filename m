From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPICA 20031002 for 2.4
Date: 11 Oct 2003 01:49:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065851355.4118.75.camel@dhcppc4>
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
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-pre7/acpi-20031002-2.4.23-pre7.diff.gz

This will update the following files:

 drivers/acpi/asus_acpi.c          |    4 
 drivers/acpi/executer/exconfig.c  |    9 -
 drivers/acpi/executer/exfield.c   |   13 -
 drivers/acpi/executer/exfldio.c   |  143 +++++++++++------
 drivers/acpi/executer/exoparg1.c  |    2 
 drivers/acpi/executer/exprep.c    |  189 +++++++++++++++++-----
 drivers/acpi/executer/exresnte.c  |   24 ++
 drivers/acpi/executer/exresolv.c  |    6 
 drivers/acpi/executer/exresop.c   |   13 +
 drivers/acpi/executer/exstoren.c  |    8 
 drivers/acpi/executer/exsystem.c  |   17 --
 drivers/acpi/hardware/hwacpi.c    |    9 +
 drivers/acpi/resources/rsaddr.c   |   45 ++++-
 drivers/acpi/resources/rsirq.c    |   17 +-
 drivers/acpi/tables/tbconvrt.c    |   18 +-
 drivers/acpi/tables/tbinstal.c    |   15 -
 drivers/acpi/utilities/utalloc.c  |    2 
 drivers/acpi/utilities/utglobal.c |    4 
 include/acpi/acconfig.h           |    2 
 include/acpi/acexcep.h            |    4 
 include/acpi/actbl.h              |  217 +++++++++++++++++++-------
 include/acpi/actbl1.h             |    4 
 include/acpi/actbl2.h             |   19 +-
 include/acpi/actypes.h            |    1 
 24 files changed, 567 insertions(+), 218 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/07 1.1063.43.22)
   [ACPI] fix acpi_asus module build (Stephen Hemminger)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/06 1.1063.43.21)
   [ACPI] Summary of changes for ACPICA version 20031002:
   
   Fixed a problem with Index Fields where the index was not incremented
   for fields that require multiple writes to the index/data registers
   (Fields that are wider than the data register.)
   
   Fixed a problem with all Field objects where a write could go beyond
the
   end-of-field if the field was larger than the access granularity and
   therefore required multiple writes to complete the request.  An extra
   write beyond the end of the field could happen inadvertently.
   
   Fixed a problem with Index Fields where a BUFFER_OVERFLOW error would
   incorrectly be returned if the width of the Data Register was larger
   than the specified field access width.
   
   Completed fixes for LoadTable() and Unload() and verified their
   operation.  Implemented full support for the "DdbHandle" object
   throughout the ACPI CA subsystem.
   
   Implemented full support for the MADT and ECDT tables in the ACPI CA
   header files.  Even though these tables are not directly consumed by
   ACPI CA, the header definitions are useful for ACPI device drivers.
   
   Integrated resource descriptor fixes posted to the Linux ACPI list.
   This included checks for minimum descriptor length, and support for
   trailing NULL strings within descriptors that have optional string
   elements.
   
   Fixed a problem where the SMI_CMD register could be written even if
it
   was not supported on the platform (when FADT.SMI_CMD is zero)






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
