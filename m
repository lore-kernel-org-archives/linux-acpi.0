Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AB41B8C8
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229781; cv=none; b=e5AlYHvaEksYKykUiIJH2OeFbZwxnUAgKuVXIRnK2yR1n31vEo8Kst60zox92L4L6HmiDMp5M3sbuk+rExDWT7r9FCuCHmoBYVdTEJXKoUY7/q6606Dxy66wBcm13fQV9j/MXSHwLzR+Y7BE15087OnuYmQq/+yBfycKCdnft+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229781; c=relaxed/simple;
	bh=/myIS9UDVtLxMamx56QhAR/KuoQd4dKDFh1SeQgTmt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4l91m7Ab4CETgxlrUZHFXY8KPocm1zhUij4P6HYBAbK1AuelY8/tn7VXF+TmzHIyNnY7dDuaE9BKI4V7kAxhNpfWVf6u9zeM99VG6DtDWjWjzW9I+YzCk8t+ENIJJPZ5qKXAf7Y/s1QTDGfFS+dW0wJhxUpQc/oIpexWi+tSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGKkBq5J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGKkBq5J"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8484f229529so2467824b3a.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785229778; x=1785834578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhsOgJYTFPT4WrpaQ/dpU3Ea3WUMBkyN/iVdfCKxIuw=;
        b=RGKkBq5JOX/shhovgMAqqnQdMF6UlgNgNqfwPuhPu1UYfkZ4r4rAsxg9Y6ECA8UYeL
         C+wkcqn/LLA7Lk7nCi22sX54QuV4QH1e9WouuvtPLNDNM/7r4M8NZNOQRnBNWmCB0PeE
         +5RYhMR36ycJrxgp1H3go8SvzgavEUcl1JsDNg7nDYpu8LXP1zIwRCHMbJI3ayr4ZO1F
         bZ5OngYjpoptKIKmhR1gQV//7H7eYM1p8qZ5qnXR1QCv5MLZevMs4x04Swb7yNFCdj/N
         3KDqZpYU7v1EtLWkUY2xiLbCsIRrQJuVgYRFhZ8+RkMyNwbW5c+51dPcyFYi1sPvZ4ZQ
         GeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785229778; x=1785834578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhsOgJYTFPT4WrpaQ/dpU3Ea3WUMBkyN/iVdfCKxIuw=;
        b=kZsBR6W7WL+beXR0Qe/YRwHsc2qh4D2kxbQtYcrfhrwNtXRr1mi2x3Hesh181Xthxo
         SnH1taSZqXfWrLBXq4ijsFpafsV01bfY1mwTyXoQzrTkllYiAsm+/Uq+2+s5xjEIc08S
         xSo+ZtPLgRpp5BcrLLg+7QP2gmPesbkGb8TixlLRLhtbzFdLYrrSXCOaGDSdltBsul4H
         NIHoNIYmYSOYlYP+IgDNbe/BFmi78TiSJQHyzXuDnkSZW0KtxJq1JK8DxrHrTljKiy6G
         eRsib9mvgDbEl7J0Wd8ArJW4dpMEcTwciKW4+jP598Mswy57rR+5WFBdAVHDlR8QPv+v
         qH0w==
X-Forwarded-Encrypted: i=1; AHgh+Rqyjs+ednNIQFYMFZ9Oi/5HF6GDxI2pnpo3OVaG2c2HoyQuJi2t0e0R+iNaQGOowTGSXTEWrfq/gqRc@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+wYEN7zkEgeeTUfZmsXhICRZmfxKvEU7JUDvqPlwudlJG03a
	vHSMtsmiLszegrv+xNBPVdcBHKBLZfznV1ECvnoyH1nYx+1dipXvI+RR
X-Gm-Gg: AR+sD13XAZLjndqKBurKGmy16ix4FOBxm+FJhC2dQm837TkMoDy6OI/acEWBdCFeava
	4pZPt2eipmWdTHEZVlFnsJhg+561DmVbkOCPpbQRPXxOoLPDnlmE8k2Tc2zgqGKL8G8CLCPvm/t
	HpQfcfqx2hucCMHgaK7OFUGPtu/3n6yw7ReQdWC9ZkjaqOaShM/83Lp/siE4UQXJwGH/7ny7ExV
	FKs5KReWTaTcjxWYkTq8XrcgA5lqpTAYlNTc4p5fiJeZpoycAjSkfj7ise5Uida7nXnu5t2nLZB
	NHTcr0WRXYi8Kd59BnGHmHQ9ry052H1ybClokpg02Vl+O1KJy4MOFRpE0MxBFd/v4Il6l0dXomq
	iRqogDwtg77srSSmhuxvqOYvadv6JzGR0RaoSciYGggvLgL2miF4amEFpRKDdLD60C/ifjLeLfz
	wXApCn8KLOp+bAzu2ttaNaI5xKLQMZ5DHV65UZW7HPmNLXhjau7eYw554wSeJs/tjadOaJlZj8c
	2O0rl1merYiK5+3yH/lzrGG
X-Received: by 2002:a05:6a21:6083:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3c8aafbd404mr1936218637.6.1785229778044;
        Tue, 28 Jul 2026 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1285sm44086953eec.5.2026.07.28.02.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:09:37 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: APEI: validate ERST record length
Date: Tue, 28 Jul 2026 14:54:30 +0545
Message-ID: <20260728090930.31589-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

erst_read() returns the advertised record length without copying when the
caller's buffer is too small. erst_read_record() only rejects records
shorter than the expected header before inspecting the creator ID.

An oversized record can therefore leave stale or uninitialized data in
the destination. If that data matches the requested creator, a caller
may use the oversized length and read beyond its temporary buffer.

Reject record lengths outside the supplied buffer before inspecting the
record contents.

Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/acpi/apei/erst.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461531..2fefef65d674 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -936,10 +936,10 @@ ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
 		goto out;
 
 	/*
-	 * if erst_read return value is less than record head length,
-	 * consider it as -EIO, and clear the record_id cache.
+	 * If the record length is outside the supplied buffer, consider it
+	 * invalid and clear it from the record ID cache.
 	 */
-	if (len < recordlen) {
+	if (len < recordlen || len > buflen) {
 		len = -EIO;
 		erst_clear_cache(record_id);
 		goto out;
-- 
2.51.2

