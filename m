From: Len Brown <lenb@kernel.org>
Subject: Re: [Devel] Linux/ACPI vs ACPICA audit -- Linux-2.6.26-rc0 vs ACPICA-20080321
Date: Wed, 23 Apr 2008 23:46:34 -0400
Message-ID: <200804232346.34909.lenb@kernel.org>
References: <200804232314.46223.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60177 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYDXDqy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 23:46:54 -0400
In-Reply-To: <200804232314.46223.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org
Cc: linux-acpi@vger.kernel.org

you know you're in trouble when a patch exceeds the 100KB limit on linux-acpi...

You can download a copy of the patch from this URL:

http://master.kernel.org/~lenb/acpica-unix-20080321.audit.diff

thanks,
-Len

----
For the files that Linux gets from ACPICA, this diff shows how Linux
has diverged from upstream.

acpica-unix-20080321.audit.diff:# 69 files changed, 905 insertions(+), 632 deletions(-)
acpica-unix-20070126.audit.diff:# 57 files changed, 485 insertions(+), 229 deletions(-)
acpica-unix-20060707.audit.diff:# 42 files changed, 221 insertions(+), 76 deletions(-)
acpica-unix-20060623.audit.diff:# 37 files changed, 198 insertions(+), 78 deletions(-)
acpica-unix-20060608.audit.diff:# 35 files changed, 190 insertions(+), 70 deletions(-)

Some notes...
I added -bB to diff to reduce the whitespace diffs this time --
which were generarlly just Lindent-induced #endif /* comment */ lines anyway.

ACPICA-20080321 is proposed to ship in Linux-2.6.26
ACPICA-20070126 has been shipping since Linux-2.6.21, though it gained
some patches cherry-picked from later ACPICA releases.

cheers,
-Len


# 140 ACPICA files
# drivers/acpi/dispatcher/dsmethod.c |    4 
# drivers/acpi/dispatcher/dsmthdat.c |    2 
# drivers/acpi/dispatcher/dsobject.c |    2 
# drivers/acpi/dispatcher/dsopcode.c |    4 
# drivers/acpi/dispatcher/dswload.c  |    3 
# drivers/acpi/dispatcher/dswstate.c |    8 
# drivers/acpi/events/evevent.c      |    9 -
# drivers/acpi/events/evgpe.c        |   97 ++--------
# drivers/acpi/events/evmisc.c       |   40 +++-
# drivers/acpi/events/evrgnini.c     |    3 
# drivers/acpi/events/evsci.c        |    1 
# drivers/acpi/events/evxface.c      |   58 +++++-
# drivers/acpi/events/evxfevnt.c     |    4 
# drivers/acpi/executer/exmutex.c    |    7 
# drivers/acpi/executer/exregion.c   |    5 
# drivers/acpi/hardware/hwgpe.c      |    2 
# drivers/acpi/hardware/hwregs.c     |   91 +++-------
# drivers/acpi/hardware/hwsleep.c    |  152 +++++++++--------
# drivers/acpi/namespace/nsdump.c    |    6 
# drivers/acpi/namespace/nseval.c    |    2 
# drivers/acpi/namespace/nsinit.c    |    9 +
# drivers/acpi/namespace/nsparse.c   |    2 
# drivers/acpi/namespace/nsutils.c   |    1 
# drivers/acpi/namespace/nsxfeval.c  |   32 +--
# drivers/acpi/namespace/nsxfobj.c   |   44 ++++
# drivers/acpi/parser/psopcode.c     |    8 
# drivers/acpi/parser/pstree.c       |    2 
# drivers/acpi/parser/psutils.c      |    2 
# drivers/acpi/resources/rscreate.c  |   28 ++-
# drivers/acpi/resources/rsinfo.c    |    2 
# drivers/acpi/resources/rslist.c    |    2 
# drivers/acpi/resources/rsutils.c   |    2 
# drivers/acpi/resources/rsxface.c   |    4 
# drivers/acpi/tables/tbfadt.c       |   11 +
# drivers/acpi/tables/tbinstal.c     |   29 +--
# drivers/acpi/tables/tbutils.c      |   85 ++++++++-
# drivers/acpi/tables/tbxface.c      |  128 ++++++++++++--
# drivers/acpi/tables/tbxfroot.c     |    4 
# drivers/acpi/utilities/utalloc.c   |    6 
# drivers/acpi/utilities/utcache.c   |    4 
# drivers/acpi/utilities/utdebug.c   |   11 -
# drivers/acpi/utilities/uteval.c    |   32 +++
# drivers/acpi/utilities/utglobal.c  |   22 --
# drivers/acpi/utilities/utmisc.c    |    6 
# drivers/acpi/utilities/utmutex.c   |   23 +-
# drivers/acpi/utilities/utobject.c  |   26 +-
# drivers/acpi/utilities/utresrc.c   |    8 
# drivers/acpi/utilities/utstate.c   |    5 
# drivers/acpi/utilities/utxface.c   |   45 -----
# include/acpi/acconfig.h            |    2 
# include/acpi/acdebug.h             |    2 
# include/acpi/acglobal.h            |   95 +++++-----
# include/acpi/achware.h             |    8 
# include/acpi/acinterp.h            |    2 
# include/acpi/aclocal.h             |    4 
# include/acpi/acmacros.h            |   71 +++++--
# include/acpi/acnamesp.h            |    4 
# include/acpi/acoutput.h            |    4 
# include/acpi/acparser.h            |    4 
# include/acpi/acpiosxf.h            |   32 +--
# include/acpi/acpixf.h              |   44 +++-
# include/acpi/acresrc.h             |    2 
# include/acpi/acstruct.h            |    2 
# include/acpi/actbl.h               |    8 
# include/acpi/actbl1.h              |   37 ++--
# include/acpi/actbl2.h              |   49 -----
# include/acpi/actypes.h             |   24 --
# include/acpi/acutils.h             |   13 +
# include/acpi/platform/aclinux.h    |   47 ++++-
# 69 files changed, 905 insertions(+), 632 deletions(-)

