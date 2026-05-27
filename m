Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856694779A5;
	Wed, 27 May 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905568; cv=none; b=AD+gh8FeZilM+FK0zm/gB6Hk9iu9RJYjd+YJTdvXvj0zKSlJOMuHi5Q1H9Ft8xGKk/9ZKAPqztPyDgX/EiJeq1RbKUQzAz5QkS414fS8CX2xHjTV1pzkmViynq6g46Mk1EQ+IDMxe+0WV/84kg4CSdKMS8eMhnW0xpzVHYQT2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905568; c=relaxed/simple;
	bh=8gawcBTVm+mnNbzeelX2dBDi8hXYvuEoYes8HOmzLws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7XQVS3weqrdimqRyzcVMLh18xwfNQPWGBTyru6cmM4bcT3VpeB6mx4/zwXxS0NYd5jMPIA9bSkpv8p9w60KHl83QYrzOX+0oea/0QXMwThT6iIyf9B2E9DJ8z2UyVvIVq1xjAEDrJiXUY4WRqnuQZ+yM0spNpYO6akhrHrMnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3O8Uy+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3O8Uy+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77F11F000E9;
	Wed, 27 May 2026 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905567;
	bh=BAUtvQjsUcmnCY5TIky7k/8Ut+mkWsQQyqganxdMvjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3O8Uy+gk/zHwL5clnpZGZegjIrXBBVVFspPqZwt6I4BSLW4zwT8HTTilPhBhkFD3
	 gILJJBSYNPbHj2lEM9C7yEggDtNlMc6APmndm8nbjEr6QCzH/jBITqH+Fdfz48qRCv
	 +XTWwafgJqC91qhtCqcecGjUzDn3DcSMpKrmBJsVZqR5xXMumUpUKO0SHVgk2lyA3K
	 3gnMAqqX+aMGZ8yKx26l5xyorEPRu8m3jOmGAQJBh6/q7Kdc+4NL4LXAXMz5idHIET
	 l3+O1yzj7MD1D9yjfKle/TnB4/5h5LSZrxhlZFmBVeeqRbnaPsDkyGSChKZkYuVsG4
	 QCUAg20mEsMKQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 03/27] ACPICA: Fix condition check in acpi_ps_parse_loop()
Date: Wed, 27 May 2026 19:53:12 +0200
Message-ID: <1959692.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

Fix condition check for AML_ELSE_OP in acpi_ps_parse_loop() to prevent
out-of-bounds access.

Link: https://github.com/acpica/acpica/commit/3b537b92336e
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index c989cadf271c..35111ff2526b 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -425,7 +425,10 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 
 					ACPI_ERROR((AE_INFO,
 						    "Skipping While/If block"));
-					if (*walk_state->aml == AML_ELSE_OP) {
+					if ((walk_state->aml <
+					     parser_state->aml_end)
+					    && (*walk_state->aml ==
+						AML_ELSE_OP)) {
 						ACPI_ERROR((AE_INFO,
 							    "Skipping Else block"));
 						walk_state->parser_state.aml =
-- 
2.51.0




