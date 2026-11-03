Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706136;
	b=pjg9lY7HOc7uZ4VyNlfm/1NnBMZvCqqaiSQJK9k25FHpP3jffjZEEnctBL+kGb2A3Xrh
	 2HEx49pak9ez5/CVroKBmucCG43IAl9A0CoFYLsIgyvMbsmAgtLOE6VyDcugMPRVeQvV9
	 4iJwpGx7XrJVLVBkluLVMLQ2a3IoXU/onwM+gmKPxi/r0X+FNtapXvyp+H5+VQa8TzIXz
	 8NUL5QpkiDescY+TY29Y5AcwmTcrmG8cXw3RM5VHTqLnSX5YZg771zuWDapybWmcC0YxU
	 z7PogpMybA0Zepm7WNci5EDFOI36HSZ1grmGg/ar12hXCT7DMvfEopSHUq90iikQZ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706136;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=WV+2t5wqIYEQvXK2Rast9/aDo3IHy4gV7z6vylgzovo=;
	b=wDfPRFXDK+RggCkmEjrsNeGThBs0K9Ym9FFbDKWYTDgT8URVJIFe/Kk8qKIDVt27nCM/
	 nIBvMAlwzfoKLC5YHn6H3TPMLPwEcKx6TjyitG3c2ZfewYgpp0yk1Mdabyk6aTsgU9uC0
	 /ttJdiFqawfVXob5txwRCGIdFKaalb4X9Lhx0Fz6ZVKKfaPxHFCzHuz47A69/ZP29c/2d
	 qeW7MDash5w5GK2WK7o+CHBmgUZbHKUl7evCr0GnjbqH7O+EztWUgUEOfnLgGyJ77MT0h
	 pTdTCcWAerGb1jkcUWhr+jkqamt14MQcMJeqe6glSYednnSbpC98ZstTNqNzEaBHyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=Sj7xWwq6;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17256606D80E;
	Tue,  3 Nov 2026 11:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17256606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=Sj7xWwq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706110;
	bh=WV+2t5wqIYEQvXK2Rast9/aDo3IHy4gV7z6vylgzovo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Sj7xWwq6rpTsw7G0RbFh63jpooISS9/7ydNreQwUaNME5TYSWhzvKxS8DG8tmgQIi
	 7oOFHHYxQpHQ8Aqd0ayCqb3nuwgIQ8LiJDRoTX1uZHLNTisF+LFW3xD5wGVuD6MI6I
	 Dh4oYxDvVh8hloh0k9jqkGc7lA204a1GMkqcl7pY=
X-QQ-mid: zesmtpip3t1793706105t830f9496
X-QQ-Originating-IP: wCfvw9RnZyrVWyED6DkmN7Kjyi+e5x1KAmHM3pYT2Ws=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1704270922219163477
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: property: verify nested _DSD packages
Date: Tue,  3 Nov 2026 19:41:43 +0800
Message-Id: <20261103114143.75756-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: NRYSeI3Ux+UPc1P43lazSAW8+8UiMVTZhPe9rLGkVsqzAVWephcV1KrM
	N0sYlyu3cknamDK6rZAS/pRLKxm5Rdx/3zfDjAxbqRWEmKOU0vz4Taf6h1zAJt7Pv1MMqvm
	61evJDMUOvFB1fp72fX/9TdaSTyubXoHlqsv1Q1PYEgBbSo1Qmv/Fn4PYJP59i4TmekERdS
	zaewbNVUvzavsNHHvl8keeNdPIJf+EaT1hvsdwfHIrAd2Sua4aqASsD9yxQYwgNx8OfUqQG
	4vK35OsI/gw0O68KAxEr7mdN3teNdDdRBBKIs+iltmtnCpjqqCAzAHQIQLhlbhUidLRmvH3
	qPwdWC/S/Pvll9XjKxDOTDO+qk9vX3DAlMMsXzclIrjhVRQ4q7hZfhr50tfBiRKaNWTREu5
	mxpbFWmfxLB/cF1UcJ+YzYxKRd97yR7ekqRZxgHnli8x7QKFrnD03nF100WKh06PvrmWFys
	aYBrWzm2srVSNXEbTy/KK1Hcvb9Knek1zOkIWueOIpgI22lm2CqiovS3a8UawWM1L4UHUtR
	M1L0aLY+MtsFYhb4/MjCUlvqn2dzd+6/G7wYO03/xDfISorzb/SevL9/Yvc6M5JPoDMBEYO
	7qJ21WDMx7cfwBsGF+LZywNd5LM/w9C6gfOUzqrWm62j6gwISbfQhOs0lhg7tOH2yZCqxZU
	ExN10Xn68YOsgavVJ3OXOME+2kgj/+RQBI/2g80PIB3aNaYaR4wERM4m94gJWtLQHUiDgbU
	82g1hmJC95XZXnoOJJKyMVtXwa+QQUEjfWmQf6hbpBWNgf1R9Bju+fNVaWS/VCwLM43Kru2
	uNUg55p7HFV/oKBMjLXwqY3hrkup2C7ocYGrA+BY1P/TuC2EsM21MmbFCVx7zPRYRwfsnDt
	17dr87mkmf0ZQUdMxnXmZNRupuyoA1SDrygcCVHTRoGg7k+Z/FAOy+NRvUUMCSeZfgzMPRx
	oe8pytMLGDEQ53yFePG635DXEh4Dc1s9DV0J3K2uKIsYxIbj7ZZcTb8wetLoDqpAP0ODcUr
	qIKjngvdbNR3S9KpGa
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

acpi_properties_format_valid() and acpi_add_nondev_subnodes() inspect
the package.count of nested elements before checking that those
elements actually are packages.  In union acpi_object, count aliases
the length of a string or buffer, so a Buffer(2) or String(2) element
passes the two-element test and the following elements[0]/elements[1]
accesses read past the small allocation.  In the non-device subnode
path, the resulting string pointer can reach acpi_get_handle().

Test for ACPI_TYPE_PACKAGE before using package.count in both
functions.  Also require an even number of entries in the _DSD package
before reading paired GUID/link elements.

Fixes: ffdcd955c307 ("ACPI: Add support for device specific properties")
Fixes: 99db5ff7fe0b ("ACPI / property: Hierarchical properties support update")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/acpi/property.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..f5e0dc87edde 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -194,7 +194,8 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 
 		link = &links->package.elements[i];
 		/* Only two elements allowed. */
-		if (link->package.count != 2)
+		if (link->type != ACPI_TYPE_PACKAGE ||
+		    link->package.count != 2)
 			continue;
 
 		/* The first one (the key) must be a string. */
@@ -262,6 +263,9 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 	int i;
 
 	/* Look for the ACPI data subnodes GUID. */
+	if (desc->package.count % 2)
+		return false;
+
 	for (i = 0; i < desc->package.count; i += 2) {
 		const union acpi_object *guid;
 		union acpi_object *links;
@@ -331,9 +335,10 @@ static bool acpi_properties_format_valid(const union acpi_object *properties)
 		 * Only two elements allowed, the first one must be a string and
 		 * the second one has to satisfy certain conditions.
 		 */
-		if (property->package.count != 2
-		    || property->package.elements[0].type != ACPI_TYPE_STRING
-		    || !acpi_property_value_ok(&property->package.elements[1]))
+		if (property->type != ACPI_TYPE_PACKAGE ||
+		    property->package.count != 2 ||
+		    property->package.elements[0].type != ACPI_TYPE_STRING ||
+		    !acpi_property_value_ok(&property->package.elements[1]))
 			return false;
 	}
 	return true;
-- 
2.34.1

