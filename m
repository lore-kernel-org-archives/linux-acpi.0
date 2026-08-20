Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210735E956;
	Thu, 20 Aug 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240082; cv=none; b=EVpXnMdZOB5JRfsMrpuceJ8ZUYK4dq5VCP7T4OUWN23741FR29fPlTc9dsNn8BPB+p2DyG8cQSzWcGIc9ydIZwTxjq5VQc7aQLbswg9zLdRnObyYAlJqmFdnfL61i+zouKDWr6iFMO827GvVPWoG99lERfQrCohl9vW7j4ff2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240082; c=relaxed/simple;
	bh=IB3uNC6YXpFfP5qSg9zWUD7s/htbkENwE4vn2/gj/Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkA1hNiTQ3nt669nWBP41Ql8V4dzcCQNnQMy7dPCcoFculx3S54Ey+NrfvEkAE4Of1U7r6Z/khSabg22U1oXCFhhY+Gq+kgzJYGMxJBdlGGD1Zi/544cwhXe6V8SjlLij5Y6DUDT8HB8S18UD9cx+FXv7+Gq8NMQmNy7k/BavJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOzLwt4t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOzLwt4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787240076; x=1818776076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IB3uNC6YXpFfP5qSg9zWUD7s/htbkENwE4vn2/gj/Pk=;
  b=UOzLwt4tCMO2CItkX79n92aClHCyZA5YM8H1bLxngNXQ1eAABU+rtVfB
   VC0KZFNUde6zFiY8XdjeNGoRX+zZ2yDdGYLqujqvMHoR6y1glTIsFqcnh
   uZ+8Ks1kQ+Z+LXc9coHWe7KcJ8T3v04MJSTjQOxf+zn5Yz3S1VQohcVEF
   sZz0ZuFRqnjaSpY78cPHcUQH9lXrtxCVL2btptnnHUld3iVWZT4TVmctR
   pnJL9YF6XITUFtQfLw8kKlD3bpf0QezUxQcltGIgZqxi5phV9cs3pSJPZ
   n0Gjzyg+3Ew15telJwjrOT9yKUgVyJnmSVeSIZvAQw9xbsw7yrTtKS4nd
   A==;
X-CSE-ConnectionGUID: C6ouTLYCS/i2ZYrguuNZMg==
X-CSE-MsgGUID: ewBao/S5Q5uaHOnL0QnYPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86896306"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="86896306"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 08:34:35 -0700
X-CSE-ConnectionGUID: o5wT2UEwQUCAv8Q7ZW3CTQ==
X-CSE-MsgGUID: b0YOVBRPQiC+5DKOgAtDEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="264283929"
Received: from abityuts-desk1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 08:34:31 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: rafael@kernel.org
Cc: maciej.wieczor-retman@intel.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPICA: Update the SPDX license identifiers
Date: Thu, 20 Aug 2026 17:31:51 +0200
Message-ID: <20260820153152.1801259-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA upstream changed its license to "BSD-2-Clause-Patent OR
GPL-2.0-only". Update the SPDX license identifier of every ACPICA file
carried by the kernel to the GPL-2.0-only license. Specifically all of
drivers/acpi/acpica/, the ACPICA headers in include/acpi/ and
include/acpi/platform/, and the ACPICA sources shared with the acpidump
tool under tools/power/acpi/.

Linux specific files in those directories keep their own identifiers and
are not touched. No functional change.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/acapps.h                             | 2 +-
 drivers/acpi/acpica/accommon.h                           | 2 +-
 drivers/acpi/acpica/acconvert.h                          | 2 +-
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/acpica/acdispat.h                           | 2 +-
 drivers/acpi/acpica/acevents.h                           | 2 +-
 drivers/acpi/acpica/acglobal.h                           | 2 +-
 drivers/acpi/acpica/achware.h                            | 2 +-
 drivers/acpi/acpica/acinterp.h                           | 2 +-
 drivers/acpi/acpica/aclocal.h                            | 2 +-
 drivers/acpi/acpica/acmacros.h                           | 2 +-
 drivers/acpi/acpica/acnamesp.h                           | 2 +-
 drivers/acpi/acpica/acobject.h                           | 2 +-
 drivers/acpi/acpica/acopcode.h                           | 2 +-
 drivers/acpi/acpica/acparser.h                           | 2 +-
 drivers/acpi/acpica/acpredef.h                           | 2 +-
 drivers/acpi/acpica/acresrc.h                            | 2 +-
 drivers/acpi/acpica/acstruct.h                           | 2 +-
 drivers/acpi/acpica/actables.h                           | 2 +-
 drivers/acpi/acpica/acutils.h                            | 2 +-
 drivers/acpi/acpica/amlcode.h                            | 2 +-
 drivers/acpi/acpica/amlresrc.h                           | 2 +-
 drivers/acpi/acpica/dbcmds.c                             | 2 +-
 drivers/acpi/acpica/dbconvert.c                          | 2 +-
 drivers/acpi/acpica/dbdisply.c                           | 2 +-
 drivers/acpi/acpica/dbexec.c                             | 2 +-
 drivers/acpi/acpica/dbfileio.c                           | 2 +-
 drivers/acpi/acpica/dbhistry.c                           | 2 +-
 drivers/acpi/acpica/dbinput.c                            | 2 +-
 drivers/acpi/acpica/dbmethod.c                           | 2 +-
 drivers/acpi/acpica/dbnames.c                            | 2 +-
 drivers/acpi/acpica/dbobject.c                           | 2 +-
 drivers/acpi/acpica/dbstats.c                            | 2 +-
 drivers/acpi/acpica/dbtest.c                             | 2 +-
 drivers/acpi/acpica/dbutils.c                            | 2 +-
 drivers/acpi/acpica/dbxface.c                            | 2 +-
 drivers/acpi/acpica/dsargs.c                             | 2 +-
 drivers/acpi/acpica/dscontrol.c                          | 2 +-
 drivers/acpi/acpica/dsdebug.c                            | 2 +-
 drivers/acpi/acpica/dsfield.c                            | 2 +-
 drivers/acpi/acpica/dsinit.c                             | 2 +-
 drivers/acpi/acpica/dsmethod.c                           | 2 +-
 drivers/acpi/acpica/dsmthdat.c                           | 2 +-
 drivers/acpi/acpica/dsobject.c                           | 2 +-
 drivers/acpi/acpica/dsopcode.c                           | 2 +-
 drivers/acpi/acpica/dspkginit.c                          | 2 +-
 drivers/acpi/acpica/dsutils.c                            | 2 +-
 drivers/acpi/acpica/dswexec.c                            | 2 +-
 drivers/acpi/acpica/dswload.c                            | 2 +-
 drivers/acpi/acpica/dswload2.c                           | 2 +-
 drivers/acpi/acpica/dswscope.c                           | 2 +-
 drivers/acpi/acpica/dswstate.c                           | 2 +-
 drivers/acpi/acpica/evevent.c                            | 2 +-
 drivers/acpi/acpica/evglock.c                            | 2 +-
 drivers/acpi/acpica/evgpe.c                              | 2 +-
 drivers/acpi/acpica/evgpeblk.c                           | 2 +-
 drivers/acpi/acpica/evgpeinit.c                          | 2 +-
 drivers/acpi/acpica/evgpeutil.c                          | 2 +-
 drivers/acpi/acpica/evhandler.c                          | 2 +-
 drivers/acpi/acpica/evmisc.c                             | 2 +-
 drivers/acpi/acpica/evregion.c                           | 2 +-
 drivers/acpi/acpica/evrgnini.c                           | 2 +-
 drivers/acpi/acpica/evsci.c                              | 2 +-
 drivers/acpi/acpica/evxface.c                            | 2 +-
 drivers/acpi/acpica/evxfevnt.c                           | 2 +-
 drivers/acpi/acpica/evxfgpe.c                            | 2 +-
 drivers/acpi/acpica/evxfregn.c                           | 2 +-
 drivers/acpi/acpica/exconcat.c                           | 2 +-
 drivers/acpi/acpica/exconfig.c                           | 2 +-
 drivers/acpi/acpica/exconvrt.c                           | 2 +-
 drivers/acpi/acpica/excreate.c                           | 2 +-
 drivers/acpi/acpica/exdebug.c                            | 2 +-
 drivers/acpi/acpica/exdump.c                             | 2 +-
 drivers/acpi/acpica/exfield.c                            | 2 +-
 drivers/acpi/acpica/exfldio.c                            | 2 +-
 drivers/acpi/acpica/exmisc.c                             | 2 +-
 drivers/acpi/acpica/exmutex.c                            | 2 +-
 drivers/acpi/acpica/exnames.c                            | 2 +-
 drivers/acpi/acpica/exoparg1.c                           | 2 +-
 drivers/acpi/acpica/exoparg2.c                           | 2 +-
 drivers/acpi/acpica/exoparg3.c                           | 2 +-
 drivers/acpi/acpica/exoparg6.c                           | 2 +-
 drivers/acpi/acpica/exprep.c                             | 2 +-
 drivers/acpi/acpica/exregion.c                           | 2 +-
 drivers/acpi/acpica/exresnte.c                           | 2 +-
 drivers/acpi/acpica/exresolv.c                           | 2 +-
 drivers/acpi/acpica/exresop.c                            | 2 +-
 drivers/acpi/acpica/exserial.c                           | 2 +-
 drivers/acpi/acpica/exstore.c                            | 2 +-
 drivers/acpi/acpica/exstoren.c                           | 2 +-
 drivers/acpi/acpica/exstorob.c                           | 2 +-
 drivers/acpi/acpica/exsystem.c                           | 2 +-
 drivers/acpi/acpica/extrace.c                            | 2 +-
 drivers/acpi/acpica/exutils.c                            | 2 +-
 drivers/acpi/acpica/hwacpi.c                             | 2 +-
 drivers/acpi/acpica/hwesleep.c                           | 2 +-
 drivers/acpi/acpica/hwgpe.c                              | 2 +-
 drivers/acpi/acpica/hwpci.c                              | 2 +-
 drivers/acpi/acpica/hwregs.c                             | 2 +-
 drivers/acpi/acpica/hwsleep.c                            | 2 +-
 drivers/acpi/acpica/hwtimer.c                            | 2 +-
 drivers/acpi/acpica/hwvalid.c                            | 2 +-
 drivers/acpi/acpica/hwxface.c                            | 2 +-
 drivers/acpi/acpica/hwxfsleep.c                          | 2 +-
 drivers/acpi/acpica/nsaccess.c                           | 2 +-
 drivers/acpi/acpica/nsalloc.c                            | 2 +-
 drivers/acpi/acpica/nsarguments.c                        | 2 +-
 drivers/acpi/acpica/nsconvert.c                          | 2 +-
 drivers/acpi/acpica/nsdump.c                             | 2 +-
 drivers/acpi/acpica/nsdumpdv.c                           | 2 +-
 drivers/acpi/acpica/nseval.c                             | 2 +-
 drivers/acpi/acpica/nsinit.c                             | 2 +-
 drivers/acpi/acpica/nsload.c                             | 2 +-
 drivers/acpi/acpica/nsnames.c                            | 2 +-
 drivers/acpi/acpica/nsobject.c                           | 2 +-
 drivers/acpi/acpica/nsparse.c                            | 2 +-
 drivers/acpi/acpica/nspredef.c                           | 2 +-
 drivers/acpi/acpica/nsprepkg.c                           | 2 +-
 drivers/acpi/acpica/nsrepair.c                           | 2 +-
 drivers/acpi/acpica/nsrepair2.c                          | 2 +-
 drivers/acpi/acpica/nssearch.c                           | 2 +-
 drivers/acpi/acpica/nsutils.c                            | 2 +-
 drivers/acpi/acpica/nswalk.c                             | 2 +-
 drivers/acpi/acpica/nsxfeval.c                           | 2 +-
 drivers/acpi/acpica/nsxfname.c                           | 2 +-
 drivers/acpi/acpica/nsxfobj.c                            | 2 +-
 drivers/acpi/acpica/psargs.c                             | 2 +-
 drivers/acpi/acpica/psloop.c                             | 2 +-
 drivers/acpi/acpica/psobject.c                           | 2 +-
 drivers/acpi/acpica/psopcode.c                           | 2 +-
 drivers/acpi/acpica/psopinfo.c                           | 2 +-
 drivers/acpi/acpica/psparse.c                            | 2 +-
 drivers/acpi/acpica/psscope.c                            | 2 +-
 drivers/acpi/acpica/pstree.c                             | 2 +-
 drivers/acpi/acpica/psutils.c                            | 2 +-
 drivers/acpi/acpica/pswalk.c                             | 2 +-
 drivers/acpi/acpica/psxface.c                            | 2 +-
 drivers/acpi/acpica/rsaddr.c                             | 2 +-
 drivers/acpi/acpica/rscalc.c                             | 2 +-
 drivers/acpi/acpica/rscreate.c                           | 2 +-
 drivers/acpi/acpica/rsdump.c                             | 2 +-
 drivers/acpi/acpica/rsdumpinfo.c                         | 2 +-
 drivers/acpi/acpica/rsinfo.c                             | 2 +-
 drivers/acpi/acpica/rsio.c                               | 2 +-
 drivers/acpi/acpica/rsirq.c                              | 2 +-
 drivers/acpi/acpica/rslist.c                             | 2 +-
 drivers/acpi/acpica/rsmemory.c                           | 2 +-
 drivers/acpi/acpica/rsmisc.c                             | 2 +-
 drivers/acpi/acpica/rsserial.c                           | 2 +-
 drivers/acpi/acpica/rsutils.c                            | 2 +-
 drivers/acpi/acpica/rsxface.c                            | 2 +-
 drivers/acpi/acpica/tbdata.c                             | 2 +-
 drivers/acpi/acpica/tbfadt.c                             | 2 +-
 drivers/acpi/acpica/tbfind.c                             | 2 +-
 drivers/acpi/acpica/tbinstal.c                           | 2 +-
 drivers/acpi/acpica/tbprint.c                            | 2 +-
 drivers/acpi/acpica/tbutils.c                            | 2 +-
 drivers/acpi/acpica/tbxface.c                            | 2 +-
 drivers/acpi/acpica/tbxfload.c                           | 2 +-
 drivers/acpi/acpica/tbxfroot.c                           | 2 +-
 drivers/acpi/acpica/utaddress.c                          | 2 +-
 drivers/acpi/acpica/utalloc.c                            | 2 +-
 drivers/acpi/acpica/utascii.c                            | 2 +-
 drivers/acpi/acpica/utbuffer.c                           | 2 +-
 drivers/acpi/acpica/utcache.c                            | 2 +-
 drivers/acpi/acpica/utcksum.c                            | 2 +-
 drivers/acpi/acpica/utcopy.c                             | 2 +-
 drivers/acpi/acpica/utdebug.c                            | 2 +-
 drivers/acpi/acpica/utdecode.c                           | 2 +-
 drivers/acpi/acpica/utdelete.c                           | 2 +-
 drivers/acpi/acpica/uterror.c                            | 2 +-
 drivers/acpi/acpica/uteval.c                             | 2 +-
 drivers/acpi/acpica/utexcep.c                            | 2 +-
 drivers/acpi/acpica/utglobal.c                           | 2 +-
 drivers/acpi/acpica/uthex.c                              | 2 +-
 drivers/acpi/acpica/utids.c                              | 2 +-
 drivers/acpi/acpica/utinit.c                             | 2 +-
 drivers/acpi/acpica/utlock.c                             | 2 +-
 drivers/acpi/acpica/utmath.c                             | 2 +-
 drivers/acpi/acpica/utmisc.c                             | 2 +-
 drivers/acpi/acpica/utmutex.c                            | 2 +-
 drivers/acpi/acpica/utnonansi.c                          | 2 +-
 drivers/acpi/acpica/utobject.c                           | 2 +-
 drivers/acpi/acpica/utosi.c                              | 2 +-
 drivers/acpi/acpica/utownerid.c                          | 2 +-
 drivers/acpi/acpica/utpredef.c                           | 2 +-
 drivers/acpi/acpica/utprint.c                            | 2 +-
 drivers/acpi/acpica/utresdecode.c                        | 2 +-
 drivers/acpi/acpica/utresrc.c                            | 2 +-
 drivers/acpi/acpica/utstate.c                            | 2 +-
 drivers/acpi/acpica/utstring.c                           | 2 +-
 drivers/acpi/acpica/utstrsuppt.c                         | 2 +-
 drivers/acpi/acpica/utstrtoul64.c                        | 2 +-
 drivers/acpi/acpica/uttrack.c                            | 2 +-
 drivers/acpi/acpica/utuuid.c                             | 2 +-
 drivers/acpi/acpica/utxface.c                            | 2 +-
 drivers/acpi/acpica/utxferror.c                          | 2 +-
 drivers/acpi/acpica/utxfinit.c                           | 2 +-
 drivers/acpi/acpica/utxfmutex.c                          | 2 +-
 include/acpi/acbuffer.h                                  | 2 +-
 include/acpi/acconfig.h                                  | 2 +-
 include/acpi/acexcep.h                                   | 2 +-
 include/acpi/acnames.h                                   | 2 +-
 include/acpi/acoutput.h                                  | 2 +-
 include/acpi/acpi.h                                      | 2 +-
 include/acpi/acpiosxf.h                                  | 2 +-
 include/acpi/acpixf.h                                    | 2 +-
 include/acpi/acrestyp.h                                  | 2 +-
 include/acpi/actbl.h                                     | 2 +-
 include/acpi/actbl1.h                                    | 2 +-
 include/acpi/actbl2.h                                    | 2 +-
 include/acpi/actbl3.h                                    | 2 +-
 include/acpi/actypes.h                                   | 2 +-
 include/acpi/acuuid.h                                    | 2 +-
 include/acpi/platform/acenv.h                            | 2 +-
 include/acpi/platform/acenvex.h                          | 2 +-
 include/acpi/platform/acgcc.h                            | 2 +-
 include/acpi/platform/acgccex.h                          | 2 +-
 include/acpi/platform/aclinux.h                          | 2 +-
 include/acpi/platform/aclinuxex.h                        | 2 +-
 include/acpi/platform/aczephyr.h                         | 2 +-
 tools/power/acpi/common/cmfsize.c                        | 2 +-
 tools/power/acpi/common/getopt.c                         | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixdir.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixmap.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixxf.c   | 2 +-
 tools/power/acpi/tools/acpidump/acpidump.h               | 2 +-
 tools/power/acpi/tools/acpidump/apdump.c                 | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 tools/power/acpi/tools/acpidump/apmain.c                 | 2 +-
 231 files changed, 231 insertions(+), 231 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 16e7bffef798..2aed4c2a01a0 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: acapps - common include for ACPI applications/tools
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index b1cf926ebace..90744aa05ff8 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index 22bd6712831d..74ddce7e96c5 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: acapps - common include for ACPI applications/tools
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 09ab8b3db7ed..2e213e78903a 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acdebug.h - ACPI/AML debugger
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index f6208722503b..053abaa2828e 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ccdc3725c773..c78ab993b72a 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index b6e31517650e..168006dc0903 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acglobal.h - Declarations for global variables
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 78323df00ceb..bb18a4c46148 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: achware.h -- hardware specific interfaces
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index a62a4e9e23d6..0484133bcd6b 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ecc700f6e88..c80aab13e894 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 3a7b6dbcdf9d..d84b31868f95 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acmacros.h - C macros for the entire subsystem.
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index b5830e73ca10..2b76d0f278f9 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 9a82e4f734ba..22359e86a415 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index d8a0beb0eaed..1b4eee2f8528 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 5393a11bc924..bafba7b7eb16 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 2208dc7aff8d..79373ddabcad 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index c3dfa92a89a7..4be22b1c71bb 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acresrc.h - Resource Manager function prototypes
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 5c8c14f55faa..9bac693700bf 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acstruct.h - Internal structs
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1334f8643f76..8c8c3b04e505 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actables.h - ACPI table management
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 9049bfee409c..437f14beca02 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 663c6146d6e2..7ef656ca33b6 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: amlcode.h - Definitions for AML, as included in "definition blocks"
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 2c725680590b..b3465cfbc5b2 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: amlresrc.h - AML resource descriptors
diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 3d99a9048585..016044d8ca1e 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbcmds - Miscellaneous debug commands and output routines
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 8dbab6932049..f3d047e58c2b 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbconvert - debugger miscellaneous conversion routines
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index d41eb9e67500..5664b43dc9dc 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbdisply - debug display commands
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index d3a9521e2dc8..12345657a89d 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbexec - debugger control method execution
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index e1b6e54a96ac..44676376a765 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbfileio - Debugger file I/O commands. These can't usually
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index beec446bf94a..b15afc2ef4e0 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dbhistry - debugger HISTORY command
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 861b12c334ab..5191c2c87bf8 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbinput - user front-end to the AML debugger
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index 889d13828e49..629d6ba33476 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbmethod - Debug commands for control methods
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index c9131259f717..57b819270f7f 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbnames - Debugger commands for the acpi namespace
diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index 95ab91b35f29..97ecc9186530 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbobject - ACPI object decode and display
diff --git a/drivers/acpi/acpica/dbstats.c b/drivers/acpi/acpica/dbstats.c
index 3af88e70238c..f9035205a49b 100644
--- a/drivers/acpi/acpica/dbstats.c
+++ b/drivers/acpi/acpica/dbstats.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbstats - Generation and display of ACPI table statistics
diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
index 6db44a5ac786..89a5b2fb9301 100644
--- a/drivers/acpi/acpica/dbtest.c
+++ b/drivers/acpi/acpica/dbtest.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbtest - Various debug-related tests
diff --git a/drivers/acpi/acpica/dbutils.c b/drivers/acpi/acpica/dbutils.c
index 58b039dd7d90..c32de74296bf 100644
--- a/drivers/acpi/acpica/dbutils.c
+++ b/drivers/acpi/acpica/dbutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbutils - AML debugger utilities
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 9dfd693cda3e..276fcd186d8d 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dbxface - AML Debugger external interfaces
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 8a72ff39b5a2..27ee04f7b906 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsargs - Support for execution of dynamic arguments for static
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 90f16c03fd72..def50e90fc4f 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dscontrol - Support for execution control opcodes -
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 691c001591fa..8343aa56cfcd 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d7d56cc600d3..04d92b923e01 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsfield - Dispatcher field routines
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index f73e68090c80..4ea1e7ba7923 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsinit - Object initialization namespace walk
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 3b2ced5ab6c8..0e36ed0fe5d1 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 5393de4dbc4c..60c329b45471 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dsmthdat - control method arguments and local variables
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 25dd034c911d..3d6930947591 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsobject - Dispatcher object management routines
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index fa13086e304c..71a7e8dcb3c9 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 1a33c2f63c84..e0d3750719f1 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dspkginit - Completion of deferred package initialization
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index baf6a1f27605..f2603b96cb6e 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: dsutils - Dispatcher utilities
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 675aaa671012..92dfa988285a 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dswexec - Dispatcher method execution callbacks;
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 5a3709aa6c77..fb5cedd5bcb4 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 277ae080df78..c398b789f1bb 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 7fef0a058393..b3189b776bd2 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dswscope - Scope stack manipulation
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 5e948854f78a..70d9a27997dd 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 8b12e91b8903..521386ca9548 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evevent - Fixed Event handling and dispatch
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index d1a266ebb6ef..badefeb2439c 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evglock - Global Lock support
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 53b52efc7c2b..74a3d5569e27 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 47d8d50aab9b..eed60f235dfb 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 33174496bb0c..041807915447 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evgpeinit - System GPE initialization and update
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 4f8af92dd0cc..013c3aaba35b 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evgpeutil - GPE utilities
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index d9a3b1ca5b9c..294f4ddfa5ba 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evhandler - Support for Address Space handlers
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 723db68626ea..f99d3bb67e18 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 96423b38f240..f66eaf73a66a 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evregion - Operation Region support
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 4e64e58b72ef..092b29da56a4 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 3915ff61412b..3a4c77c42102 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: evsci - System Control Interrupt configuration and
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index da4e45f9f2d8..332796cbaced 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evxface - External interfaces for ACPI events
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 1819737905bf..969bbd8b46b2 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 4be8f6e6976e..62a8c3f82908 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 177f80da1c7d..f3c030efd298 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index 107df9d05fe6..f299d4b856bc 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exconcat - Concatenate-type AML operators
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index da39d578595b..273ad7a24b73 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index b51f20d0978e..a5a14378a0bb 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exconvrt - Object conversion routines
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 64f39274d370..0691353c9967 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: excreate - Named object creation
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index a592bcc5d726..f5214d6f6db4 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 56500b2bedaa..a34064378298 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exdump - Interpreter debug output routines
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 9a55524ed8f4..139feb206264 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exfield - AML execution - field_unit read/write
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index bdd8e6ec3fea..ab2314db90bb 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exfldio - Aml Field I/O
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index e67d3d547990..03da3e0bddc5 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index cc0f9978e461..f9eb4d8653c6 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 3ae2bd8aa3c3..ac731579c4ba 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exnames - interpreter/scanner name load/execute
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 7a6e4c6d9d7b..0dfb104ea7ab 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index ca434470435f..cc39c70e3321 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 3a0559a3f531..16f234352d4b 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index ab502bf27d87..24c993c44095 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 3acfa60d27d9..c4f287d4d62a 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exprep - ACPI AML field prep utilities
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index fc144919e493..c7077ee1b9fc 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 1c6c3d531947..2961fd37b26e 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exresnte - AML Interpreter object resolution
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 029918333e29..93bbcef97de5 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exresolv - AML Interpreter object resolution
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 8127d4046d0b..4314f34b7c1f 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 835ea4b2822a..c11dc04c971a 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exserial - field_unit support for serial address spaces
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 86be6bce1648..b1535a4812e2 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exstore - AML Interpreter object store support
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index a047f7337aee..250b60867d50 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exstoren - AML Interpreter object store support,
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 8d17412085ed..eb6b2b3826ef 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exstorob - AML object store support, store to object
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 41d6f8f7a368..92f2a69d13fe 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exsystem - Interface to OS services
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index 4a6c7fb147d7..4cff5615604d 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: extrace - Support for interpreter execution tracing
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index a1aa89ad8f03..b4b7467b5b88 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: exutils - interpreter/scanner utilities
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index e70f60364bba..60ddd4de017b 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 73f60d735b1e..cd596da043ea 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 98d3662507b4..0f3a8e99bc8e 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index 3bd5ebc9c080..8a4f69ea2247 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: hwpci - Obtain PCI bus, device, and function numbers
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index f62d5d024205..978f495bcfbb 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: hwregs - Read/write access functions for the various ACPI
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index d0d46765c5c1..e1d99e4e93a3 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index c08bbaa956a6..fca2975713ef 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index abbe3042bf3f..882b2e6ed089 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: hwvalid - I/O request validation
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 980ea76106b7..b099945b9273 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index dd70fcb99637..92b4bade9c99 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index a0c1a665dfc1..bc0672ca0228 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsaccess - Top-level functions for accessing ACPI namespace
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 83d26abcf448..6b126b80ef28 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsalloc - Namespace allocation and deletion utilities
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index e00cce28d714..3b1646b28e36 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index b903f70e41bb..9dd3c1637658 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsconvert - Object conversions for objects returned by
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 15bb57e36131..439a7211e339 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsdump - table dumping routines for debug
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 7cbb0786f7cc..81d055d69fd2 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsdump - table dumping routines for debug
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 63748ac699f7..1dd697f505a4 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nseval - Object evaluation, includes control method execution
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 70453eb63373..5a6497cb7af7 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsinit - namespace initialization
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index e89998d823d2..47ff29b092fe 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 19802da865c5..1711e9f984fa 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsnames - Name manipulation and search
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index a4ccacecca53..f8c36ce5d7f4 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsobject - Utilities for objects attached to namespace
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 1e9c70c388ec..72d1bf77a5c1 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsparse - namespace interface to AML parser
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index d7b4f8d2e461..cd03d1f6df95 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index f1c510ca76a3..c471ea25ea14 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 8e5da0c42da2..7e5d26100a76 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 62734b96b745..337f78bbbbab 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsrepair2 - Repair for objects returned by specific
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index f594ab75a5fe..d603732c0f73 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nssearch - Namespace search
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 65b517f92972..1cbab71f0dbb 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index a37d75b5b9be..fce97583584b 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f9d059647cc5..39b20481c14b 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsxfeval - Public interfaces to the ACPI subsystem
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b6534187cd43..553c66ae8105 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 324269481160..9caffdc98e29 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: nsxfobj - Public interfaces to the ACPI subsystem
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 4643c839df7f..2c29fdb6b2e5 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psargs - Parse AML opcode arguments
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 24a57f971c96..8ffe0f0f8c89 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psloop - Main AML parse loop
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 629cafab1930..748ba31a59ca 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psobject - Support for parse objects
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 0abb9b077cb4..a1ac1f0d2dcb 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 479ce3df67f0..b43cb35c43a2 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 42ec8abef626..ecb7aa5b00c7 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psparse - Parser top level AML parse routines
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 822ea96ac048..d3d18654e7f5 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psscope - Parser scope stack management routines
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 313cbfb10ba2..c4cbe84392b1 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 789d75dc40db..c99ec0c8aa5f 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index ac0521014c24..176aa4dbd80b 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index f8df9398e41f..279df1006393 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: psxface - Parser external interfaces
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index f92010e667cd..fdce2883cde5 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsaddr - Address resource descriptors (16/32/64)
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 242daf45e20e..20e059536feb 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rscalc - Calculate stream and list lengths
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index c659b54985a5..1b92efac0090 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rscreate - Create resource lists/tables
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 5b7d7074ce4f..4285537a5b51 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsdump - AML debugger support for resource structures.
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 998a79cc09c2..6776c8902a2c 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsdumpinfo - Tables used to display resource descriptors.
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index ad7465ddfe13..1c5cd68ce1f7 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsinfo - Dispatch and Info tables
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index 687aaed9655a..c5a96ffceda8 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsio - IO and DMA resource descriptors
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index b0d970efa072..0c3c103258be 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsirq - IRQ resource descriptors
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index e46efaa889cd..37a46b98bbbf 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rslist - Linked list utilities
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index 44fa16dde9ba..83ad7bc26909 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsmem24 - Memory resource descriptors
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 6e8e98cf598d..02b82b7155de 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsmisc - Miscellaneous resource descriptors
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 5ab41e9b9039..f9b5223c2364 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsserial - GPIO/serial_bus resource descriptors
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 8c1a68629b75..13f177df7a59 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsutils - Utilities for the resource manager
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index c62be3d91712..0c791d66ed1b 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: rsxface - Public interfaces to the resource manager
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 07af035aa4de..a5130642eb9b 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbdata - Table manager data structure functions
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 4c3ef7cac065..940d763206ec 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbfadt   - FADT table utilities
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 60a772c87f42..f951d68c9d37 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbfind   - find table
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index d36a803f9ff0..ffa8923e5d5f 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbinstal - ACPI table installation and removal
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index acfff3c96d09..68030c638e24 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbprint - Table output utilities
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index adc6e3b0451e..b871a08f29f3 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbutils - ACPI Table utilities
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index de69ec75c5f1..3090355ddbe8 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index c0e34b06f93e..dc3c7c1ba14d 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbxfload - Table load/unload external interfaces
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 27e2e162c351..305bbf27fd85 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 48f55a36e52d..49b5870fd71d 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utaddress - op_region address range check
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index da12b6fec24f..241477dfb28c 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utalloc - local memory allocation routines
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index 9ad2bb93efd3..553f971c76d4 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utascii - Utility ascii functions
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 4193ceb93777..10f709c9974f 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utbuffer - Buffer dump routines
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 6ec2a6e88d3e..224a621b3c44 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utcache - local cache allocation routines
diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index 040e34569ac7..48eb9cddd2a4 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utcksum - Support generating table checksums
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index e4d2f510f91e..1a36d604fecc 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utcopy - Internal to external object translation utilities
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index a31e07400c34..6d089ce3fce6 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utdebug - Debug print/trace routines
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 10482caac3ac..1b1bf154f41d 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e8180099d01f..5f33ee60ec8a 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utdelete - object deletion and reference count utilities
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 918aca7c4db4..a8e8a95eda9d 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: uterror - Various internal error/warning output functions
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index c6cc677912cb..f9a0b2ffaee3 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: uteval - Object evaluation
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index 60fbdcde151b..51d9cb34bd55 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utexcep - Exception code support
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 68b6656cfb1b..1cd3e421def6 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index df09a1a14fb6..5b3e7132c32e 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: uthex -- Hex/ASCII support functions
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index e177229e6a3f..4a52ff464d24 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 79d9412d9b80..07ba008b180f 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utinit - Common ACPI subsystem initialization
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index cf6b931cd570..286d61988578 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utlock - Reader/Writer lock interfaces
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 2c2c6bc1ff3f..a7b35ac6dfc4 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utmath - Integer math support routines
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 8638efacdbf4..4fdd6b4db4c4 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utmisc - common utility procedures
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 2e465e6a0ab6..132512b0ff20 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utmutex - local mutex support
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index a465e5a1d309..ce9cb5102320 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utnonansi - Non-ansi C library functions
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 60513dfab8e4..1866404e569d 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 64e26fb825fd..e5be233ecf60 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utosi - Support for the _OSI predefined control method
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index d3525ef8ed28..a6370a95d777 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utownerid - Support for Table/Method Owner IDs
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index dd1548231803..b130f0af94a2 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utpredef - support functions for predefined names
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 52f41d7acbef..0e4ff97c70c4 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utprint - Formatted printing routines
diff --git a/drivers/acpi/acpica/utresdecode.c b/drivers/acpi/acpica/utresdecode.c
index d801d9069841..31d768c7fdf3 100644
--- a/drivers/acpi/acpica/utresdecode.c
+++ b/drivers/acpi/acpica/utresdecode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utresdecode - Resource descriptor keyword strings
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 86ebd9fb869a..8e27e5f77411 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utresrc - Resource management utilities
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index a2484556a6b5..ec0b9a429044 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utstate - state object support procedures
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index aae71b8c55d2..a005b1c15537 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utstring - Common functions for strings and characters
diff --git a/drivers/acpi/acpica/utstrsuppt.c b/drivers/acpi/acpica/utstrsuppt.c
index 199982a6fb16..36a400072353 100644
--- a/drivers/acpi/acpica/utstrsuppt.c
+++ b/drivers/acpi/acpica/utstrsuppt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utstrsuppt - Support functions for string-to-integer conversion
diff --git a/drivers/acpi/acpica/utstrtoul64.c b/drivers/acpi/acpica/utstrtoul64.c
index 5fde619a8bbd..7eac3968b3d4 100644
--- a/drivers/acpi/acpica/utstrtoul64.c
+++ b/drivers/acpi/acpica/utstrtoul64.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utstrtoul64 - String-to-integer conversion support for both
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index f013fb9c20f8..c5911e0056c7 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index aa8985be9048..d2b46d77a798 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utuuid -- UUID support functions
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index e1d08a14d7a8..bdd117faa1f8 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index a1ed7fced4db..84a91df61454 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utxferror - Various error/warning output functions
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 61f50e0736bb..00371f71f203 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index be24db2544ce..bf672fc3c63e 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*******************************************************************************
  *
  * Module Name: utxfmutex - external AML mutex access functions
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 7823df1c3894..a5bdfba27fc6 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 6bce050f0421..609c101f6313 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acconfig.h - Global configuration constants
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index d7b22c56c131..088ba158301f 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 714d8f265f8a..038bbe2c34dd 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acnames.h - Global names and strings
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index a8d846077727..98ae67d09639 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acoutput.h -- debug output
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index 07e3d6e213c9..37aed2403a05 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index f5bf17fc4e01..19b12d9135ec 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acpiosxf.h - All interfaces to the OS Services Layer (OSL). These
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9557462e0be8..c7802c281fc9 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 0e25ef65a323..274102e6f091 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 606efcb527f3..150c57bfceec 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actbl.h - Basic ACPI Table Definitions
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d824838cb7af..0e73209c4c9a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actbl1.h - Additional ACPI table definitions
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5..5a0ff61248e0 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actbl2.h - ACPI Table Definitions
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 331ecbfdb6d9..ebfa6b1ad05e 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actbl3.h - ACPI Table Definitions
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 00c1eb11d59e..29e4ebdf93ee 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 9ccf5bbaf80e..b927cd99523c 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 1c66cfeeea35..3dc0301b8f5e 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acenv.h - Host and compiler configuration
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index f7797ca6312d..c16b18164280 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acenvex.h - Extra host and compiler configuration
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 31c624568852..e57dfdbbe1bc 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acgcc.h - GCC specific defines, etc.
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
index 89cd8a66b16c..6262c0e2a08d 100644
--- a/include/acpi/platform/acgccex.h
+++ b/include/acpi/platform/acgccex.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9b30bb9ed711..9d66658b9463 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 760e1ded325c..599d504119f2 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
diff --git a/include/acpi/platform/aczephyr.h b/include/acpi/platform/aczephyr.h
index b698ec117064..a1a614bf6db2 100644
--- a/include/acpi/platform/aczephyr.h
+++ b/include/acpi/platform/aczephyr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: aczephyr.h - OS specific defines, etc.
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 6e578b0c28d8..111ebcd091da 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: cmfsize - Common get file size function
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 42735c00ed3c..531c3f4a4756 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: getopt
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 4f9c033e3eea..daf05ceffc56 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index 96d0d52b5424..3319d4c5959f 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: osunixdir - Unix directory access interfaces
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 5f6126be69e0..ac83be4c12a6 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: osunixmap - Unix OSL for file mappings
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 49e28847d7c8..70cfd7bdf630 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: osunixxf - UNIX OSL interfaces
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index eac946be8c7e..23d54099215e 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 72ad7915b04f..8cc97d2081ae 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 0b64324d13de..406a8ec51b22 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: apfiles - File-related functions for acpidump utility
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 8403660e7482..c24dc5b2fb5a 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
  * Module Name: apmain - Main module for the acpidump utility
-- 
2.54.0

