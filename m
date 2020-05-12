Return-Path: <SRS0=zZB4=62=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB2C54E8D
	for <linux-acpi@archiver.kernel.org>; Tue, 12 May 2020 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682CB20836
	for <linux-acpi@archiver.kernel.org>; Tue, 12 May 2020 05:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589262724;
	bh=/s72hXBEtVh97CNJT+5n4ZXc/V+UPmHBVHcaDXRUQC4=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=KNisoMYWh+g6RfkvkMA29Iz06s4Wx3S1s+9zJ4HSoAw94eFQ8rc//BTM0PxfKal8m
	 ZEI4qZly9cnDiksKda2opsFS0n/zUbhoHEHwqhSKYfaVEpGLF2ovqYpP3jhOA3sTtF
	 914j9OogB74Xx5X/F0kgI2ae85QKeC1tSI9Qb3bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgELFwD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgELFwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E1B20769;
        Tue, 12 May 2020 05:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589262723;
        bh=/s72hXBEtVh97CNJT+5n4ZXc/V+UPmHBVHcaDXRUQC4=;
        h=From:To:Cc:Subject:Date:From;
        b=h99wYss8+ssH8BEU/yFXk08Ocs2YOryD3QSkzplXc5ML5lroF50c3Pu4+hqOKiwPt
         Yxo7UDScseg8/36+cLIb/FG+rKwd9p1e4xlxS2HnKNP4+RObsoq6+VghTt31LbuWyC
         MctcVj8u0jvqKb2jqhpp907QrDEoKfP937FAi9rc=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jYNpg-001Yqp-K4; Tue, 12 May 2020 07:52:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] Solve a few issues with intel_pmic_chtdc_ti.c 
Date:   Tue, 12 May 2020 07:51:55 +0200
Message-Id: <cover.1589262490.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While doing some tests with a device that I'm using to work with the
atomisp driver (an Asus T101HA), I noticed some warnings  produced
by the i915 driver.

The first one is that building intel_pmic_chtdc_ti as a module is too
late, as fbcon driver (and i915) will need it earlier.

The second one is that the thermal I2C OpRegion needed by the i915
is not registered.

Those patches address the issues I detected.

Mauro Carvalho Chehab (2):
  ACPI / PMIC: Add i2c address for thermal control
  mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool

 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
 drivers/mfd/Kconfig                     | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.26.2


