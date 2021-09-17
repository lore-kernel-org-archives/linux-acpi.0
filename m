Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370AC433EF
	for <linux-acpi@archiver.kernel.org>; Fri, 17 Sep 2021 13:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4476F611C3
	for <linux-acpi@archiver.kernel.org>; Fri, 17 Sep 2021 13:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhIQNf3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 17 Sep 2021 09:35:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240676AbhIQNf2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04D931B;
        Fri, 17 Sep 2021 06:34:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9C333F719;
        Fri, 17 Sep 2021 06:34:05 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 00/14] mailbox: pcc: Add support for PCCT extended PCC subspaces
Date:   Fri, 17 Sep 2021 14:33:43 +0100
Message-Id: <20210917133357.1911092-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Though the series is about adding support for PCCT extended PCC subspaces,
except one patch, remaining are either preparatory or clean up to add
the PCCT extended PCC subspaces. Only patch 12 adds the support of extended
PCC type3/4 subspaces.

The main change affecting your is the change in pcc_mbox_request_channel
to avoid clien driver using con_priv member which is designed for controller
private pointer rather than for client's to use that.

Shared memory region accesses could be consolidated but I am planning to
take that up later as some drivers are using different types of mappings,
yet to figure out on how to consolidate that aspect.

Regards,
Sudeep

v1->v2:
	- Addressed comments from Cristian and added his review tags as
	  provided

Sudeep Holla (14):
  mailbox: pcc: Fix kernel doc warnings
  ACPI: CPPC: Fix kernel doc warnings
  mailbox: pcc: Refactor all PCC channel information into a structure
  mailbox: pcc: Consolidate subspace interrupt information parsing
  mailbox: pcc: Consolidate subspace doorbell register parsing
  mailbox: pcc: Add pcc_mbox_chan structure to hold shared memory region info
  mailbox: pcc: Use PCC mailbox channel pointer instead of standard
  mailbox: pcc: Rename doorbell ack to platform interrupt ack register
  mailbox: pcc: Add PCC register bundle and associated accessor functions
  mailbox: pcc: Avoid accessing PCCT table in pcc_send_data and pcc_mbox_irq
  mailbox: pcc: Drop handling invalid bit-width in {read,write}_register
  mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)
  mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe
  ACPI/PCC: Add myself as maintainer for PCC mailbox driver

 MAINTAINERS                            |   6 +
 drivers/acpi/cppc_acpi.c               |  50 +--
 drivers/hwmon/xgene-hwmon.c            |  35 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c |  33 +-
 drivers/mailbox/pcc.c                  | 598 +++++++++++++++----------
 include/acpi/pcc.h                     |  21 +-
 6 files changed, 436 insertions(+), 307 deletions(-)

--
2.25.1

