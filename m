Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C42D060E;
	Thu, 29 Jan 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699195; cv=none; b=ooTw0XOnl3pc+yLErvONkPpXciUoghRQu8pd0HqZZSkL4Kp3Bn/I2vmsMLAGybDY5SyYrp4+Kiw6b7eZBk+HFSnXVHPdBovR0RAo/467h+RbVoT7mC/EWEXT8kx+XUN+xNDCPLklF2I60XLfzuTAi1fX63wrqXMKAH546FO1Qu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699195; c=relaxed/simple;
	bh=2Rv/AyVjYFCvVPvFYJigym7UrwpTpO94Yg+PekFJM3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6esKZxUrFVR65X5OvHb46nP4bUqvHFUaII9KfVIgcizNn2jtmXTihs7oGm7iNtbB9hpZvc5MarqDJpRNcecxW0ui2MILgtADHNFYZkknFsW4jxgyNbBsCMv2OL+0/zZgk9sK9Y7ij7xebk0tsacNZCeIa0sL5zvngxEEUALQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id B6FDFDF8B12;
	Thu, 29 Jan 2026 16:00:05 +0100 (CET)
Received: from albans-vm.. (unknown [94.134.109.199])
	(Authenticated sender: albeu@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 4DDAC2003D3;
	Thu, 29 Jan 2026 15:59:50 +0100 (CET)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-gpio@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alban Bedel <alban.bedel@lht.dlh.de>
Subject: [PATCH] gpiolib: acpi: Fix gpio count with string references
Date: Thu, 29 Jan 2026 15:59:44 +0100
Message-Id: <20260129145944.3372777-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 9880702d123f2 ("ACPI: property: Support using strings in
reference properties") it is possible to use strings instead of local
references. This work fine with single GPIO but not with arrays as
acpi_gpio_package_count() didn't handle this case. Update it to handle
strings like local references to cover this case as well.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
---
 drivers/gpio/gpiolib-acpi-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 83dd227dbbecc..effc5ab6864b8 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1346,6 +1346,7 @@ static int acpi_gpio_package_count(const union acpi_object *obj)
 	while (element < end) {
 		switch (element->type) {
 		case ACPI_TYPE_LOCAL_REFERENCE:
+		case ACPI_TYPE_STRING:
 			element += 3;
 			fallthrough;
 		case ACPI_TYPE_INTEGER:
-- 
2.39.5

