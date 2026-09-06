Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B0364E88;
	Sun,  6 Sep 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710066; cv=none; b=avatw8NN+i+0mofG4FISe7pfyrmAWDuLec480rjpy44yaMolwtBwbNOWY+i7PTJLPFTwmJYB1XGG3CO+P7yMJsESoIXNE486HWigbk0uYj7fYNbJUUJFegVX37GcKxw+TvvMLov5YA4f6GlscYm1F74IXMMVFvi70hnDtqsp+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710066; c=relaxed/simple;
	bh=4oXydQgkdknmkuXel/43Bm07DSo53HIsj3Ju6q7fPqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAxMH8vu6qvR7pE9tbnBZI3EvFf7VD2iEhK7w9yYn2cMz9Mh8PPSKZV5w3QfUN2tqY9x605jIODYdlWsZ5fo+Q5i4TpwpFkwnEaXYBt2wReXn0qg7TAwO743sgkxEPu7Le6jAPUOGiCMUiVWjv73sSiOOSZ9bp/p5fmHXif0u8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+B5/8PM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+B5/8PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC21F00A3A;
	Sun,  6 Sep 2026 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710064;
	bh=+dnSmZP5gM7Wc9+j+xl/n1XvEpY9FEbsLvJt/N9fxt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+B5/8PM9rDm4VGGKHZJxki+w76ElkSQilGOPQkxeSqdxjsTmw1Ptb6W58jWy6lUh
	 mZ7A6LpDwhwFz3TdfLzqrD1nFrc6XPaTSsj79M5qtFQ71vSzFzatBqx3v22jzoTcrt
	 XvZZ3WB4NWj8VU5FhZ9QjD8dzPzL1crYlE6y7bMkhQahknL2gOAbyxImjq28FyKd+m
	 yNuGSXF2xYCQrB6GlJIxrzdqUFWIbB/WAKFmHKZYdYHk2Ee9D01yu3rStuUgYckL3Z
	 YtcwyQTg+MRvoM2qXILF1HxLD2Dcqlbc/3e+WTt0K2ABWxzwOHIHDdIKs+oZaD1VM3
	 Sp6ClVcz9yFbQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v4 2/2] ACPI: glue: Rework the success message in acpi_device_notify()
Date: Sun, 06 Sep 2026 17:54:10 +0200
Message-ID: <2448150.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12989369.O9o76ZdvQC@rafael.j.wysocki>
References: <12989369.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Using an ACPI handle in the acpi_device_notify() success message is
somewhat misleading because the "physical" device is not bound to an
ACPI namespace object in that function, but to an ACPI device object
attached to it.  Moreover, the message is outright confusing for the
"physical" devices bound to ACPI devices without ACPI namespace
objects (for example, fixed event buttons).

Address this by turning that message into a dev_dbg() one printed for
the "physical" device and mentioning the name of the ACPI companion.

Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -394,8 +394,7 @@ void acpi_device_notify(struct device *d
 		adev->handler->bind(dev);
 
 done:
-	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
-			  dev_name(dev));
+	dev_dbg(dev, "Bound to ACPI device %s\n", acpi_dev_name(adev));
 }
 
 void acpi_device_notify_remove(struct device *dev)



