Return-Path: <SRS0=RODi=2H=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BEC43603
	for <linux-acpi@archiver.kernel.org>; Tue, 17 Dec 2019 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3512072D
	for <linux-acpi@archiver.kernel.org>; Tue, 17 Dec 2019 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLQTzA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:55:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:56006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLQTzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:55:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217624414"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 11:54:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/5] ACPICA version 20191213 patches
Date:   Tue, 17 Dec 2019 11:35:18 -0800
Message-Id: <20191217193523.20204-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset contains a linux-ized patchset of the 20191213 release of
ACPICA. Notable patches include Maximilan Luz's change to the AML
interpreter to always treat buffer fields created from the ASL
CreateField() operator as buffers rather than treating it as an integer
if the buffer field is small enough to fit an integer. Other than that,
there is a disassembler change to properly disassemble references to
buffer fields that share the same namesegment as a method.

This patchset is also available at the following link:
https://github.com/SchmErik/linux/tree/20191213

Bob Moore (1):
  ACPICA: Update version to 20191213

Colin Ian King (1):
  ACPICA: debugger: fix spelling mistake "adress" -> "address"

Erik Kaneda (2):
  ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
  ACPICA: acpisrc: add unix line ending support for non-windows build

Maximilian Luz (1):
  ACPICA: Dispatcher: always generate buffer objects for ASL
    create_field() operator

 drivers/acpi/acpica/acobject.h |  3 ++-
 drivers/acpi/acpica/dbinput.c  |  2 +-
 drivers/acpi/acpica/dsfield.c  |  2 +-
 drivers/acpi/acpica/dsopcode.c |  2 ++
 drivers/acpi/acpica/dswload.c  | 21 +++++++++++++++++++++
 drivers/acpi/acpica/exfield.c  | 10 ++++++++--
 include/acpi/acpixf.h          |  2 +-
 include/acpi/platform/acenv.h  | 11 +++++++++++
 8 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.21.0

