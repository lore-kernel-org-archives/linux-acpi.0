Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A29A9E9;
	Wed, 28 Jan 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594365; cv=none; b=rBPRnmJLRHGOmqLkfn/5xOjmTo0NpB4yoU0MwE2RikkUdIYGtDjG5SsFgeG98X0lGBTogYGy6E+EuS3DICDUtNV/w1LwscuqazVw4/Bad8pEDXF6LdaD8jrG9SzeGFtFpbGQu1mXWKIQvYaXdi8ONcJ0JwpWjeBp6yp6/7liDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594365; c=relaxed/simple;
	bh=GFqWwOFWu6EfwFIO+uiYxjYWzWm9ptu6E09Y3VXHuY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWCzEDCS+T2jsPk7g09WqSnljRRP23dV2mTBhrjaVFmLEc3iV/ftvPUzGxl+o2LobhCVQtDwsSZ3MGTQzYSTJceWAl3dkCjde3rM3XgX6GSHZkJQ9JLdu5FtzfCA6lt8EKBj2KPtjdMg37v9dFc5Yef3ZFdY80qaVPxYxugGAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgOFXUPs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgOFXUPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769594364; x=1801130364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GFqWwOFWu6EfwFIO+uiYxjYWzWm9ptu6E09Y3VXHuY0=;
  b=DgOFXUPsvaSTq/2JbIqaUp5KAYLnp4pIx+bXbA19DsxDoZaWVPtd77kL
   pLzjQEnVN7xT2AZbAgquTvShH1nq8c5SViL0ayhOdslS1JuCHR5e4YDSN
   W5Tu15NBxJTF6PGfhSgNB9PjomkZjr6k8uNpTSWw2IIMWtcd6hhtz9c8M
   NEXkpU2tP16uzgwR47LLpI+zqOQRZip250E1fCkZCbckBrkVdaywoyxKC
   dDSEB7T3fJqs6vIlYHk7nEzppmqdRjJ43QOW9mBVtm096QG6qt2xIpesx
   1IU/w6CMv+vRjGcGfUxxcVQNkaa37ySiFq0ydoTuXfV5PQfdfkTgEI/h7
   g==;
X-CSE-ConnectionGUID: /gaD70/fSbO0EuaaJ480EQ==
X-CSE-MsgGUID: d5G2Km52Si6tU2/vnqL4Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81525515"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81525515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:59:23 -0800
X-CSE-ConnectionGUID: /oN1U4XtR0GqvSPucNfz4g==
X-CSE-MsgGUID: gCpjuyiPRwa3E9soUPLX8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212329002"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2026 01:59:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 68E9595; Wed, 28 Jan 2026 10:59:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Wed, 28 Jan 2026 10:58:54 +0100
Message-ID: <20260128095918.4157491-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO Address Space handler gets a pointer to the in or out value.
This value is supposed to be at least 64-bit, but it's not limited
to be exactly 64-bit. When ACPI tables are being parsed, for
the bigger Connection():s ACPICA creates a Buffer instead of regular
Integer object. The Buffer exists as long as Namespace holds
the certain Connection(). Hence we can access the necessary bits
without worrying. On the other hand, the left shift, used in
the code, is limited by 31 (on 32-bit platforms) and otherwise
considered to be Undefined Behaviour. Also the code uses only
the first 64-bit word for the value, and anything bigger than 63
will be also subject to UB. Fix all this by modifying the code
to correctly set or clear the respective bit in the bitmap constructed
of 64-bit words.

Fixes: 59084c564c41 ("gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler")
Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
Cc: stable@vger.kernel.org
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: added requested and given tags (Bart, Mika)
 drivers/gpio/gpiolib-acpi-core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index d42f769eeb11..9627b3a9c7f3 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1104,6 +1104,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
 		struct gpio_desc *desc;
+		u16 word, shift;
 		bool found;
 
 		mutex_lock(&achip->conn_lock);
@@ -1158,10 +1159,22 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 
 		mutex_unlock(&achip->conn_lock);
 
-		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT_ULL(i)));
-		else
-			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
+		/*
+		 * For the cases when OperationRegion() consists of more than
+		 * 64 bits calculate the word and bit shift to use that one to
+		 * access the value.
+		 */
+		word = i / 64;
+		shift = i % 64;
+
+		if (function == ACPI_WRITE) {
+			gpiod_set_raw_value_cansleep(desc, value[word] & BIT_ULL(shift));
+		} else {
+			if (gpiod_get_raw_value_cansleep(desc))
+				value[word] |= BIT_ULL(shift);
+			else
+				value[word] &= ~BIT_ULL(shift);
+		}
 	}
 
 out:
-- 
2.50.1

