Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A9C433B4
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2348961406
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhDVVrw (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 22 Apr 2021 17:47:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVVrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:47:51 -0400
IronPort-SDR: cQjrM/f+uLMWloLseWQGiakuo8FZ0ORNLGzQXxt32i1QA6XBCtJZBlJGVUHVVvUXDo1hl7nXWp
 sdwMKhM7Sc+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281306569"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281306569"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:16 -0700
IronPort-SDR: qaoU98k/mhRZoQ1fRosIOisWuC5+QkRFINfykCIsfg670jutDn024bnoGUHyLMG6SqJCwdbSLb
 9LkPHOlIgvLA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455965113"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:15 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 0/3] Add multiprocessor wake-up support
Date:   Thu, 22 Apr 2021 14:47:05 -0700
Message-Id: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add multiprocessor wakeup support using MADT ACPI table for x86
platforms. It uses mailbox based mechanism to wake up the APs. You
can get more details about the ACPI table and mailbox protocol in
Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
Extensions (Intel TDX) specification document (sec 4.1)

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Changes since v1:
 * Removed signoff from Rob and Erik.

Kuppuswamy Sathyanarayanan (3):
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
  ACPI/table: Print MADT Wake table information
  x86/acpi, x86/boot: Add multiprocessor wake-up support

 arch/x86/include/asm/apic.h     |  3 ++
 arch/x86/kernel/acpi/boot.c     | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c |  8 +++++
 arch/x86/kernel/apic/probe_64.c |  8 +++++
 drivers/acpi/tables.c           | 11 +++++++
 include/acpi/actbl2.h           | 14 +++++++++
 6 files changed, 100 insertions(+)

-- 
2.25.1

