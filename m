Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167454611CF;
	Wed, 27 May 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905505; cv=none; b=UxMN93tRh6/jrGzNa/FeLswKw/Nr9HcD/NPax2uMoL/df1AJ5V2s4JG2R93zH7otQ9QGBb72UE/VPWguyb7tkixvmUdpIPxpTSMbmF2DKIQ2zewq1hvKsNNf2ig/kGQfaL3e6ziojl5TCbeNNZBjC+se7nFo16ylfAResNaNU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905505; c=relaxed/simple;
	bh=WAk3pm+A1C+7FQ8Sr2Z0mkw6ttiVL0bb6tHbscMt/0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOwMWi7RlgCJCi+qUmVh0Dd+obFKpWVJRaGUunMd6r+6s+V1FWmPUEMU9e6XpbLSg8MNlg6DcUeHwlEPCxsEd4WJbtweevzYmMowUBDva7+ABG+6DFffNOf9lg2AAul02jXrr4XeU+QMmePtCNBXYVPUufQIXyYOHJuKAXWLzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxO9+mbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxO9+mbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500651F000E9;
	Wed, 27 May 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905500;
	bh=ufZvj9JRdtx728BxztWqPN9kwmM/MkEAkFCtZaOdQ8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UxO9+mbkQSVo7kcCXlGXEA9NszxEDJuYP2npR45sV65ziinLN14mlPOceAe8mDEPN
	 c5J99R2vYeaqdXsURt2aTyAt+Y0+QDLBdJVsDNFoPIDz69TcEjvz00kc4MmNG9oYy7
	 z6OXdTRZk7LwthNYcadzlVuwyOq65vlpxiShYfTBKkFpjVVd59HtAgQm+BThbK6+Zo
	 0ewZCztKJS1Z2NmQJ/hEz7EPd7oBbrQSAFfykHJ9OtDUGw34NOmfm1dbLzxpg025YA
	 fBAEMbPDG1BxjVz1VfdmFdw8aNC9Wj7q1KmhUrfE6QEAemuE3Af68qNrM5XdnQMRuR
	 PhZs+GyYL+69Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 24/27] ACPICA: Update the copyright year to 2026
Date: Wed, 27 May 2026 20:08:02 +0200
Message-ID: <4379132.1IzOArtZ34@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

Update copyright notices in all ACPICA files.

Link: https://github.com/acpica/acpica/commit/9def02549a9c
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acapps.h                             | 4 ++--
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
 drivers/acpi/acpica/dbhistry.c                           | 2 +-
 drivers/acpi/acpica/dsargs.c                             | 2 +-
 drivers/acpi/acpica/dscontrol.c                          | 2 +-
 drivers/acpi/acpica/dsdebug.c                            | 2 +-
 drivers/acpi/acpica/dsfield.c                            | 2 +-
 drivers/acpi/acpica/dsinit.c                             | 2 +-
 drivers/acpi/acpica/dsmethod.c                           | 2 +-
 drivers/acpi/acpica/dsobject.c                           | 2 +-
 drivers/acpi/acpica/dsopcode.c                           | 2 +-
 drivers/acpi/acpica/dspkginit.c                          | 2 +-
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
 drivers/acpi/acpica/hwsleep.c                            | 2 +-
 drivers/acpi/acpica/hwtimer.c                            | 2 +-
 drivers/acpi/acpica/hwvalid.c                            | 2 +-
 drivers/acpi/acpica/hwxface.c                            | 2 +-
 drivers/acpi/acpica/hwxfsleep.c                          | 2 +-
 drivers/acpi/acpica/nsarguments.c                        | 2 +-
 drivers/acpi/acpica/nsconvert.c                          | 2 +-
 drivers/acpi/acpica/nsdump.c                             | 2 +-
 drivers/acpi/acpica/nsdumpdv.c                           | 2 +-
 drivers/acpi/acpica/nsinit.c                             | 2 +-
 drivers/acpi/acpica/nsload.c                             | 2 +-
 drivers/acpi/acpica/nsparse.c                            | 2 +-
 drivers/acpi/acpica/nspredef.c                           | 2 +-
 drivers/acpi/acpica/nsprepkg.c                           | 2 +-
 drivers/acpi/acpica/nsrepair.c                           | 2 +-
 drivers/acpi/acpica/nsrepair2.c                          | 2 +-
 drivers/acpi/acpica/nsutils.c                            | 2 +-
 drivers/acpi/acpica/nswalk.c                             | 2 +-
 drivers/acpi/acpica/nsxfname.c                           | 2 +-
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
 drivers/acpi/acpica/uteval.c                             | 2 +-
 drivers/acpi/acpica/utglobal.c                           | 2 +-
 drivers/acpi/acpica/uthex.c                              | 2 +-
 drivers/acpi/acpica/utids.c                              | 2 +-
 drivers/acpi/acpica/utinit.c                             | 2 +-
 drivers/acpi/acpica/utlock.c                             | 2 +-
 drivers/acpi/acpica/utobject.c                           | 2 +-
 drivers/acpi/acpica/utosi.c                              | 2 +-
 drivers/acpi/acpica/utpredef.c                           | 2 +-
 drivers/acpi/acpica/utprint.c                            | 2 +-
 drivers/acpi/acpica/uttrack.c                            | 2 +-
 drivers/acpi/acpica/utuuid.c                             | 2 +-
 drivers/acpi/acpica/utxface.c                            | 2 +-
 drivers/acpi/acpica/utxfinit.c                           | 2 +-
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
 175 files changed, 176 insertions(+), 176 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index d7d4649ce66f..16e7bffef798 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
@@ -17,7 +17,7 @@
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
-#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2025 Intel Corporation"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2026 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_WIDTH          " (64-bit version)"
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 662231f4f881..b1cf926ebace 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -3,7 +3,7 @@
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index 24998f2d7539..22bd6712831d 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 91241bd6917a..09ab8b3db7ed 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -3,7 +3,7 @@
  *
  * Name: acdebug.h - ACPI/AML debugger
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 5d48a344b35f..f6208722503b 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -3,7 +3,7 @@
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index b40fb3a5ac8a..ccdc3725c773 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -3,7 +3,7 @@
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index c8a750d2674c..b6e31517650e 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -3,7 +3,7 @@
  *
  * Name: acglobal.h - Declarations for global variables
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6aec56c65fa0..78323df00ceb 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -3,7 +3,7 @@
  *
  * Name: achware.h -- hardware specific interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 1ee6ac9b2baf..a62a4e9e23d6 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -3,7 +3,7 @@
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index cbf09fb08d35..1ecc700f6e88 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -3,7 +3,7 @@
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 4e9402c02410..3a7b6dbcdf9d 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -3,7 +3,7 @@
  *
  * Name: acmacros.h - C macros for the entire subsystem.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 13f050fecb49..b5830e73ca10 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -3,7 +3,7 @@
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 6ffcc7a0a0c2..9a82e4f734ba 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -3,7 +3,7 @@
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index a2a9e51d7ac6..d8a0beb0eaed 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -3,7 +3,7 @@
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 65a15dee092b..5393a11bc924 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 07d5790d09f8..2208dc7aff8d 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -3,7 +3,7 @@
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index e8a92be5adae..c3dfa92a89a7 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -3,7 +3,7 @@
  *
  * Name: acresrc.h - Resource Manager function prototypes
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index e690f604cfa0..5c8c14f55faa 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -3,7 +3,7 @@
  *
  * Name: acstruct.h - Internal structs
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index ebef72bf58d0..1334f8643f76 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -3,7 +3,7 @@
  *
  * Name: actables.h - ACPI table management
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 3990d509bbab..9a18cdbfd60f 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -3,7 +3,7 @@
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index c5b544a006c5..663c6146d6e2 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -5,7 +5,7 @@
  *                   Declarations and definitions contained herein are derived
  *                   directly from the ACPI specification.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 54d6e51e0b9a..2c725680590b 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -3,7 +3,7 @@
  *
  * Module Name: amlresrc.h - AML resource descriptors
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index 554ae35108bd..beec446bf94a 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dbhistry - debugger HISTORY command
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index e2f00c54cb36..8a72ff39b5a2 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -4,7 +4,7 @@
  * Module Name: dsargs - Support for execution of dynamic arguments for static
  *                       objects (regions, fields, buffer fields, etc.)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index c1f79d7a2026..90f16c03fd72 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -4,7 +4,7 @@
  * Module Name: dscontrol - Support for execution control opcodes -
  *                          if/else/while/return
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 274b74255551..691c001591fa 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index df132c9089c7..d7d56cc600d3 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsfield - Dispatcher field routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 57cd9e2d1109..f73e68090c80 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsinit - Object initialization namespace walk
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 08bfe8303083..3b2ced5ab6c8 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 1bf7eec49899..25dd034c911d 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsobject - Dispatcher object management routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 5699b0872848..fa13086e304c 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 1ed2386fab82..1a33c2f63c84 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dspkginit - Completion of deferred package initialization
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 5c5c6d8a4e48..675aaa671012 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -4,7 +4,7 @@
  * Module Name: dswexec - Dispatcher method execution callbacks;
  *                        dispatch to interpreter.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 666419b6a5c6..5a3709aa6c77 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index bfc54c914757..277ae080df78 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 375a8fa43d9d..7fef0a058393 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswscope - Scope stack manipulation
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 02aaddb89df9..5e948854f78a 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 6cdd39c987b8..8b12e91b8903 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evevent - Fixed Event handling and dispatch
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index df2a4ab0e0da..d1a266ebb6ef 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evglock - Global Lock support
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index ba65b2ea49b2..53b52efc7c2b 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index fadd93caf1d5..47d8d50aab9b 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index eb769739420e..33174496bb0c 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeinit - System GPE initialization and update
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index d15b1d75c8ec..4f8af92dd0cc 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeutil - GPE utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index f16c1148e602..d9a3b1ca5b9c 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evhandler - Support for Address Space handlers
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 04a23a6c3bb1..723db68626ea 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index b6198f73c81d..96423b38f240 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evregion - Operation Region support
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index b03952798af5..4e64e58b72ef 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 86a8d41c079c..da4e45f9f2d8 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxface - External interfaces for ACPI events
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 4b052908d2e7..1819737905bf 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 60dacec1b121..bf739715c3db 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index bccc672c934c..177f80da1c7d 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -4,7 +4,7 @@
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
  *                         Address Spaces.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index c248c9b162fa..107df9d05fe6 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconcat - Concatenate-type AML operators
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 894695db0cf9..da39d578595b 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index fded9bfc2436..b51f20d0978e 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconvrt - Object conversion routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 052c69567997..64f39274d370 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: excreate - Named object creation
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 81a07a52b73c..a592bcc5d726 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index d8aeebaab70a..56500b2bedaa 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdump - Interpreter debug output routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index ced3ff9d0a86..9a55524ed8f4 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfield - AML execution - field_unit read/write
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 0771934c0455..bdd8e6ec3fea 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfldio - Aml Field I/O
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 07cbac58ed21..e67d3d547990 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 1fa013197fcf..cc0f9978e461 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 76ab73c37e90..3ae2bd8aa3c3 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exnames - interpreter/scanner name load/execute
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 6ac7e0ca5c9d..7a6e4c6d9d7b 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index a94fa4d70e99..ca434470435f 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 2790bf1a12e7..3a0559a3f531 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index cb078e39abf7..ab502bf27d87 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 1b1a006e82de..3acfa60d27d9 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exprep - ACPI AML field prep utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index a390a1c2b0ab..fc144919e493 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index dd83631090fc..1c6c3d531947 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresnte - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 4589de3f3012..029918333e29 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresolv - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 782ee353a709..8127d4046d0b 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 6d2581ec22ad..835ea4b2822a 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exserial - field_unit support for serial address spaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index cbc42207496d..86be6bce1648 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstore - AML Interpreter object store support
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 0470b2639831..a047f7337aee 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -4,7 +4,7 @@
  * Module Name: exstoren - AML Interpreter object store support,
  *                        Store to Node (namespace object)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 5b168fbc03e8..8d17412085ed 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstorob - AML object store support, store to object
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 7f843c9d8a06..41d6f8f7a368 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exsystem - Interface to OS services
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index 36934d4f26fb..4a6c7fb147d7 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -3,7 +3,7 @@
  *
  * Module Name: extrace - Support for interpreter execution tracing
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index cc10c0732218..a1aa89ad8f03 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exutils - interpreter/scanner utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index a1e1fa787566..e70f60364bba 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 631fd8e2b774..73f60d735b1e 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -4,7 +4,7 @@
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                    extended FADT-V5 sleep registers.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 386f4759c317..98d3662507b4 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 87d78bef6323..d0d46765c5c1 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -4,7 +4,7 @@
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                   original/legacy sleep/PM registers.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index a5e0bccae6a4..c08bbaa956a6 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -3,7 +3,7 @@
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 496fd9e49f0b..abbe3042bf3f 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwvalid - I/O request validation
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 847cd1b2493d..980ea76106b7 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 9aabe30416da..dd70fcb99637 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -3,7 +3,7 @@
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 366d54a1d157..e00cce28d714 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index f05a92b88642..b903f70e41bb 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -4,7 +4,7 @@
  * Module Name: nsconvert - Object conversions for objects returned by
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 6dc20486ad51..15bb57e36131 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index d5b16aaec233..7cbb0786f7cc 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 03373e7f7978..70453eb63373 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsinit - namespace initialization
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 6ec4c646fff7..e89998d823d2 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 959e6379bc4c..1e9c70c388ec 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsparse - namespace interface to AML parser
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 81995ee48c49..d7b4f8d2e461 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index c32770570120..f1c510ca76a3 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index accfdcfb7e62..8e5da0c42da2 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 8dbb870f40d2..62734b96b745 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -4,7 +4,7 @@
  * Module Name: nsrepair2 - Repair for objects returned by specific
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 49cc07e2ac5a..65b517f92972 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -4,7 +4,7 @@
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
  *                        parents and siblings and Scope manipulation
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 5670ff5a43cd..a37d75b5b9be 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b6895a48ae68..fabae9b08e31 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -4,7 +4,7 @@
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
  *                         ACPI Namespace oriented interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 064652d11d9a..cafd54fb5868 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psargs - Parse AML opcode arguments
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 35111ff2526b..e012495e2267 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psloop - Main AML parse loop
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 496a1c1d5b0b..629cafab1930 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psobject - Support for parse objects
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index bf6103986f48..0abb9b077cb4 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 532ea307a675..479ce3df67f0 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 55a416e56fd8..d9e4f33b6909 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psparse - Parser top level AML parse routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index c4e4483f0a0b..822ea96ac048 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psscope - Parser scope stack management routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 5a285d3f2cdb..313cbfb10ba2 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index ada1dc304d25..789d75dc40db 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index a6a6e969e498..ac0521014c24 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index d480de075a90..f8df9398e41f 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psxface - Parser external interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 5b98e09fff76..07af035aa4de 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbdata - Table manager data structure functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 80d3a39a82d7..4c3ef7cac065 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfadt   - FADT table utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index d71a73216380..60a772c87f42 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfind   - find table
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ee9b85bc238b..d36a803f9ff0 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbinstal - ACPI table installation and removal
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index e5631027f7f1..acfff3c96d09 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbprint - Table output utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index fa64851c7b62..adc6e3b0451e 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbutils - ACPI Table utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index a8f07d2641b6..de69ec75c5f1 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 2a17c60a9a39..c0e34b06f93e 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfload - Table load/unload external interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 961577ba9486..27e2e162c351 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index c673d6c95e0a..48f55a36e52d 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utaddress - op_region address range check
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 2418a312733a..da12b6fec24f 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utalloc - local memory allocation routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index 259c28d3fecd..9ad2bb93efd3 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utascii - Utility ascii functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index f6e6e98e9523..4193ceb93777 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utbuffer - Buffer dump routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index cabec193febb..6ec2a6e88d3e 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcache - local cache allocation routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index e6f6030b3a3f..040e34569ac7 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcksum - Support generating table checksums
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 9ecf5c3f49ba..e4d2f510f91e 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcopy - Internal to external object translation utilities
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 9f197e293c7e..a31e07400c34 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdebug - Debug print/trace routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index b82130d1a8bc..10482caac3ac 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index abc6583ed369..c6cc677912cb 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uteval - Object evaluation
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 97c55a113bae..68b6656cfb1b 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 8cd050e9cad5..df09a1a14fb6 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uthex -- Hex/ASCII support functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index eb88335dea2c..e177229e6a3f 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 4bef97e8223a..79d9412d9b80 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utinit - Common ACPI subsystem initialization
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 123dbcbc60bc..cf6b931cd570 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utlock - Reader/Writer lock interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 8362204b57b5..60513dfab8e4 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 88d04183ad0a..64e26fb825fd 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utosi - Support for the _OSI predefined control method
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index d9bd80e2d32a..dd1548231803 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utpredef - support functions for predefined names
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 423d10569736..52f41d7acbef 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utprint - Formatted printing routines
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index a99c4c9e3d39..f013fb9c20f8 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index 0682554934ca..aa8985be9048 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utuuid -- UUID support functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 56942b5f026b..e1d08a14d7a8 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index c1702f8fba67..61f50e0736bb 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index cbc9aeabcd99..7823df1c3894 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -3,7 +3,7 @@
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 521d4bfa6ef0..6bce050f0421 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -3,7 +3,7 @@
  *
  * Name: acconfig.h - Global configuration constants
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index a2db36d18419..d7b22c56c131 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -3,7 +3,7 @@
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index cb6a4dcc4e8e..714d8f265f8a 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -3,7 +3,7 @@
  *
  * Name: acnames.h - Global names and strings
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 3584f33e352c..a8d846077727 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -3,7 +3,7 @@
  *
  * Name: acoutput.h -- debug output
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index 92bf80937e5f..07e3d6e213c9 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -3,7 +3,7 @@
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 65c5737b6286..f5bf17fc4e01 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -5,7 +5,7 @@
  *                    interfaces must be implemented by OSL to interface the
  *                    ACPI components to the host operating system.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 49d1749f30bb..7719597c05ef 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -3,7 +3,7 @@
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 38a19b1d19ac..0e25ef65a323 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -3,7 +3,7 @@
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 8a67d4ea6e3f..606efcb527f3 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl.h - Basic ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index f72e00517eb3..d824838cb7af 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl1.h - Additional ACPI table definitions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 33b10fe3cf35..baef525367b5 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl2.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 7ca456e88377..331ecbfdb6d9 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl3.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 137e1e65cdf4..00c1eb11d59e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -3,7 +3,7 @@
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index ccc536f4bbb5..9ccf5bbaf80e 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -3,7 +3,7 @@
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index a11fa83955f8..1c66cfeeea35 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -3,7 +3,7 @@
  *
  * Name: acenv.h - Host and compiler configuration
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 8ffc4e1c87cf..f7797ca6312d 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -3,7 +3,7 @@
  *
  * Name: acenvex.h - Extra host and compiler configuration
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 8e4cf2f6b383..31c624568852 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -3,7 +3,7 @@
  *
  * Name: acgcc.h - GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
index 4a3c019a4d03..89cd8a66b16c 100644
--- a/include/acpi/platform/acgccex.h
+++ b/include/acpi/platform/acgccex.h
@@ -3,7 +3,7 @@
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index edbbc9061d1e..9b30bb9ed711 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 73265650f46b..aeb74e2f9d4f 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aczephyr.h b/include/acpi/platform/aczephyr.h
index 03d9a4a39c80..b698ec117064 100644
--- a/include/acpi/platform/aczephyr.h
+++ b/include/acpi/platform/aczephyr.h
@@ -3,7 +3,7 @@
  *
  * Module Name: aczephyr.h - OS specific defines, etc.
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index af0e558f231c..6e578b0c28d8 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -3,7 +3,7 @@
  *
  * Module Name: cmfsize - Common get file size function
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 3d63626d80e7..42735c00ed3c 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: getopt
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index de93067a5da3..4f9c033e3eea 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -3,7 +3,7 @@
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index b9bb83116549..96d0d52b5424 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixdir - Unix directory access interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index b93ebc9371a5..5f6126be69e0 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixmap - Unix OSL for file mappings
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 36f27491713c..49e28847d7c8 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixxf - UNIX OSL interfaces
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index fe0d23c4f2ed..eac946be8c7e 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 7a6223aa703c..72ad7915b04f 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index d6b8a201480b..0b64324d13de 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apfiles - File-related functions for acpidump utility
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 9f3850e3af5b..8403660e7482 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apmain - Main module for the acpidump utility
  *
- * Copyright (C) 2000 - 2025, Intel Corp.
+ * Copyright (C) 2000 - 2026, Intel Corp.
  *
  *****************************************************************************/
 
-- 
2.51.0




