Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A693260566;
	Mon, 13 Apr 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063698; cv=none; b=JQ0uY8jalnnMjJwNVWRlfOAVvq8F+v9mUWtCmpWrfmgCDOFyDNxREw7h9+Oo90lq48trLnjnY6TfsE8WUtFBvtG8H5ToTGrwtXMzuFW5L0cZ9Raq6LEUUwvVMgUfjIPBc+HUPWpH6VvpBXjLz9KqK6nk+huGO/IMrgU9w+mHcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063698; c=relaxed/simple;
	bh=/JcQ3RZkvoVuaeeCRJLKf+9d3Uj+JqRvG6wPaRXt6BU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5LYiT+uEmI/FtmV8An7vkBiD6UrO9xbFuVNlu8imUbDUUTM7jyF+YajtIk2mpf86/3VFLkaAXCGb12l/I8kPRuID0pjJrkdYG+iMS/nXzHUlIdAwkk7FqYUQaFyLHT5EgXXoSfGzYUalJJyjYXhcJt0+6qXZKQTipXHBl3U6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIESIPXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIESIPXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5148EC2BCB3;
	Mon, 13 Apr 2026 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776063698;
	bh=/JcQ3RZkvoVuaeeCRJLKf+9d3Uj+JqRvG6wPaRXt6BU=;
	h=From:To:Cc:Subject:Date:From;
	b=NIESIPXSXK+jgone3H8YSaR7qrjBN7CXXBphkGZ30MrX2t6prvTFFB1VUlNYJEJq/
	 XbTRP9/+SOGJt1VnAFhJHfH4qXz3qW9w4EZyf53LZr1irSJ+OPVg23mKTetzOz/ude
	 4G8qlEH48WEF8owQK554jATP4uZ6wfuZ7rU5ZmlHjvGohdk73sn6YMk2v9m4SXIAZW
	 IAlpmeO3UjTHcPvg02Jb0zznr1ScBWCdJJOgxGv6RAaTzM+P0VeAnoHUfjcxvSmCOb
	 OJgtdfu19ZWbVT6QwJFUr87KkY1S9Bbyu9wwQJwbQI+oBFIgH4jBKlIWBC4iGyglWC
	 R9TLaIkYp5WSg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Chengwen Feng <fengchengwen@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: add acpi_get_cpu_uid() stub helper
Date: Mon, 13 Apr 2026 09:01:26 +0200
Message-Id: <20260413070132.3828606-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When ACPI is disabled, x86 Xen support fails to build:

arch/x86/xen/enlighten_hvm.c: In function 'xen_cpu_up_prepare_hvm':
arch/x86/xen/enlighten_hvm.c:165:13: error: implicit declaration of function 'acpi_get_cpu_uid' [-Wimplicit-function-declaration]
  165 |         if (acpi_get_cpu_uid(cpu, &cpu_uid) == 0)
      |             ^~~~~~~~~~~~~~~~

Add a trivial stub that can be used in place of the real function.

Fixes: f652d0a4e13c ("ACPI: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0afab1a2ad8e..4e5e0ff4c887 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -964,6 +964,12 @@ static inline int acpi_table_parse(char *id,
 	return -ENODEV;
 }
 
+static inline int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
+{
+	*uid = cpu;
+	return 0;
+}
+
 static inline int acpi_nvs_register(__u64 start, __u64 size)
 {
 	return 0;
-- 
2.39.5

