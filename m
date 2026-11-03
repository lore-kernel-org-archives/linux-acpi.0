Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706118;
	b=E9FereoOb/BR2M5ybP4alKAGd4KhaEOg08vPNgh/t+D4BBvsK178aPsy6pO3XbSNCFlT
	 5iWtP9w+UM6okEs0TydCD3QRzRdkbss5Oear+jWmk8iXj+Xa2MRLI93lvg0UhR8fwQVVx
	 ddnErDzDEl+0fg8BIg5WbF5UdHL705FK0zUlZbtTZLyYOT0ixGzyyrtRQ+d2SIpdohvgO
	 vIg5KpJTB0nQSxj1PM0J2xwf18s4QR99nNuBzkVUWkJ4yIO1voIt0FeOQsi2zp3rZl0yr
	 a64KTPZEcRcV7bZXgK6P3GTS1k/tMur9U6nptwoojEB9P/wB7jWxPktFccB+cB+oSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706118;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=bl7VLTbw4zFPyBK7YJo/tO4isQKuO6fQWlcZcIC2MRo=;
	b=sjCM6arGhHTRFwD+hiwvWp9RqGj0Ji7bFU8+PbFBjTKZ+nZ9dgCmoe8ah91UsSyuSGXX
	 iDqjU2LBfPnamfJnTFPJxUApVnPKv7hxmlxyfJOOZToTVBG0LFJmFyS/3p9F1OL+IV8YS
	 vJn+kS5bSm4c/Mws9apiPyoUKZv0+ciGDeymP5EH+SWTPl6sHmWTXn+kQ6JjLj3Je6Icy
	 fEd6/JeGyKo437h84Cm5L+V/t1aPlryFw+OG2cgQPj7/X4G0a6HOohT0CJzxt64S7ZEP9
	 d70dVWOTFQDZ9ZzNQMxKUszvGYT4BUyQfnUOMhcVSOJo+2MIuBYPYMCJ6rCrkCBvnSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=SaYrgfPg;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AC6082BF7;
	Tue,  3 Nov 2026 11:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5AC6082BF7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=SaYrgfPg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706106;
	bh=bl7VLTbw4zFPyBK7YJo/tO4isQKuO6fQWlcZcIC2MRo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SaYrgfPg0dZsvqNAzEgn9DIkKmRQu99gBzvzILGTTUyBXGmp/fQLjbzt1JzRkTsza
	 2I0ux3ZCS3CUORas1H9LokBx5UM3gM5GLVkWguRaL0cdfWptZmdMqo+6hFdrKxw6pa
	 ZdLK6VO3BVDeIQJA3Lv884iT6luTHQUj33KyNtS0=
X-QQ-mid: zesmtpip3t1793706102t80a49246
X-QQ-Originating-IP: Bl5xKeDauZvF5fjfkTqUKwBOwD9ulAUoSIgmGnY7tCY=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4412879129084576926
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor: check the _CST register buffer length
Date: Tue,  3 Nov 2026 19:41:40 +0800
Message-Id: <20261103114140.75649-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: NuQRJUP0KJGk6Hg/+ooVa67yuND7k3q7EI7MYBZqFfhAjRjyCyOT4iSo
	pKWq5mdYQ8/xjZ/65gCblLNqk7GHBCMsQ3D8K4NsAnDtZronutbpFxHl7mtZNqQnxKGZzNK
	vwZXnCFSJBLOqQuQJDYZ74xnw3wCGGQtm+ghgV+zqEnSactxQICvZbNE7eSeIVVSJsmSzNQ
	kBGF49CTyueZA6uMQo4Dg+ACx2ZMm4qve9+uxU20C/MRpS/Bm+ZDl4oFMPaGLOabAot/DcH
	M4bimTu6YROtOlls+EezaiwVEvunlxm6s4/OEfanTUiayZkSc1mvTBBNJF5hYy0CTgngWCb
	8nUhL2YWg8kkEpTyYRwdwxda8cPotasAKBn5jFlCEReEbva2CieEUNWZb9tPsPRjrNFQDWt
	2BV13+n03N5Qzb+Xjilrap1Y96hXcsxs056Zz5EefEq3ZxVWyvetz56txJ+KA49vQ7j3c4T
	WEh+8gHxZ3AIxaOWN2+f/zEEc+Vw1k+U+9Gi+ZyU+LRx67m2wIHeLQGtvpcf6+91cr+KQcM
	n2lLmO03qpmcEPuTgfE6/CfWW44mE7eV0jE+0A3zAbMFoXfqcky9uTDJ1Xp3gBFps0dn24h
	UO+pWYaNH0UOzrJhR9ycltEfJQ7DKepnPTyTmVPFOY5bY62m/VXBzFyj0EAgIZk2pUw4Dn1
	wD6nLW4xe6obSWGBAKsYH4/wIoGbDSFwiwjwn97QTff91uJXxhCNAdyEoKD9OxPB14zhWXv
	i4nEwqnbuLntPRGzqC62McAqkgJdMNGD9zUB7CZPZKulxdI2gA8I4wqxjyVUcKHtfnxCyWg
	3i/eXHwH0R+4ij8KGKivXowNddNkYaGAGU3xO/GugfC283qPL2f9GXCQoSexwThiYFTUX3x
	WVl1j4pMKCavKKL6JN98XaYvsUGc8vURqhXp/Ml04CPz53kcTAD2CEHG2bd7XWnG33Et/Zm
	+QDZXcOM6j8KlBEAW2skawqRIPooByd84vwSUwKaZTU+JLP6m4Pxdz22vTR4Lr8YE3siIBF
	VmRgYOrJAwccYZWSA5nFKu/gMlvs8RLG3TWd7RMIQC4tca5PP5fU4B0RGhDJM=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

acpi_processor_evaluate_cst() casts the first buffer of each _CST
C-state package to struct acpi_power_register without checking
buffer.length.  A short buffer makes the driver read past the ACPI
allocation and use the resulting address and space_id, which can reach
acpi_processor_ffh_cstate_probe() and rdmsr().  The _LPI path already
performs this check.

Skip C-states whose register buffer is smaller than
struct acpi_power_register.

The check has been missing since before the current git history; the
initial git import is the earliest tree containing the code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/acpi/acpi_processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5fbab54171b7..d77c90a243cf 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -903,6 +903,12 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 			continue;
 		}
 
+		if (obj->buffer.length < sizeof(*reg)) {
+			acpi_handle_info(handle, "_CST C%d package element[0] buffer too small, skip...\n",
+					 i);
+			continue;
+		}
+
 		reg = (struct acpi_power_register *)obj->buffer.pointer;
 
 		obj = &element->package.elements[1];
-- 
2.34.1

