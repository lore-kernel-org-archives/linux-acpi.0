Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4C175A95;
	Wed, 15 Jul 2026 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078796; cv=none; b=hQATmva0UZUhc235vcA0HBKrv5CsXTqVY7MTTz4kyJKMUbMDGogauwP/mDBMOa3VwbDhQh42dm/IavTE7JfKCOVIzGZPdQtezk0D2DflhpOO4SrtEURspAQt096z3fCyJmSxx/QFektgESCOYlMrmLMsNEuz+a0cd4ouJrsWPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078796; c=relaxed/simple;
	bh=Cr3XcaGKqHWgqBSiq4jFWJV7OLC35dmEwAwjYguqn3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyyOcMqKFuIt2vt4yG3oI+iWntanZe51NfYZUOoTzcuJAsHW2T69Fk3L1JdAcBIdLZ2nZhWtVaTOumbhWO0sNc7j6WdgEtOXVjLv9WSrqTYWnVOiy9hgsZetyn6tR+uakVYVHGxi6rSyvlvfIvzQCa6KMgOlRQdKqY6bCeSOLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3GZq64VZqcJAPAA--.17333S2;
	Wed, 15 Jul 2026 09:26:18 +0800 (CST)
Received: from WIN-B62RPRBL2BM.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwBHWz4VZqA2kTAA--.35103S3;
	Wed, 15 Jul 2026 09:26:11 +0800 (CST)
From: Zhu Ling <zhuling2709@phytium.com.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Ling <zhuling2709@phytium.com.cn>
Subject: [PATCH] ACPI: EC: Avoid _REG disconnect on GPIO IRQ defer
Date: Wed, 15 Jul 2026 09:25:19 +0800
Message-ID: <20260715012556.12043-1-zhuling2709@phytium.com.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwBHWz4VZqA2kTAA--.35103S3
X-CM-SenderInfo: x2kxzxlqjsliuz6sx5pwlxzhxfrphubq/1tbiAQAPAWpT6fkHHAAMsx
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=zhuling270
	9@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxurWDGF1DWFy7Gr1fuFyUZFb_yoWrJw1rpF
	ZxtFZIyrWUGF4I9Fn8Za15uF1aka97CFW7JrZrK34ak3WUuw1YkFy2v34j9FW7ur95Ga12
	qr4Utay8CF1DXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

EC event delivery uses either a GPE or, on ACPI reduced hardware
platforms, a GpioInt resource.  The GPE path does not have a provider
lookup that can defer, but acpi_dev_gpio_irq_get() can return
-EPROBE_DEFER for the GpioInt path.

ec_install_handlers() currently installs the EC address space handler and
executes _REG before looking up the GPIO IRQ.  If the GPIO lookup then
defers, acpi_ec_setup() tears the handlers down again.  Removing the EC
address space handler causes ACPICA to execute _REG for disconnect, so
firmware may observe an EC OpRegion connected -> disconnected transition
during one failed probe attempt.

This is observable when the namespace EC reuses a boot EC that has already
installed the EC address space handler.  A deferred namespace EC probe can
disconnect the already usable boot EC OpRegion until a later reprobe
connects it again.  AML that gates EC field accesses on _REG state can
then return fallback values to other drivers during that window.

Prepare the GPIOInt IRQ before publishing EC OpRegion availability to AML.
This leaves the GPE path unchanged, keeps non-deferred GPIO lookup errors
non-fatal as before, and still lets the existing acpi_ec_setup() error
path clean up real handler installation failures.

Fixes: f6484cadbcaf ("ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()")
Signed-off-by: Zhu Ling <zhuling2709@phytium.com.cn>
---
 drivers/acpi/ec.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 64ad4cfa6208..26550879f43c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1510,6 +1510,23 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
 				    IRQF_SHARED | IRQF_ONESHOT, "ACPI EC", ec) >= 0;
 }
 
+static int ec_prepare_gpio_irq(struct acpi_ec *ec, struct acpi_device *device)
+{
+	int irq;
+
+	if (!device || ec->gpe >= 0 || ec->irq >= 0)
+		return 0;
+
+	/* ACPI reduced hardware platforms use a GpioInt from _CRS. */
+	irq = acpi_dev_gpio_irq_get(device, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq >= 0)
+		ec->irq = irq;
+
+	return 0;
+}
+
 /**
  * ec_install_handlers - Install service callbacks and register query methods.
  * @ec: Target EC.
@@ -1524,7 +1541,6 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
  * Return:
  * -ENODEV if the address space handler cannot be installed, which means
  *  "unable to handle transactions",
- * -EPROBE_DEFER if GPIO IRQ acquisition needs to be deferred,
  * or 0 (success) otherwise.
  */
 static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
@@ -1557,19 +1573,6 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 	if (!device)
 		return 0;
 
-	if (ec->gpe < 0) {
-		/* ACPI reduced hardware platforms use a GpioInt from _CRS. */
-		int irq = acpi_dev_gpio_irq_get(device, 0);
-		/*
-		 * Bail out right away for deferred probing or complete the
-		 * initialization regardless of any other errors.
-		 */
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		else if (irq >= 0)
-			ec->irq = irq;
-	}
-
 	if (!test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
 		/* Find and register all query methods */
 		acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
@@ -1647,6 +1650,14 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
 {
 	int ret;
 
+	/*
+	 * GPIO IRQ lookup can defer.  Do it before publishing the EC
+	 * OpRegion to AML to avoid a spurious _REG(disconnect).
+	 */
+	ret = ec_prepare_gpio_irq(ec, device);
+	if (ret)
+		return ret;
+
 	/* First EC capable of handling transactions */
 	if (!first_ec)
 		first_ec = ec;

