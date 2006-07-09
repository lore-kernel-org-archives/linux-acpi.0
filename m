From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Linux/ACPI vs ACPICA audit -- ACPICA 20060707
Date: Sun, 9 Jul 2006 10:56:58 -0700
Message-ID: <20060709105658.e1c0bad4.rdunlap@xenotime.net>
References: <200606280108.28321.len.brown@intel.com>
	<200607072057.27329.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:50871 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161030AbWGIRyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 13:54:12 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 9 Jul 2006 10:54:10 -0700
In-Reply-To: <200607072057.27329.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 7 Jul 2006 20:57:27 -0400 Len Brown wrote:

> For the files that Linux gets from ACPICA, this diff shows how Linux
> has diverged from upstream.
> 
> acpica-unix-20060707.audit.diff:# 42 files changed, 211 insertions(+), 92 deletions(-)

300+ lines in 42 files.  That doesn't look huge,
but then I'm not trying to maintain it.

Is there supposed to be some kind of value judgment (implied)
in this diff-from-upstream?  Is the Linux code worse/better
or just "fixed" to work with Linux?
Is the diff-from-upstream a maintainer headache?

What is the purpose of these audit reports?


> acpica-unix-20060623.audit.diff:# 37 files changed, 198 insertions(+), 78 deletions(-)
> acpica-unix-20060608.audit.diff:# 35 files changed, 190 insertions(+), 70 deletions(-)
> acpica-unix-20060526.audit.diff:# 34 files changed, 162 insertions(+), 53 deletions(-)
> acpica-unix-20060512.audit.diff:# 34 files changed, 163 insertions(+), 53 deletions(-)
> 
> # 142 ACPICA files
> # drivers/acpi/dispatcher/dswstate.c |    2 
> # drivers/acpi/events/evxface.c      |   83 +++++++++++++----
> # drivers/acpi/events/evxfevnt.c     |    2 
> # drivers/acpi/executer/excreate.c   |    2 
> # drivers/acpi/hardware/hwgpe.c      |    2 
> # drivers/acpi/hardware/hwsleep.c    |   24 ----
> # drivers/acpi/namespace/nsdump.c    |    6 -
> # drivers/acpi/namespace/nsxfeval.c  |    4 
> # drivers/acpi/parser/pstree.c       |    2 
> # drivers/acpi/parser/psutils.c      |    4 
> # drivers/acpi/resources/rsinfo.c    |    2 
> # drivers/acpi/resources/rslist.c    |    2 
> # drivers/acpi/resources/rsutils.c   |    2 
> # drivers/acpi/resources/rsxface.c   |    4 
> # drivers/acpi/tables/tbconvrt.c     |   11 +-
> # drivers/acpi/tables/tbxface.c      |    2 
> # drivers/acpi/utilities/utalloc.c   |    4 
> # drivers/acpi/utilities/utcache.c   |    2 
> # drivers/acpi/utilities/utdebug.c   |    4 
> # drivers/acpi/utilities/utglobal.c  |   11 --
> # drivers/acpi/utilities/utmisc.c    |    3 
> # drivers/acpi/utilities/utmutex.c   |   15 +--
> # drivers/acpi/utilities/utobject.c  |    1 
> # drivers/acpi/utilities/utresrc.c   |    6 -
> # drivers/acpi/utilities/utstate.c   |    1 
> # drivers/acpi/utilities/utxface.c   |    2 
> # include/acpi/acdebug.h             |    2 
> # include/acpi/acdispat.h            |    2 
> # include/acpi/acglobal.h            |    6 -
> # include/acpi/achware.h             |    4 
> # include/acpi/acinterp.h            |    2 
> # include/acpi/aclocal.h             |    2 
> # include/acpi/acmacros.h            |    2 
> # include/acpi/acnamesp.h            |    4 
> # include/acpi/acparser.h            |    4 
> # include/acpi/acpiosxf.h            |   17 ++-
> # include/acpi/acpixf.h              |   24 ++++
> # include/acpi/acresrc.h             |    3 
> # include/acpi/actbl.h               |    2 
> # include/acpi/actbl1.h              |    2 
> # include/acpi/acutils.h             |    8 +
> # include/acpi/platform/aclinux.h    |   16 ++-
> # 42 files changed, 211 insertions(+), 92 deletions(-)


---
~Randy
