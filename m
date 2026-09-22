Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA0559CA0;
	Tue, 22 Sep 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090802; cv=none; b=kBbdixkdQl1DPyZZH3F536SL2KQ0YIfezAOawVSBXK6TW+S3Y8KHR61Jo37zOfOgSBhol6zVXh33RISCWrnv8uOYLG/8Fo5D2rv4yvq+EIFIwzN7kUDkZu7LSIaGiqbv2EOXJ/ucl0GhTdu1SL+1uE/6pbtiwfW32QZR8JDzImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090802; c=relaxed/simple;
	bh=DFFRtLl4ms5A9VozLwdSuHxnXJgZjDS52jAVi7F/hgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YG2Dw1WhTbvfumliNG63wPWq6qJM8fSl4lPAHPe/VMlbgcjXeLj5pnFcFVkb+aA4jNt5gapDveZ8TsN6rtAPfCf1RLVuhmDnXhSOJ07b+cfkLz8C20irne//p01mz8LiAK/Y2EGWgEb/X3gaBqqkbzd/1rZEpIa/YcuLdsaOnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zv9FW/Fd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zv9FW/Fd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD631576;
	Tue, 22 Sep 2026 08:26:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 723173F86F;
	Tue, 22 Sep 2026 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790090800; bh=DFFRtLl4ms5A9VozLwdSuHxnXJgZjDS52jAVi7F/hgU=;
	h=From:To:Cc:Subject:Date:From;
	b=Zv9FW/FdOWSeA/wa07r9SdOi/+cJrh7IKn2AHwsvNSP+ZM/dFnsSS2sGh4q5RhUDG
	 R9mXVZVc5PL/n48zuBT4uRXWt9ga4mp9eFVmyz0qDyOE+q+ROdF/wf+zZAXD/O1MIp
	 QUkUSPBBGrl20HOkqsVXY0Yt6zPTJxu6CYGkczDY=
From: Robin Murphy <robin.murphy@arm.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: Provide !ACPI stub for acpi_device_uid()
Date: Tue, 22 Sep 2026 16:26:34 +0100
Message-ID: <8325277ff0484ab869fecf662a7ea356cd00bcde.1790090794.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
already have stubs for !ACPI, the basic acpi_device_uid() getter does
not. Although calls in portable drivers should already be conditional
on a valid acpi_device in a manner which would usually lead to compile-
time elimination anyway, add a stub for the sake of completeness.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Distinct non-const definition to avoid further theoretical issues
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a45e0d521d8..d686d09f1678 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -964,6 +964,11 @@ static inline const char *acpi_device_hid(struct acpi_device *device)
 	return "";
 }
 
+static inline char *acpi_device_uid(struct acpi_device *device)
+{
+	return NULL;
+}
+
 static inline bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
-- 
2.54.0.dirty

