Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706105;
	b=HXMWT/8zPgGxlHybE77jMk1PEb396dwOSVHASlv8JS6rTH4uf0yS11C4YeNha6N4qLXc
	 4ZZHYWcQarp4oP1S6b7AqTvakNHE7M5dfEi8cQk4x2Zr3PUJTj0CyJwcfBDXfyNlBfoq2
	 SazLlSGccxg22PC59aRuxU4oga7x+9MZKzfR4O0tinDQiwspmXwXhhySQHcKfPZm+lWe8
	 Aa1qcRLlqugXgsJNyJM5NM1CjVkJj/xuB08SCjZt6yscdDayi6Tq6vmY3QL0tsDvdye+j
	 55p9drmlm77Y5/8ya2xMx+TP94+ziAN3yNLA/qwVGJU14zHvqnLd7Q1XclbN1rOhKFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706105;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=LcrJ+vMNoTjg4uRtGzESkteVkPhmfOtH+UHqc3pLZPc=;
	b=KRNuE+EnwALh26hIfLFisIiEFrP6Ru89RWIaBOhFEYgEtUahRzlmfKiVaZuGpcvNDOZD
	 +BwF0U9qQ2VZXC+e4nC19BhMLhUTz9yCVSElypdE4BTMIBE7vDHT9z4xDM4NIfKWxHjLv
	 aFKr1m5CU+gtPNbk7cmCairJdPWFuKfCj7G9OQO7JaD1oM7k4w2uXH0OJZfPNBxwhR4CF
	 7kv2AvsjA7k4xP1mshL2u3f4YMww6/sVbqLGO7pDsKJE2IpDn4D3HVpk3/oRnkzf/iCc5
	 b0hFIlgsdBK+USoO6DEoaYHRxfla8GpT7TWQo7WkTeZHDsKexlHrgoaeMH0Rj6FYA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=k98LtYpn;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33072606D81C;
	Tue,  3 Nov 2026 11:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33072606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=k98LtYpn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706084;
	bh=LcrJ+vMNoTjg4uRtGzESkteVkPhmfOtH+UHqc3pLZPc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=k98LtYpnWJbrX+oJoDZHmh6zFPGTnHvyARPy6KmTfYQQG31rhonvi6qiCJO/H6TsG
	 VCqmoiWaY1JN15xSVjFI1JjYVjCaAl/GrZ99P9HgrrnoAlbkVTn5FGvYfabbR8FOrR
	 b52exMIAMf2Bv9ODjbOgx+YX6d5p1COt9W8q3gzE=
X-QQ-mid: zesmtpip4t1793706080t70eba3ef
X-QQ-Originating-IP: +5hLSLUr4nMGZDSvY3IQk+ELRYhn41bK2RyuiEcRuGo=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14287579684144608040
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Danny Baumann <dannybaumann@web.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: reject out-of-range _BQC indexes
Date: Tue,  3 Nov 2026 19:41:18 +0800
Message-Id: <20261103114118.74782-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MIB/1UGyXKa7XkhcLSzvPSildxfvFUQIdw87cUYGHbQpBYQW2HqeEQjG
	rh2JOlBPPQLaTS03vYUXCHh1qiUaM50m19WXDofBKGtUXVaoJTm9/Q06vsNyWkCktbTsL8F
	kVxoygnIzwIdxNB6IoQNZlDCpad7mfV31zL/FZMQEp3pSgqZeeMyjHaPFWPUWqwenih1Jh0
	ilOtDa4sJv7ohAhZp77+MzaHniw7ATwFoA+hnCFwO06o3QniiLCvFqBduuJbRBBeGt9T9NC
	038vVJn5bpAuaAZ/NfHBaw+fb6DG/X31F0M/6v0YI3v92gJbarHj8PlJQ+8zdAaoE3vqTeT
	fISBKnFkGafQ4dy0cd1pnMz2zuifPI1JuTwgEzyx/Zu0T1BT36x224Ld8yVdA6FMz6VrGF1
	9eAwPTG0onsHEA5RzUBbmb+1tU9v9Q6k9I/4U2cOw29y43nuNVp2g4O6lDZlEaPbo2RbeZt
	tytOSGFpFgdda6DBFSSlOOCPMMhhChkBmIUPy6i/ESpAWT1idGs3mXu/xNRjSuDYbofdF57
	m/xlcOTkzvfAU6AxDlpNzaxum0+OU695HoEH6DRmGKcIrTr0pqyXLDswKw+jalRfStmsGIa
	zCLZ0QJLerUCs/5q09l8WtC6ddcLVHdgXrIRilfnoXgXMy0hJP0WMVgzmkKcRBjpN/sFkm5
	AG9cjSz64W/jb9PQ6vOgj/nXKJRL4baHxyrDbOOL/95yB4v47AdVERqydiYmkzfqKAM7uWc
	Ei0jHejwkTLMqzU6mUn+E4xx91ITmjlv5uBKDllFS6MtXzrfxFFs6HGnJmgttijsPYoSo6Q
	VvATp1Fgi9L9iaI7l1e0IT5ojMjtQJ0iNjRrWQ6sOBJhQMkBCKl8EaE4YU/7roSpKPYsweG
	U4gDApcriW4kpHgjZqWSC39KnBqB5YEzx0p1HK5lMxBs9FppW7OWldivLEiLR6nuGOkOSgX
	ngl6ZyALVNrGaZEBLusHCbBVlexMB+659GWvFA9C8cffU5P06UjqiD8bh464k+0E38f1q61
	d5RjKU16Rtd2wUHi9fPqLMsfpo/xTY0Kt1I92DldGwq4hKEU9EaWrt5AyVKmA=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

acpi_video_bqc_value_to_level() indexes brightness->levels[] with the
value returned by _BQC once the index quirk has been armed, but does
not verify that the value is inside the array.  A firmware that behaves
consistently during the quirk detection and then returns a large value
can make the driver read out of bounds; the reversed branch also
underflows before indexing.

Return an invalid level when the index is out of range, so that the
existing callers disable _BQC.  Also guard against a brightness table
with no usable levels, and tighten the range check in the quirk
detection before its reversed subtraction.

Fixes: 994fa63c5b12 ("ACPI / video: Fix applying indexed initial brightness value.")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/acpi/acpi_video.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 2a2822516665..44af7ffb9a81 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -533,6 +533,13 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
 		 * items with special meaning (see enum acpi_video_level_idx),
 		 * so we need to compensate for that by offsetting ourselves
 		 */
+		if (device->brightness->count <= ACPI_VIDEO_FIRST_LEVEL)
+			return U64_MAX;
+
+		if (bqc_value >= device->brightness->count -
+				 ACPI_VIDEO_FIRST_LEVEL)
+			return U64_MAX;
+
 		if (device->brightness->flags._BCL_reversed)
 			bqc_value = device->brightness->count -
 				ACPI_VIDEO_FIRST_LEVEL - 1 - bqc_value;
@@ -781,7 +788,7 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 
 	if (level != test_level) {
 		/* buggy _BQC found, need to find out if it uses index */
-		if (level < br->count) {
+		if (level < br->count - ACPI_VIDEO_FIRST_LEVEL) {
 			if (br->flags._BCL_reversed)
 				level = br->count - ACPI_VIDEO_FIRST_LEVEL - 1 - level;
 			if (br->levels[level + ACPI_VIDEO_FIRST_LEVEL] == test_level)
-- 
2.34.1

