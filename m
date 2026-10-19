Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421829;
	b=BoaU54HUQS5MHZALrOvNgEHz8IlijgL1skXaGqISEn7DCmeYlBeIs/d1fKIwkkly97lA
	 zsm4TttDfYNil3ZVFzjccmENcaHxLZAZzji/XwFIJ+stoFfvTI+OrkcJs/RFz/jTluKJE
	 ettQ6Dbc6yDlkRX3rTj/rx4lD77ehCQg1ci9Zzg//2MFB+WZSTzFiJ7JgzCieEKqDiVjC
	 4NAfMAUjF3bYx077mzqvIR+8Lo+MdUhtal8WQZrXBguGV6GtkE4v4rWEgpRILsCDdw2ga
	 E4S9L132TYsgnMQE+ENmU6EioqyUdt1u54DQhLEyaTLLWYUUGqNnm2nITkxNWvmfpyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421829;
	h=Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VCgwC73CEIkR5p1wAPzHafgllwFVQaoLyQhXqaXGVnk=;
	b=dRY7RYev8/gaGOgIEOS5RAxDD3P7WmUSOir2aYt4KP16gQsbOtIlpSM8ZaOSGZRp4LSv
	 h1TLZdyl0rof1GqRKQhW+fXAsN7Mgo0Ur8Ht4wue21l+agNUYLIqSS4Aa/OV/T16PmtR3
	 h51Oeng0uMrdOvDldFpMa/3eStfVkeyXbX1SDCmlH9g6yjUL2vjbQYZCUpWF4dEYmqR6U
	 27Ma2ZcPuakwQ8LlvaJ7mV00UQAypPD/ko+4v9CQzC0+xtZXC30OWo5VlBIJP7NS/AyeH
	 OF0oNUUaUJ4p79FIsLp3Q4QNWEkzIDi9ZOSVWYYXz9FVSkf3IwUU6QTgQkFTn6q4nkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kmO6KxO0;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE206074095;
	Mon, 19 Oct 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kmO6KxO0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7FC6513FF;
	Mon, 19 Oct 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421829; cv=none; b=fdS1wquQYSdBMqJm4rspcZC1A5mpxtYDrwC8cO/MtR4gnMQGW23/1mB1+2vczzFKRwNQSrRCM8AR5TkNJYd/Bg7C2Jbs4Tmitf+iS7LcdfWoQz/dbaMKquQiQdF8g+Wacxu2T/l/gzKAXB+I5AAKoJXke6mZ9Ic2zsDoHWNqqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421829; c=relaxed/simple;
	bh=YlaWlYaZIkAnlD2LKt78HyIT9RVMdmLuS6Ccg2ZGCLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtf8ti1aauayl3xP1b0silwqDJCiE7sepjGYUHawEqQvW6Qqwg6H/pmSdRxTUHERKFmEA1vK77GnNDAWnoEWy/FOQyJZOSp+9av45LtHVID9g51yXTygk0JG6b7q/nZlF4Qp4pdExvpni/QDd0W4jcbTNjrVHDXZId/U3YsI1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kmO6KxO0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E16E1D34;
	Mon, 19 Oct 2026 07:57:04 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99A763F673;
	Mon, 19 Oct 2026 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421827; bh=YlaWlYaZIkAnlD2LKt78HyIT9RVMdmLuS6Ccg2ZGCLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmO6KxO0EaT2UX7XQwEqVTYJDoqisGCaBNf49e9mWIIU090eRvJ4LbuYMZ+lkWJ52
	 jh8Sd9Z7Tj4QgtvLHKai+ACKt9MPl+sdTOou5BpHyBQ+/Ipgfl2HZRRdL+EU5KHJjH
	 /iM9CYyMaNTNhJwd0oCJ7A1AYKHeB2nalvjwIcsQ=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 1/6] ACPI: extlog: fix extlog_mem_event build issue
Date: Mon, 19 Oct 2026 16:56:08 +0200
Message-ID: <20261019145643.1877246-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019145643.1877246-1-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_ACPI_EXTLOG=n and with the following command:
make -j4 drivers/acpi/acpi_extlog.o drivers/acpi/

trace_extlog_mem_event() is not defined. Add a extlog_mem_err_event()
wrapper to fix the build issue.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc..e764d61f71ca 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -180,6 +180,15 @@ extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }
 
+static void
+extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
+		     const guid_t *fru_id, const char *fru_text, u8 sev)
+{
+#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
+	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text, sev);
+#endif
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -229,8 +238,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
 			if (gdata->error_data_length >= sizeof(*mem))
-				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
-						       (u8)gdata->error_severity);
+				extlog_mem_err_event(mem, err_seq, fru_id,
+						     fru_text,
+						     (u8)gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err =
 				acpi_hest_get_payload(gdata);
-- 
2.43.0

