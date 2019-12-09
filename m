Return-Path: <SRS0=1bs7=Z7=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD0BC2D0C5
	for <linux-acpi@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFAD24654
	for <linux-acpi@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tts/uxwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLISMB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:12:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLISMA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 13:12:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so17304796wru.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2019 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
        b=Tts/uxwAulwDWx38JQ7vQN1vchjW9BMQPwqFcz5u8er0ybt0fOUvBHt+WEAB24gXyc
         BlO6xJwA59upCQs0IseN693yMmNMgDbbFgWrWiT8ZWofkwrA7Seq9O/D4Gx//cyDdaGE
         /guIbq5MoYH70/5n63vUCderClZlhJs3YBa2U9WpDRuoNG3S47hAE8+Ww4p9KU6i+ziJ
         sceo5n1ghS7WbisS3mMyOWUi5Kf2+viwAkPdhnJOYSbUXUfLBHgRWi46jnVUHnae9E52
         Wr8TWOQ6BMPwQ+bvP0D1ypo0U6Cun3Y1noijEKy7UPoDC+Idhr8iP2SN8THAoGBBnKww
         bVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
        b=INx8aihpZviY914EnDf62PNXuJeu4n41JNvNDdzS3GRtdK+UL38Vn0gYL5NGYxSIUk
         xX2F3jDii2UTeYGjXnjy2DUl1LkljtcEgA286MqlAgohIslxDQguOr7YcQ6Rn6aDwJmN
         jnfXz3AcAd7aZbHCZHC+JQPunkPoJDajZ0IZgfCFclIgHuLF/dehosG6uCDagkdO+oUs
         jH8EflqoxI2DT5V5eWcmvso0IitDwSYBSrwVCuephUt4X+PelZf2tbfD1Yx9olmGY8H5
         lCHAP/9SB6pucqy06V5rVgBmn35GrrEPwL8HQYts33vURM8ZL4fxhW/B9DLQJt6+j417
         ZI/w==
X-Gm-Message-State: APjAAAVpK1AWkxqqiFXYfok45TdmUAGQzEEQdEVgmZzlqAUcJ0oi1fyy
        onqKho+p1fbhI3XFmBzcY3b8hQ==
X-Google-Smtp-Source: APXvYqwd75VErNxunler74D2aYIuUwxtIPPyshTDCbkZm56YpyIMcPHPAkjo50SdxP2In7GjOAaXhw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr3704624wro.264.1575915118236;
        Mon, 09 Dec 2019 10:11:58 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:11:57 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v3 02/13] dt-bindings: document PASID property for IOMMU masters
Date:   Mon,  9 Dec 2019 19:05:03 +0100
Message-Id: <20191209180514.272727-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.0

