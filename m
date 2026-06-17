Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613E407CE3;
	Wed, 17 Jun 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703237; cv=none; b=fbAJEKiQYMsePo7BuHdCncJvdGB46o5gF8986/tP9ESKzNHL6VBtNMp5SzYyQhbXs5MWmbIi0x8EGZu9McTpEdC6SbF/3DB0OU/90pyX+luhJ5QQ9xWGPRuPEo9uOxnzZzhrUcIcppFjS6trkITwzKfUcwNik83WG3HGrCkJ4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703237; c=relaxed/simple;
	bh=4YrNXDncXnmKl+A8s140VbYwKQUDIRjgWGDf6s/6fk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WIti/iEbtlqrWvMy2AWwrxkIRfWw/FEUBNwA4OV+vDEztljSOQan3OZE4U3OO3p33SlLbohbmLL1n/mLTattdRN82UvUDA1J+WSrBVKnWzBuRVCgBK43aZLVYGRKomYg7Wb+drgxEgcmTb9K3Eqvz/C1UVtUnHgp1ZlQ7JcW3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=X79EW50Q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="X79EW50Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EEC0qJTG8OKSyQhpTsBvNB9fPeFKMLfq9Aho3jBcd6E=; b=X79EW50QThJuRBql8sQN8YZJ2H
	98AcES0FPmYRrraxKzT4B5jkqGVZGJjB0Vem/XnDD76WiFqGXJhNK/6PUYmk5IRVYsPAYn+BN08Bu
	nQmyK67OcbQnzIvePlH/65Ed1Y86u4imScirUM1DzgK8GwyH2GMy3u2Zn4Ze6id2xBvNBVpNTAFbb
	vb49+Qi1f/K72rtKB0OyeKHbWlvjpKe43/dZwpBjoeceNxZIbV521zUH7VH2l6ugcCE8cIj4TORpK
	vet7YpKbaHro5ejhLxWzeyd0ZN6WKXq+Jd/6+2y6sOPJcW00nDStjBUZykKlsBMD1QLDwuI6RJU8y
	YSPsncYg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOZ-00EeV7-1K;
	Wed, 17 Jun 2026 13:33:32 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] vmcoreinfo: GHES: track fatal hardware errors
Date: Wed, 17 Jun 2026 06:32:46 -0700
Message-Id: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6hMmoC/x3MQQqAIBAF0KsMf62QQhpeJVpITjmbihEqiO4e9
 A7wHjRW4YZED5RPabJvSOQMYa55W9lKQSL4zocuuGjrxao2+6H0JYTMQ4QhHMqL3P8zTu/7AZB
 4XRBXAAAA
X-Change-ID: 20260617-hwerr-a28d5d66ae87
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=leitao@debian.org;
 h=from:subject:message-id; bh=4YrNXDncXnmKl+A8s140VbYwKQUDIRjgWGDf6s/6fk4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkPriB/CZVfySHbrrGgN3toy1kx5+6UP9Cr
 r+0mhO81bOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bRGuEACowDrZxGFVCCGdYvWi67J+RKoA46lnaXuiZveyNlTjvUK4ac5KK/6XWnwTf7IxaNUVZ00
 rfodx3caH3nIQplfmvoyFtqX6ufeGoGFzNCfppP0X1MIm0q0I5K1Dcl8gPWTXgpm4JkkZzOCUsP
 T+bMVFmr8XV0uk4k8ccFRVMJBuSMZ8v4VOQi9ei60CtVaFWh3R6LyfJW8CHSeuhvHr7BGG7aZgH
 Kr53FX2fIUmtXhTaoN5A+Sad1/tNB4qH0Rg0XQUKY6/a7ahk4YlZvJKZ1G2oeMvTSzjhTyb8NVq
 MVPE5n2SHv1EuO242m9ijL1tBtWqSI1X3DAmzzjUhE6gW7uc7HPoxBH1sJ1lzQN8q4YGy7ZnIAT
 YmXB1J0+rZVUuuvEqRUzDDOtvQP3sccqvnZXoOO+vlllTpZ1KLQ/uKkRgCunfKnwwl9FgsK3Eg5
 ulJ740rWKgfrq9W/s3Mr6wwPp5wqyTRcDsJjQAKBdy+pFfBILlxBoN++eTGorjxpiUIDgq9igJP
 +7LG5o2QpXy4PhEX0zqP7W6mK08qjiyiFplElUm+Xg5z3QLnkK1DnC+RPbnTk3tsfcgeBWc5e7y
 szvZQkseCF5I0ZQvvR7m9bK6aoBlOCAW/wGra0uRWXlvWd7Cts+9XRho1att4kNnTURoW1ET2y1
 NGBU+0Bc+Ap73rw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Hardware errors reported through APEI/GHES are recorded in the kernel's
hwerr_data array so that crash tooling can tell from the vmcore whether a
hardware error preceded a crash.

This short series improves that path:

 * The first patch is just a fix.
 * The second adds a HWERR_FATAL bucket that records panic-severity
   errors -- the ones most likely to have caused the crash -- when GHES
   reports them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      ACPI: APEI: GHES: fix severity namespace in ghes_log_hwerr()
      vmcore_info: track fatal hardware errors

 drivers/acpi/apei/ghes.c    | 7 ++++++-
 include/uapi/linux/vmcore.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260617-hwerr-a28d5d66ae87

Best regards,
-- 
Breno Leitao <leitao@debian.org>

