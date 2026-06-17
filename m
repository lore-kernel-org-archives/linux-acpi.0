Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA03955FF;
	Wed, 17 Jun 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703236; cv=none; b=UYBG5u7WvcikWSdmdRszdVhHs6cNMaHVbwn9iP06SZh///SmxU/LNN07gfamw2d0gNpie6y+1Dy7RWKOWmjwy9a8Oa9xfqSGXVKySJ6XKjNN0Nr21jhxMXlwqRafwMZOTE5TnsR17OA8JRe6XHpYBjZcFmftGa4P0KIUX6Spb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703236; c=relaxed/simple;
	bh=IMYiUdETKsd9vslxX1nGBukt/xidhhV6uxKeG22G+Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbVnY8PM0A97s0qDAW7V6Rhpu8L5eMaDjxeLd1RA/F6+6nIo7ADA2SHGwiKTijp1ev2e1K1Th+DIOg2F+IrC30/u4GAf+29PALRJF1W9Pp7iCfJBVS0NZOXO1XDknoxJdnPwyibbnJUsyzo47zFkiT5dDqLlLxnC2lcD+TcfcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=N5eefuhL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="N5eefuhL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/0WbWUM0YqRig6pLzRsihGyxNEeNAVR9TczamDwMF/4=; b=N5eefuhLpBajkaaJT+OSbqc0iY
	FGiQA+H2djSY6ZSYwleP88Pnp/zWXFUqA9uPPlN8bFYoIOgy7T+yP8kP5usWgViz2P9NBQpheOMHz
	5fq2j0wPRSyqq3eWw8lduMrADGY64KocjwBIdVOM1QGxzHkdoeQITkdY+4SvmO5yUpC4F9zhgDAW1
	HHvsFOks2nkksVP2qyZZQgw6ODo8ayLTjwfm7ZzKdQqrVkUW1JvajqDMO89g5jvIdkN1+FpuCJ0yT
	b1FR3SEFZISFKb3tu4z7XxfFJ2X3RqbVdtKnGJ+CfuaqWTK3sR89rg1c2x8U4NZMsMzQWwe0+b330
	TW3pZDTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOf-00EeVC-0g;
	Wed, 17 Jun 2026 13:33:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Jun 2026 06:32:47 -0700
Subject: [PATCH 1/2] ACPI: APEI: GHES: fix severity namespace in
 ghes_log_hwerr()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-hwerr-v1-1-ff131cd6203c@debian.org>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMYiUdETKsd9vslxX1nGBukt/xidhhV6uxKeG22G+Dg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkNxoJNOROjiYczzba3ljNP3lHQN4V+VJtB
 2jP68tv2fWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bebPD/0eyRiXYwI/eZz4VMGjbfYJbyIgQN4p41SffpyWjB2Uy9Uug7GKQyxzLWDaoERwM2IqYCz
 IbOnZ8ELzd32K0SFa+0D8MJt9h310hHlI3xn2ZftujlO9/z2AO6Akj5WQeZ9h0c7wrk0k1XCkfX
 ESjJUwpTzSSiiJlC3HbEf8wE+hu3qPN1IxtN4neHzj2axlajMq5518d56OoDruWAkV1G0Z5OUPK
 bbhy05BQevI+/Ob9pdZxcu4cvcrJl1GeSVfVorF7nzKRSVDP16/BSaK+3Dh0OrZTYIr2AufGM2j
 XdyoWwJA9CLkX70o50v9C21cXGzK/o3hrcSTfALh50MOcefeUM2/uPHFZtPCZBlPuWVXa1vmC2Y
 zAM/1NdYWwwsBCT8+nwe0vG/2Yms3lbF0yc6JQA9xgPL4iA+1tfeUZC82UuvR7EhV271dcEorx6
 GZDoT5F9dLPv3vf1/gFJ45wIbp0dcT7sP1Bgb4Mqc0sZaddjeukuEOrFcNXlreSj1buOYg3v/6E
 CKevbY7m90llzDduAa0yUeF2Aa5EP9QA1ZsG5NX/gmoEfeCLovyfLNyOitIjGKkTk2pz5KrCZ/Z
 YKS+gV0f+kI/sJas1cDCGsSOJuxHq6EAIBumbcw3K2rW7L8ZL7NlscjL1XoZCykATpxN2W2AjV7
 hXCI+yJlyoA4xow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

ghes_log_hwerr() receives a GHES_SEV_* value from ghes_severity() but
tests it against CPER_SEV_RECOVERABLE.  GHES_SEV_RECOVERABLE is 2 while
CPER_SEV_RECOVERABLE is 0, so every recoverable error is dropped and
only GHES_SEV_NO slips through; nothing useful is recorded through the
APEI/GHES path, which is the only one arm64 has.

Compare against GHES_SEV_RECOVERABLE so recoverable hardware errors are
tracked as intended.

Fixes: 918e1507cff9 ("vmcoreinfo: track and log recoverable hardware errors")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6b..f0f9f1529e7aa 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -877,7 +877,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
-	if (sev != CPER_SEV_RECOVERABLE)
+	if (sev != GHES_SEV_RECOVERABLE)
 		return;
 
 	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||

-- 
2.53.0-Meta

