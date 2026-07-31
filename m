Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146C36B07E;
	Fri, 31 Jul 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480237; cv=none; b=Iq6h5lcDnoVh7b2xQH4jzoQf8Cx1Bet0OPjefMIu1h2t8jhrTSw4MBBT0yt1APYbSHe7JuGE8d9suCp6ZF0AoAnt4boVy+FMLgJjc23R2m1F2GqzCcEt8SX0jNgrqRqBR8p8Wnu1AvLaCZ27MvaHCUYXqGteMk3RPdiGSlaJYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480237; c=relaxed/simple;
	bh=/cOsnaRhOcIFwY6omEbRyXYCX3LyySZ2HNmMT3qsEqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEmqb5/23Oc3eM9+OeaDleXWLN/bG/jOqqJ5xPFo74Jt9cGdHCnVTezP1zUUKVi+mmPeJKeF7AtmxnLWE6070NMt4ZydEv/4s+5AimKBYT4Sn2jEpMpaA1mDS0gwS15icFlTaelYKGpmsmtzqHNPYWlXrsA+a3spDNohuefAuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MC+dATxk; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MC+dATxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785480218;
	bh=sqbZPkVIiuKibAq/XHWC59H5Nrjr8DcW9MdOEbErPUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MC+dATxkx9vF919r+T54kAiPe8ThBq+UgHfEzy2QA9DiL+JhcQ24AxqSUsd2uQ9vc
	 gW3c3cz/2396BG6gIbPgnA8hq/CPw0nT+lQUHrMJO+mIhau4D7lbcxUXXA+FNF1/5l
	 Sg0UVWISihjcJydbBa/Hig5duS/oUh3nLE0YKn2k=
X-QQ-mid: esmtpsz11t1785480203t95e16825
X-QQ-Originating-IP: JeUMyCL9oW+ImUdze/+77Vqu8XUGeM4KpPRU/0ilIpk=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 14:43:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10087580991105572539
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] ACPI: FPDT: unmap header on signature mismatch
Date: Fri, 31 Jul 2026 14:43:20 +0800
Message-ID: <B7D368CE62E0C10C+20260731064320.1241855-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQPu5pFEJFN4RE/dkrJolz/CiJ7cDfxbiusX0xMhpd6dS2H8jRTtv7XX
	67yLiKoDmWaZAbJxi7oF6EINNCFpPB4EH7S3dIhvGZzM+WMl6qa2s840BH9TT9oGj3AK2Hv
	MyFhqu7TvB9MMf2HipjC/NF9uyAS74/oY0xoqd9NwTuEkYkN+2xADmigLC4PngUdIwMsB9x
	wrQetlk7IjzCnOHAUtX4ROkwS3mmJG8n/ip9ZECVs/x5EQnR8bdtY4qDKi7N2S4Y4a7iCBV
	v/hdeCkHAggDpOm03nM983hAKjKunVXdQmA/lc7KdD/YJFDTDEjXswuv9u3BR8YjL0+B1st
	f8QFUN1mS3lDOOyfafoPLCbm1BJRozh9ww4WlJAIE3Ku3ANv9iIjL9zg0exmwSJlMtZZCrN
	o5jAaS9AXSMJ52vk5Y0cdqHmZe08YXGIjZXhMUO46l93osraVAiko592rUf4DqTIE5TmZOC
	ePfhn/PL5QWdKtoPkiajWd/jRrbF8PjHLrWzmGoCjv5b0Ph4sPH5dVqYuZOCEVkZ9zq35Mx
	S4s7ilMG9rY0E7hIwKvLZGw+KQ3mbj6lVceLJeHLhH+D9xAGSbzRKhW5A7K1/vOvpNNNZMo
	/kX3iBxcH6zsmAVvFI9Tezk/V3jICkhMqmMjw399dlsxygfc/o9uqET60jjkU/iNx0TGL7k
	h9wfdtna7hQs4lKdg8jRVrsIvUoAxtbi4mcN0IsYDCfsTSlduS8kTryW8fG6bwMBr5rCPap
	tXjlBmaEn0Vp89h3qM90nW97P5Ioan/srSSYOavOIJN5Kt/NE4n8ZAvab86NYyv8tERfOxz
	eTkjfHv/x7/AUqPWkRzMgf0+hNS5/U/gFHFLw5ZpYT8wwgvTTOEMb2iRQ17u0UYb4NW1M13
	/AHdbZri1AVX9BHbea9stos/BBT/6pmTd4lbqVeP/OMLVsisfezkOeU5d+Oe67MuK5gCF2X
	hwfdDsV9BY2wHbJllGYVfTwF86O9q67GMUA4hycGi0D4dVvN4hcxNos+Bqkg7KXtdoVRonX
	N7ZW/tpbv/zOtKmu8hW/CKkfVqpvthBgkiyj2rl0GxB59mwYffbS3XDbvhi9T0IrEkcmu3i
	Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

fpdt_process_subtable() first maps the FPDT subtable header to verify
that the signature matches the type of the pointer record and to obtain
the full subtable length.

If malformed firmware supplies a subtable with an unexpected signature,
the function returns -EINVAL without dropping the mapping reference
acquired for the header. The normal validation path does drop this
reference before mapping the complete subtable.

This path is only reached for inconsistent firmware data and FPDT is
initialized once during boot, so the leak is unlikely to be noticed in
normal testing.

Unmap the header before returning from the signature-mismatch path.

Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/acpi_fpdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index e75dd28d31a9..e2acaff76e77 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -182,6 +182,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)

 	if (strncmp((char *)&subtable_header->signature, signature, 4)) {
 		pr_info(FW_BUG "subtable signature and type mismatch!\n");
+		acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
 		return -EINVAL;
 	}

--
2.50.1

