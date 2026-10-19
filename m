Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421680;
	b=JX7UyjLHJTtSUj22dF+PSAJ+SJ3MvkdxPMkSfX9+oEBEEAfvJV3Il4qDKQzZYWQn3yXB
	 KWmtqsRBcEhTEQWLaV7uGKtm8Xv1BEoxwl98GL8SeEu4NtOJWu0OKdYv8MnTsGi4FLUHE
	 kPkO5SJG3bN8neoOR0KyfNcJ99ZjkgxukpDE1LRwJvfIClfa6JVZFsGsGh/0558FSqMf0
	 Q6LnbvtPMtl3igo8p/ngetAxvSdsGhyTK7bJBl4ybFrdsTZl+O07DYtB8mF3pjC2gDBPd
	 AoL+xTycFm7k1RxVBxMhoKI+T1WXiop5U9udwXV3ULyHqTw4RFT76HT00n/eueqwzWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421680;
	h=Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature;
	bh=yI83/ArYiBednuYDhDDK5tkbGnV2CTH9oPaivzd6scQ=;
	b=Ka8tIAP3HQ7Q6DFsrxr9X8A1+zb+derSlUT4mmowxblTwUFc80J/IknIkxUfPUGzHvH4
	 s7/+wSZJDB6mD9kqrHs5M0WWoei2iCXVlRD7sp71rvjmf+jPZKjO07+uZaY/rCCQUbxln
	 fgHLEBoLIOaFoVNQNw858D55CAHNerfJi+0H7FcgdNB42NyTduEJt80CSe9qHM3CfNS/4
	 KLHKCwN6IqKqAj1FQspz8PM96cJLTAV/pQIXXVd2+U3220M40r1Z6GaZTBsFKvB6ddWmO
	 RHrKA0FYO1B9Imefb00T9LzpZGBG0Ly92bMkHhDZ4hfgSq1KRiu7Ym39sAwVT2Ft4EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=OebpuDV2;
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A867606DA7D
	for <linux-acpi.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=OebpuDV2
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037C3F8891
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421680; cv=none; b=dMqdlk1A7S0GLT9o9Y+njeBICSPEh/FpfOgnI5YzupInxgfBbLZJcY80v5ugUCErE/vnrHqG893NeNmN1hlaN70RvSyEVcZOVCp18kC9XQ0G0DdWDc/7QAvbnSk59HpwelNNdf/dnCR5OobW2RURH/YletFGEPCpVwzz/uOaZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421680; c=relaxed/simple;
	bh=uxYa3boZYgV/MiLGouZGnYcxV5GzjIBtjWV3FVili4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syWPFP7LC/tSe4e/IO6ELktng2nB6CKEIRJaHUtbn7oTsHnRi0wES3I483+9gwglhpONDDggYeVe/1Nmz+9Q3I0JjNtIYMyEyZYXwTCIeMbLD5WPSoGr0qOXNOIHquYspFG1pbo9AH53oyhAuum+F0uFH70Y1EvgmXAQrZLi5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=OebpuDV2; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 81D1F61158
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:54:36 +0200 (CEST)
Received: (qmail 28400 invoked by uid 990); 19 Oct 2026 14:54:36 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 16:54:36 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: leonard@lausen.nl,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Ivan Hu <ivan.hu@canonical.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ACPI: fan: Ignore broken _FST on Samsung Galaxy Book 930XDB
Date: Mon, 19 Oct 2026 16:54:18 +0200
Message-ID: <20261019145421.47181-3-leonard@lausen.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019145421.47181-1-leonard@lausen.nl>
References: <20261019145421.47181-1-leonard@lausen.nl>
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
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999886) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=uxYa3boZYgV/MiLGouZGnYcxV5GzjIBtjWV3FVili4k=;
	b=OebpuDV2Yxs5swOAgqMZ/OUUTGcYAjoeY7gnRlL1rRftFRTLQS75JLw7xHSt6jGxyVBC0Bui1l
	hmNRLMAAZQXKJdhqx8qRi/9r89rEDYi9ITF1JN2GLqss2FJuTm511e7jy4KqZEoXUHw45V+BP/YM
	/db7Mhe+jIn2aM8J9ZOOIkVqhXxHMGHak4zwTJqsT7tEhGYirda9Mur4xFUEXWmczOJ5JJiQDAby
	sp3OQkugwhM5NQ/mgiprcHw8LIIxZJUoLnnKUu1dugEvZGUvw3uPWOYklwiLhcB1uTu9WVVLH3Dr
	3f1T5kgNgbQSJAtljJiL6I1Ez0NfpnnROSzJDlGc2oF+so7ktSKuJiRhDlgAg9HRXDxYke8roX3x
	KGEFgE76QT3cyhOUk+dtJalgY2zjgoIzdRAV9NEu3fbNKpgdJha5oh/RVzFX/QcwtUZKBvU28Gxa
	6DLT6Aejl0QT7QtOB3TK24G+ExMEUKqn1jKa+GUcC1+QLr45NG+xG3bAIRsMkPAxt05SD6PvMHYb
	r8u80juldnteiUeWw+t0W7q0EI2Fu0sAH65J5lVKRdhvUMVtDgOdy+ILiqAcOJXL/U6s5MEuzBNs
	l+W2vt4BZ8ZvWj5fIEXqIH3yILScnUzCYJDP7xw81BbUmK7kD5U53pF++6SgkxwuMwxVhTHLJEw/
	4=

FAN0._FST on the Samsung Galaxy Book 930XDB stores the reference
returned by Index() in a local variable and passes that reference to
Add(). ACPICA rejects the operand with AE_AML_OPERAND_TYPE when the fan
is running. The zero-speed path does not execute the faulty Add() and
can succeed.

The Microsoft fan extensions added a notification handler that evaluates
_FST on each fan status change. On this machine, fan notifications now
produce repeated ACPI errors, particularly around s2idle suspend/resume.
Speed telemetry also fails whenever the faulty path is taken.

Ignore _FST on this model. This skips the unusable speed telemetry and
Microsoft notification handling while preserving the legacy firmware fan
control. Match the vendor and full DMI product string,
930XDB/931XDB/930XDY. The firmware was inspected on BIOS
P11RFX.067.230331.SP.

Fixes: a5c2fcd82e04 ("ACPI: fan: Add support for Microsoft fan extensions")
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
---
 drivers/acpi/fan_core.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 624d0736b581..48a6818e6282 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/math.h>
@@ -50,6 +51,24 @@ static const struct acpi_device_id fan_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 
+/*
+ * The _FST method on these machines stores an Index() reference in a local
+ * variable and then uses that reference as an Add() operand when the fan is
+ * running.  This aborts the method with AE_AML_OPERAND_TYPE.  The Microsoft
+ * fan extensions install a notification handler that evaluates this broken
+ * method on each fan status change, producing repeated ACPI errors.
+ */
+static const struct dmi_system_id acpi_fan_broken_fst_dmi_table[] = {
+	{
+		.ident = "Samsung Galaxy Book 930XDB/931XDB/930XDY",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "930XDB/931XDB/930XDY"),
+		},
+	},
+	{}
+};
+
 /* thermal cooling device callbacks */
 static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
@@ -511,10 +530,14 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fan);
 
 	if (acpi_has_method(device->handle, "_FST")) {
-		fan->has_fst = true;
-		fan->acpi4 = acpi_has_method(device->handle, "_FIF") &&
-				acpi_has_method(device->handle, "_FPS") &&
-				acpi_has_method(device->handle, "_FSL");
+		if (dmi_check_system(acpi_fan_broken_fst_dmi_table)) {
+			dev_warn(&pdev->dev, FW_BUG "Ignoring broken _FST method\n");
+		} else {
+			fan->has_fst = true;
+			fan->acpi4 = acpi_has_method(device->handle, "_FIF") &&
+					acpi_has_method(device->handle, "_FPS") &&
+					acpi_has_method(device->handle, "_FSL");
+		}
 	}
 
 	if (fan->acpi4) {
-- 
2.55.0

