Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688338;
	b=WyUdn8nvV/OXhyI+ntTvaaxOiCjWF6OQfxbhh20BjqwP5FQgr35BzfA7LLTlpm4WF5xT
	 Is0pVpEAlOsVD1RkoaQqZmcOlsMUkx3GJrI/Wp0wnwFo6gZtDGuMI2XG4VLSiJYRIdpCZ
	 pyNisyWietDqzOT0H3F5WTGlW+imwmy/C8qlLSbHu5mk1JC1yRxveh7Ry8O1UqSjhkFK/
	 AK8PWcbBM1gwBnG2AvAQGBbdIWyMzJxNznNKqDU8kPOfW/fQ7Kfb1J5XjJ7t7JPRnUbcw
	 IgsxUjis+M78fGWlK5MQAvNVC4HpB5flYvJQRG1QdcL6YgSjg7UPHUr3za3cnhOH5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
	b=mM8BXWRA05+obumRxCX+nlSzbYVeAjnuQvVhC2Eai1KZTXXt95pbkJXVfeuaq8ko9a3+
	 bZZJQkv7iRixMe/cz+4wiku99soRpQlK/ygIrqsQyY4lAq6sr1Qv8Gjfcw2rdBb40qeKG
	 LfnsPIC/yy7RLlG0Y1XePKikTLZ+V3EPcZ6QWk8vCohptZM7hFMV1LIjenNrYTspjG02n
	 Zri/gAB0E9POLbzpKbQ3Zs4DOZ/xYA7FG+twQscUX3nkN7jJGjXpdpPmP+KRjtM4lhWSh
	 CZ2Olpwyg2GjBIL+XGU0pW0wlsT58NlNoOiZUmr8cMSEnEI8+47SJR62CyxcK5JMt3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FL1ZaMku;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41670606A323
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 16:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41670606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FL1ZaMku
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so56697eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688336; x=1793293136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=FL1ZaMkuY3485iIc3ZQCn3sG+fTJWBdV09VwotBgZrc/rZo7Cho79baKAkZAUlJ2JY
         uu/5e9rj05pf3lj3sBw7UBZfpuBp8V08rw+qABCc+IFc7QxBq/C0X9x5iGEsZzPT4YiO
         zrSz/MpcrWnCNgS//YZKHTrYOOfNuhtDXhgdg/TaBAHletiw4lGLDbU0nTmcvzGDYMW7
         q4GnWSZmABXUt9yGZmbyTuUhddJQndmGdbu7IegHeKuwwHH18YRtaACBapikc2uLQlOh
         UjvxsWAClH91Qkx1lCxQCtYyCv+wCXzSGfdY/1596lds0RqodFwXVYChF6kpT9hTg4eG
         iOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688336; x=1793293136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=Ew883FplDaSQe2xw3KRX+ZbisqC3w5bF7wG9c+GUW1rLTUCPskqUeHka9WdKNCQxVd
         LiIfVzLZaEsjT4cewsaDus7KmToGqJ2Bxn6NFmDVtNUmGVDu3R+Ko9qOKD6fV9kZkFVt
         xpVJ4ZnfrRHvVpxoFYXS2GOvLEuADWvSgqMyXlal4/lcQlliHVxbrdW6HB5ObseixwFW
         cM3U+miafy5wPIlIqgXfPgLRD2MAvod60cRhSol6fIebhs+0GWN9e/Tnsl/BWsIEoZbe
         wf2jAVadvzXP3NUujaZepBvcIvj3cQmFSrBDe2QrMhl7e6kRPQwaMMxQlMF0LWlkE+4L
         1Prg==
X-Forwarded-Encrypted: i=1; AKwUvBwuX43TCt8/OZYpbrHbD/dLffohttoSirHCIBmsxhapWki3sRWWuBu3BarBX33bAIkhHmGm2RQmXp1x@vger.kernel.org
X-Gm-Message-State: AFq9FYI2Zqb2iADxoWEBFYhouljDkxqjW/em1mymiSBKCiISMNlRUWji
	v9zwNcu1NekXmdUa1Ev/Ci+O4y7J/pRcTsUK+WCW/TODBCYh5Lu4r6tApxABl8vfq/8HWsRTy3W
	x6Z3dBqzb
X-Gm-Gg: AYBFou36cIoDzN7queDUOTTxJrlIHnMQkSUUg49+x5xYZC8aAmJGUOmL+Dpe2K2AuRG
	lu74mFMll/bhklZvIST0FupTVB8cCekrA1Ub3F6DxMNZvw/V4fqIJaBx1PRLG0S1Zo0ngVvfZ9y
	tXhNwLc0k8jgXJ7RaitBYtDCsYY4OXtSzyYR2H/9nWmO2Q166T+1+GJaocIrv9hZ7vTgrKztUgG
	oTEBwYjzxiY8m9wKIzZbl1xrqP/Pj4V4eveVDUebkI3ft7UZiock9AnDlEqiIxe+BvnFT8146wN
	Ff4Wp/71HScg+hEWklFvrRrpOLsPG6HPwuMzq3P8ZIYv8PD6ELF62uPdlDzFJurCnMf8KbU6C8N
	0Mua8R6nYfLIq5qvaBc2yqIkS8cXv2DZV8hEAb1EcGPQ3Iy7pWyJXQuNSrKyeDbZq4/Za8240ct
	QJv9nen/RbvRRRbGZKGz3tl9VyG43JLLzhaGChsWaVvmBEdrtv58Jvz07xfzx91r4PHIF9AVa19
	OD4HiHSa6+dctbPdKGzTtximCHzjGRqqXWgMKYbuYxEt9aCV+tVNIADkU/8iXvtBQRn+Vs2TYQr
	5eZq0GlrfJ/+Z3FJcBhJn6p3KUDKmTmrQw0=
X-Received: by 2002:a05:701b:204f:20b0:184:329d:eced with SMTP id a92af1059eb24-190a52de3edmr7715048c88.25.1792688336131;
        Thu, 22 Oct 2026 09:58:56 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:55 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Thu, 22 Oct 2026 16:58:41 +0000
Message-ID: <20261022165842.1463451-2-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261022165842.1463451-1-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery.

Add pci=noaer_recovery to retain AER logging while skipping recovery for
uncorrectable errors. Check the option before dispatching either CXL RCH
internal errors or ordinary PCIe errors so CXL driver error callbacks
cannot bypass it. Also skip recovery for errors reported through GHES,
while retaining error logging and releasing error buffers and device
references.

Correctable errors continue to be handled normally. Skipping recovery
avoids its clearing of uncorrectable error status, but does not suppress
Root Port interrupt acknowledgment or change firmware error handling.
The option is AER-specific and does not disable DPC recovery.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
Changes in v3:
- Check the option before both CXL RCH and ordinary PCIe error dispatch.
- Preserve logging, correctable handling, and current GHES cleanup.
- Clarify the AER-only scope and rebase onto PCI next.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-2-yurypm@arista.com/
Review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/aer.c                          | 13 +++++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4b..6047efd3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5118,6 +5118,11 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] Disable Linux AER recovery for
+				uncorrectable errors, including CXL RCH errors,
+				while retaining AER logging. Correctable errors
+				are handled normally. Requires CONFIG_PCIEAER.
+				Does not disable DPC or firmware error recovery.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a62af7320..9ca8d3fbb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6840,6 +6840,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c..ccc6a678c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1337,6 +1337,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1348,6 +1349,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c376c3adb..c41e5e13f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -142,6 +142,7 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_recovery_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -149,6 +150,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_no_aer_recovery(void)
+{
+	pcie_aer_recovery_disable = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
@@ -1338,6 +1344,9 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
+	if (pcie_aer_recovery_disable && info->severity != AER_CORRECTABLE)
+		return;
+
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 }
@@ -1383,15 +1392,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (pdev) {
+		if (pdev && !pcie_aer_recovery_disable) {
 			if (entry.severity == AER_NONFATAL)
 				pcie_do_recovery(pdev, pci_channel_io_normal,
 						 aer_root_reset);
 			else if (entry.severity == AER_FATAL)
 				pcie_do_recovery(pdev, pci_channel_io_frozen,
 						 aer_root_reset);
-			pci_dev_put(pdev);
 		}
+		pci_dev_put(pdev);
 	}
 }
 
-- 
2.51.0

