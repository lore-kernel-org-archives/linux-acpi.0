Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA422C10F14
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9A20857
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDHUrR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:47:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:33548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbfDHUrR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="314181125"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2019 13:47:15 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 0/8] ACPICA release 20190329 and 20190405
Date:   Mon,  8 Apr 2019 13:36:51 -0700
Message-Id: <20190408203659.4207-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since ACPICA had a release within one week of each other, this patch-set
contains both releases. Notable items include a patch to remove a
namespace node from the global address list correctly. Other than that,
there are several renamings for clarity.


Bob Moore (5):
  ACPICA: Rename nameseg copy macro for clarity
  ACPICA: Rename nameseg compare macro for clarity
  ACPICA: Rename nameseg length macro/define for clarity
  ACPICA: Update version to 20190329
  ACPICA: Update version to 20190405

Erik Schmauss (3):
  ACPICA: Namespace: remove address node from global list after method
    termination
  ACPICA: utilities: fix spelling of PCC to platform_comm_channel
  ACPICA: Namespace: add check to avoid null pointer dereference

 arch/x86/boot/compressed/acpi.c               |  2 +-
 drivers/acpi/acpica/aclocal.h                 |  4 +-
 drivers/acpi/acpica/dbexec.c                  |  2 +-
 drivers/acpi/acpica/dbnames.c                 |  2 +-
 drivers/acpi/acpica/dsinit.c                  |  2 +-
 drivers/acpi/acpica/evgpeinit.c               |  4 +-
 drivers/acpi/acpica/exnames.c                 |  6 +--
 drivers/acpi/acpica/nsaccess.c                |  2 +-
 drivers/acpi/acpica/nsalloc.c                 |  4 ++
 drivers/acpi/acpica/nsdump.c                  |  2 +-
 drivers/acpi/acpica/nsinit.c                  |  4 +-
 drivers/acpi/acpica/nsnames.c                 |  8 ++--
 drivers/acpi/acpica/nsobject.c                |  4 ++
 drivers/acpi/acpica/nsparse.c                 |  2 +-
 drivers/acpi/acpica/nsrepair.c                |  2 +-
 drivers/acpi/acpica/nsrepair2.c               |  4 +-
 drivers/acpi/acpica/nsutils.c                 | 14 +++---
 drivers/acpi/acpica/nsxfname.c                |  4 +-
 drivers/acpi/acpica/psargs.c                  |  8 ++--
 drivers/acpi/acpica/rsxface.c                 |  8 ++--
 drivers/acpi/acpica/tbdata.c                  |  3 +-
 drivers/acpi/acpica/tbfind.c                  | 20 ++++----
 drivers/acpi/acpica/tbinstal.c                |  2 +-
 drivers/acpi/acpica/tbprint.c                 | 10 ++--
 drivers/acpi/acpica/tbutils.c                 |  6 +--
 drivers/acpi/acpica/tbxface.c                 |  4 +-
 drivers/acpi/acpica/tbxfload.c                | 15 +++---
 drivers/acpi/acpica/utascii.c                 |  2 +-
 drivers/acpi/acpica/utdecode.c                |  4 +-
 drivers/acpi/acpica/utmisc.c                  |  8 ++--
 drivers/acpi/acpica/utpredef.c                |  4 +-
 drivers/acpi/acpica/utstring.c                |  6 +--
 drivers/acpi/scan.c                           |  2 +-
 drivers/acpi/sysfs.c                          | 14 +++---
 drivers/acpi/tables.c                         |  4 +-
 include/acpi/acpixf.h                         |  2 +-
 include/acpi/actbl.h                          |  4 +-
 include/acpi/actypes.h                        | 12 ++---
 .../os_specific/service_layers/oslinuxtbl.c   | 48 +++++++++----------
 tools/power/acpi/tools/acpidump/apdump.c      |  8 ++--
 tools/power/acpi/tools/acpidump/apfiles.c     |  8 ++--
 41 files changed, 142 insertions(+), 132 deletions(-)

-- 
2.17.2

