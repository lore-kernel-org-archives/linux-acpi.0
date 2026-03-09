Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1537647F;
	Mon,  9 Mar 2026 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047326; cv=none; b=dKyCBUwniGRCsghrUvYZPHgQhgZjLcrj7OZp0yA0sMjOprqQIRt9/fB7I0RSaTgCz6RLAz8OOOJAdD16wcfMaLscJpIFDcW97foErmHrkf2i939buGQn0p+pZQ0ybYws/qRer4PurksxX6ho/AUzXwFbfUgp6cRPMflxHDr/sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047326; c=relaxed/simple;
	bh=e1tBXWVKORtgJa7cy22Qjc2GxEd+3YwBgFIpQXvfM78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agHzd0VQ7a21oXhju7OZtrgPtfVbzeotP+OLmp3PDpAdxIjsE07RObLqXu9afVJM+yjSmk2ClGrnsUtH1goOLlA6JmqbQpCBkwSnxFlFDqj8AIeeSwz4lMl6+y/MdDc0QOvHB2Rp5RYjqY0V9Sq/XbFncFNjFXpgTfffR2mJthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAXqAsZjq5pZdDxCQ--.28874S2;
	Mon, 09 Mar 2026 17:08:41 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] ACPI: scope acpi_device_is_first_physical_node() to CONFIG_PM
Date: Mon,  9 Mar 2026 09:08:22 +0000
Message-Id: <20260309090822.719996-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqAsZjq5pZdDxCQ--.28874S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww47ur4rXr1DZFW3Jw4Utwb_yoW8Xw13pF
	W2yFyYyryDWr4j9w1xur4rWFy5Jwn2y340grWUJ3sI9a1v9ry5AFyIyFy5W3s8CrWDGw4I
	vr9xtFy8ZF1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU1mhFDUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/

In current linux.git (1954c4f01220), the helper function
acpi_device_is_first_physical_node() is defined and declared
unconditionally. However, its only in-tree caller resides in
drivers/acpi/device_pm.c, which is built under CONFIG_PM.

Match the helper's prototype and definition to that scope by wrapping
them in #ifdef CONFIG_PM. This fixes the config-scope mismatch and
avoids unnecessary code inclusion when power management is disabled.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@
  * Note that the caller have to provide valid @adev pointer.
  */
+#ifdef CONFIG_PM
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev)
 {
 	return !!acpi_primary_dev_companion(adev, dev);
 }
+#endif
 
 /*
  * acpi_companion_match() - Can we match via ACPI companion device
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
 bool acpi_device_is_enabled(const struct acpi_device *adev);
 bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
+#ifdef CONFIG_PM
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
+#endif
 int acpi_bus_register_early_device(int type);

