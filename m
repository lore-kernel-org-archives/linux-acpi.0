From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 27 Jan 2004 00:52:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075182740.2489.40.camel@dhcppc4>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.25

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.25/acpi-20040116-2.4.25.diff.gz

This will update the following files:

 drivers/acpi/ac.c                  |    2 
 drivers/acpi/asus_acpi.c           |    8 +-
 drivers/acpi/battery.c             |    2 
 drivers/acpi/button.c              |    2 
 drivers/acpi/dispatcher/dsfield.c  |    2 
 drivers/acpi/dispatcher/dsinit.c   |    2 
 drivers/acpi/dispatcher/dsmethod.c |    2 
 drivers/acpi/dispatcher/dsmthdat.c |    3 
 drivers/acpi/dispatcher/dsobject.c |    2 
 drivers/acpi/dispatcher/dsopcode.c |    2 
 drivers/acpi/dispatcher/dsutils.c  |    2 
 drivers/acpi/dispatcher/dswexec.c  |    2 
 drivers/acpi/dispatcher/dswload.c  |    2 
 drivers/acpi/dispatcher/dswscope.c |    2 
 drivers/acpi/dispatcher/dswstate.c |    2 
 drivers/acpi/ec.c                  |    2 
 drivers/acpi/events/evevent.c      |    2 
 drivers/acpi/events/evgpe.c        |    2 
 drivers/acpi/events/evgpeblk.c     |    2 
 drivers/acpi/events/evmisc.c       |    2 
 drivers/acpi/events/evregion.c     |    7 --
 drivers/acpi/events/evrgnini.c     |    2 
 drivers/acpi/events/evsci.c        |    2 
 drivers/acpi/events/evxface.c      |    2 
 drivers/acpi/events/evxfevnt.c     |    2 
 drivers/acpi/events/evxfregn.c     |    2 
 drivers/acpi/executer/exconfig.c   |    2 
 drivers/acpi/executer/exconvrt.c   |    2 
 drivers/acpi/executer/excreate.c   |    2 
 drivers/acpi/executer/exdump.c     |    2 
 drivers/acpi/executer/exfield.c    |    2 
 drivers/acpi/executer/exfldio.c    |    2 
 drivers/acpi/executer/exmisc.c     |    2 
 drivers/acpi/executer/exmutex.c    |    2 
 drivers/acpi/executer/exnames.c    |    2 
 drivers/acpi/executer/exoparg1.c   |    2 
 drivers/acpi/executer/exoparg2.c   |    2 
 drivers/acpi/executer/exoparg3.c   |    2 
 drivers/acpi/executer/exoparg6.c   |    2 
 drivers/acpi/executer/exprep.c     |    2 
 drivers/acpi/executer/exregion.c   |    2 
 drivers/acpi/executer/exresnte.c   |    2 
 drivers/acpi/executer/exresolv.c   |    2 
 drivers/acpi/executer/exresop.c    |    2 
 drivers/acpi/executer/exstore.c    |    2 
 drivers/acpi/executer/exstoren.c   |    2 
 drivers/acpi/executer/exstorob.c   |    2 
 drivers/acpi/executer/exsystem.c   |    2 
 drivers/acpi/executer/exutils.c    |    2 
 drivers/acpi/fan.c                 |    2 
 drivers/acpi/hardware/hwacpi.c     |    2 
 drivers/acpi/hardware/hwgpe.c      |   16 +----
 drivers/acpi/hardware/hwregs.c     |    2 
 drivers/acpi/hardware/hwsleep.c    |   78 +++++++++++++++++--------
 drivers/acpi/hardware/hwtimer.c    |    2 
 drivers/acpi/namespace/nsaccess.c  |    2 
 drivers/acpi/namespace/nsalloc.c   |    2 
 drivers/acpi/namespace/nsdump.c    |    2 
 drivers/acpi/namespace/nsdumpdv.c  |    2 
 drivers/acpi/namespace/nseval.c    |    2 
 drivers/acpi/namespace/nsinit.c    |    2 
 drivers/acpi/namespace/nsload.c    |    2 
 drivers/acpi/namespace/nsnames.c   |    2 
 drivers/acpi/namespace/nsobject.c  |    2 
 drivers/acpi/namespace/nsparse.c   |    2 
 drivers/acpi/namespace/nssearch.c  |    2 
 drivers/acpi/namespace/nsutils.c   |    2 
 drivers/acpi/namespace/nswalk.c    |    2 
 drivers/acpi/namespace/nsxfeval.c  |    2 
 drivers/acpi/namespace/nsxfname.c  |    2 
 drivers/acpi/namespace/nsxfobj.c   |    2 
 drivers/acpi/osl.c                 |    8 +-
 drivers/acpi/parser/psargs.c       |    2 
 drivers/acpi/parser/psopcode.c     |    2 
 drivers/acpi/parser/psparse.c      |    2 
 drivers/acpi/parser/psscope.c      |    2 
 drivers/acpi/parser/pstree.c       |    2 
 drivers/acpi/parser/psutils.c      |    2 
 drivers/acpi/parser/pswalk.c       |    2 
 drivers/acpi/parser/psxface.c      |    2 
 drivers/acpi/power.c               |    2 
 drivers/acpi/processor.c           |    2 
 drivers/acpi/resources/rsaddr.c    |    2 
 drivers/acpi/resources/rscalc.c    |    2 
 drivers/acpi/resources/rscreate.c  |    2 
 drivers/acpi/resources/rsdump.c    |    2 
 drivers/acpi/resources/rsio.c      |    2 
 drivers/acpi/resources/rsirq.c     |    2 
 drivers/acpi/resources/rslist.c    |    2 
 drivers/acpi/resources/rsmemory.c  |    2 
 drivers/acpi/resources/rsmisc.c    |    2 
 drivers/acpi/resources/rsutils.c   |    2 
 drivers/acpi/resources/rsxface.c   |    2 
 drivers/acpi/tables.c              |   13 +++-
 drivers/acpi/tables/tbconvrt.c     |   10 +--
 drivers/acpi/tables/tbget.c        |    2 
 drivers/acpi/tables/tbgetall.c     |    2 
 drivers/acpi/tables/tbinstal.c     |    2 
 drivers/acpi/tables/tbrsdt.c       |   13 +++-
 drivers/acpi/tables/tbutils.c      |    2 
 drivers/acpi/tables/tbxface.c      |    2 
 drivers/acpi/tables/tbxfroot.c     |    6 -
 drivers/acpi/thermal.c             |    4 -
 drivers/acpi/toshiba_acpi.c        |    2 
 drivers/acpi/utilities/utalloc.c   |    2 
 drivers/acpi/utilities/utcopy.c    |    2 
 drivers/acpi/utilities/utdebug.c   |    2 
 drivers/acpi/utilities/utdelete.c  |    2 
 drivers/acpi/utilities/uteval.c    |    2 
 drivers/acpi/utilities/utglobal.c  |    2 
 drivers/acpi/utilities/utinit.c    |    2 
 drivers/acpi/utilities/utmath.c    |    2 
 drivers/acpi/utilities/utmisc.c    |   14 ++--
 drivers/acpi/utilities/utobject.c  |    2 
 drivers/acpi/utilities/utxface.c   |    2 
 include/acpi/acconfig.h            |    4 -
 include/acpi/acdebug.h             |    2 
 include/acpi/acdisasm.h            |    2 
 include/acpi/acdispat.h            |    2 
 include/acpi/acevents.h            |    2 
 include/acpi/acexcep.h             |    2 
 include/acpi/acglobal.h            |    2 
 include/acpi/achware.h             |    2 
 include/acpi/acinterp.h            |    2 
 include/acpi/aclocal.h             |    2 
 include/acpi/acmacros.h            |    2 
 include/acpi/acnamesp.h            |    2 
 include/acpi/acobject.h            |    2 
 include/acpi/acoutput.h            |    2 
 include/acpi/acparser.h            |    2 
 include/acpi/acpi.h                |    2 
 include/acpi/acpiosxf.h            |    2 
 include/acpi/acpixf.h              |    2 
 include/acpi/acresrc.h             |    2 
 include/acpi/acstruct.h            |    2 
 include/acpi/actables.h            |    2 
 include/acpi/actbl.h               |    9 ++
 include/acpi/actbl1.h              |    2 
 include/acpi/actbl2.h              |    2 
 include/acpi/actypes.h             |    2 
 include/acpi/acutils.h             |    2 
 include/acpi/amlcode.h             |    2 
 include/acpi/amlresrc.h            |    2 
 include/acpi/platform/acenv.h      |    2 
 include/acpi/platform/acgcc.h      |    2 
 include/acpi/platform/aclinux.h    |    2 
 146 files changed, 252 insertions(+), 205 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/01/26 1.1063.46.67)
   [ACPI] handle system with NULL DSDT and valid XDSDT
           from ia64 via Alex Williamson

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/01/26 1.1063.46.66)
   [ACPI] move zero initialized data to .bss
   	from Jes Sorensen

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/01/17 1.1063.46.65)
   [ACPI] ACPICA 20040116 from Bob Moore
   
   The purpose of this release is primarily to update the copyright
years
   in each module, thus causing a huge number of diffs.  There are a few
   small functional changes, however.
   
   Improved error messages when there is a problem finding one or more
of
   the required base ACPI tables
   
   Reintroduced the definition of APIC_HEADER in actbl.h
   
   Changed definition of MADT_ADDRESS_OVERRIDE to 64 bits (actbl.h)
   
   Removed extraneous reference to NewObj in dsmthdat.c







-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
