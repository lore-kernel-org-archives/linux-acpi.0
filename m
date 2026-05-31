Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E80387590;
	Sun, 31 May 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229335; cv=none; b=dSZEZOyW/is5lSsFn12Fu/nchp5KDYGfAjQeXQGT/vpeepEJwW2HMl/bdXYtjiRJRy5CGMEvRoydaNSeVDTsNs5HLmqXAxwLXuNC8i//ehNMxC2EkS6uc1h9xgPZLNA0TO/CY4pdz0lJXq5iq0bnW7QMQEiQ8t5XqBBIDjyNuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229335; c=relaxed/simple;
	bh=tdajEXMQ5N7AV+va3HatLfSv1PtR1PahzDWuNgcMkNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpRiw+GgsFk5ZZIyxmoyp+VEZe8axOS0FS2CIbnxp58SfBo6GGU53XIRnVeKZB1gO+WG1/S5NRbkL22uAuxrJRTPWZZil2BWgvhkPtcy5Qvfwv+MmF0oVd8/VIYnWxdrb5ZT/CWCXakWoLsLV/TxTpDEf0NQJQeffpLY8fRvXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZHAiqnfK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZHAiqnfK"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8E3B42672E;
	Sun, 31 May 2026 14:08:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5Zm5lksZQRy; Sun, 31 May 2026 14:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780229325; bh=tdajEXMQ5N7AV+va3HatLfSv1PtR1PahzDWuNgcMkNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHAiqnfKmAu98Iz7hW3Glo7x7slXk6pTHQ9J3NL/TqF9B8yTrNh5FGjomtkZxWduT
	 k5j9AWB8QfHDER4T18iZqih++/kUnr0ckQh+tEPLIEFqk0MP4cloFZ7oVmZAs8JkKP
	 NFHP7oKGB6q+Uz0ElQ+0T3+5VGzqfYSahAmBMS5O9zhJVCmDWwafMZe480ZKO4gs6/
	 /zcNFAlKG4bXyu4RBWlkMEQ4a3N5PxyePQrpFLXKV8SzrwmukXL9uesrBoSBo9lyRJ
	 Be2KkBbZNUg/CbfEkaUkg5b96vcfzzLo9FnYcjY8+lGeDIXI/qHEVmGuyShWXkSwLr
	 NK7Gt2vKPabww==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] gpiolib: acpi: prevent address truncation in OperationRegion handler
Date: Sun, 31 May 2026 14:03:10 +0200
Message-ID: <20260531120816.17255-4-scardracs@disroot.org>
In-Reply-To: <20260531120816.17255-1-scardracs@disroot.org>
References: <20260531120816.17255-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI address space handler for GPIO OperationRegions receives the
pin offset as a 64-bit acpi_physical_address. However, the handler
truncates this address to a u16 pin_index before validating it.

If an ACPI table attempts to access a pin offset greater than 65535,
the truncation wraps the index around. This may result in accesses to
unintended GPIO pins.

Fix this by adding an explicit check to verify that the 64-bit address
is less than agpio->pin_table_length before assigning it to the u16
pin_index, returning AE_BAD_PARAMETER if it is out of bounds.
Additionally, make the length calculation overflow-safe and change the types
of length and loop counter to unsigned.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index e3bc4677b51d..d12dab42a096 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1150,13 +1150,13 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_gpio_connection *conn;
 	struct acpi_resource_gpio *agpio;
 	struct acpi_resource *ares;
-	u16 pin_index = address;
+	unsigned int length;
 	LIST_HEAD(new_conns);
 	acpi_status status;
-	int length;
+	unsigned int i;
+	u16 pin_index;
 	u16 shift;
 	u16 word;
-	int i;
 
 	status = acpi_buffer_to_resource(achip->conn_info.connection,
 					 achip->conn_info.length, &ares);
@@ -1176,7 +1176,17 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		return AE_BAD_PARAMETER;
 	}
 
-	length = min(agpio->pin_table_length, pin_index + bits);
+	if (address >= agpio->pin_table_length) {
+		ACPI_FREE(ares);
+		return AE_BAD_PARAMETER;
+	}
+
+	pin_index = address;
+	if (bits > agpio->pin_table_length - pin_index)
+		length = agpio->pin_table_length;
+	else
+		length = pin_index + bits;
+
 	for (i = pin_index; i < length; ++i) {
 		unsigned int pin = agpio->pin_table[i];
 		struct gpio_desc *desc;
-- 
2.54.0

