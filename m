Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F143769E6;
	Fri, 22 May 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461654; cv=none; b=Tawt16m7dDUq4IS2tEDZraFJHZM9DiFDNn01DmA1M06xVIWRmA0cQ1XHdHGaDYVDdXYIFUIJpB3DlhSMs2bwBvC5CTkMpPuwEXuUrTyOiFhf7RDji2T795viT0yA/3PE4vJAs0/DZBYVg5WVKC5hHYrTN1OBbtUOpOAR1NW4FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461654; c=relaxed/simple;
	bh=i/k4SmKCEh/FV+KO4+RnCXr67fBxXybwBKfxhBfC0Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CocTb9WTUToJtyiPA5C9cB+AoBXoTd9adbPyeBHJncurwYJ97VkIRNumb55cNFB5z1Gv/bnB5ejQhIxAZtwpXMlpSpZWIX9H9yuPFbA6Zl/nVh//8goUNZFgJFRbzaOwGd6N1DfvP/3xqWB64o6fTgJcb0mFV3qn5dkBAc7IN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTJw0nM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTJw0nM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378321F000E9;
	Fri, 22 May 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461653;
	bh=ew2b1Wuqm4+HcJRgw11htKMwlo8xGsrS35NCBfsMAc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTJw0nM746am3PwVJqqtd4EeT6T33fjXB7x709nedqYKjFtcrEuHRQjVTe5lsy43O
	 4HmAPcXrQtMbNSdZQDEdg0fI5DyIm8dFA6YZT5qiE4vQkAMrrsGD0zAT3EOziAmL9b
	 cafFrGtCBp7xvgUdiZ7VlRhOnrWTyrwZeHO5hwlgQrL2jBl7e9/G5fUfm70L+3oIKN
	 Yoad738+VlHi50Y7yytM1zRi81Kit8wH91AJR4KQ6u/WDwPv9YHwGdst/7tkkZFTNW
	 P51hpYrmotTZY46FE7/Y6kGywjwdYphAYpENRPumJCcK6c8D9oks/vS+M80wCRo9Hh
	 0MiSJZt/BYJlw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 3/3] ACPI: button: Add missing device class clearing on probe
 failures
Date: Fri, 22 May 2026 16:53:48 +0200
Message-ID: <6167713.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2046403.PYKUYFuaPT@rafael.j.wysocki>
References: <2046403.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit e18947038bf4 ("ACPI: driver: Do not set acpi_device_class()
unnecessarily") modified acpi_button_remove() to clear the device class
field in struct acpi_device on driver removal, but it should also have
updated the rollback path in acpi_button_probe(), which it didn't do,
so do it now.

Fixes: e18947038bf4 ("ACPI: driver: Do not set acpi_device_class() unnecessarily")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---

v1 -> v2:
   * Add R-by from Mario
   * No other changes

---
 drivers/acpi/button.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -687,6 +687,7 @@ err_remove_fs:
 	acpi_button_remove_fs(button);
 err_free_button:
 	kfree(button);
+	memset(acpi_device_class(device), 0, sizeof(acpi_device_class));
 	return error;
 }
 



