Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706148;
	b=WiVHjFa1VzxTpyDbbuNYDk22sWZoBT6ZlBvm70X5uAs2t71iw4J/Nt5h4Zy3ISxpM3tY
	 P6RqDVf+C2iisnU7pve76uENaFN9a6vPB5Wgz/jit4mhj2RZhKQHMJq9qKPsCi5DK3iYR
	 AeYYRVHVMRXsli7V94OpzlWQbZMjQNC9sTsPQCcvfSOlwQ/k8XctA2hkO3a9FwZC4zyzE
	 +CjPOhsXkDGKcrDl1WIQ5FZuVmTG7E/7TVHVpqKZgH8rhVRy6JzowQ5QZhhmiKWhDEfRu
	 7paF5nT+HpigqMQkEXwVQ9I/eRioKMdQvuXvyU755D4N1cnZUhliK0p92o4k807G4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706148;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=nBjLutV06GCjyZ468QVvrXnGy9+G8niQ/DRLI4NdwVM=;
	b=ieuhHCHqh03CsxgMj4bst8giVApXC2+q+PDDIQDVjQjDELdxHd74JRvIz4a7FlYjeoPh
	 5UepGafNPdkaC75zSzmw1NVEpuB8jFTcMvlgwUZ5QtPWGMd74G8knKibX+fa7u03vJ2eR
	 rHo8TgetBbKbn/p90dFXk0MCGKvi/Yy7tsNGrTpBDiEisYJyh0XXKPSKhowrMAon35X4v
	 TsE78sHTrbhfamAYE9GP5RTlKQH33tsg5BxJvtyiEi0W6aLC11Gzcb710kaNUFQxI3Ktd
	 NZUvR5zR8Mw8b2tajh1cq3WYQxoYXvevbzvlhr47DuqQxihs3P7gvFBfobw9rH/1hDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=ZD2NAtna;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19CA606EE89;
	Tue,  3 Nov 2026 11:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C19CA606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=ZD2NAtna
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706112;
	bh=nBjLutV06GCjyZ468QVvrXnGy9+G8niQ/DRLI4NdwVM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZD2NAtnaql957jg5fEQMzwp7pMUjtxVE1Yi4395Sr9vk6zjkGutb5BESwAfUKmdKv
	 gVQbkQDd8AQqdELHpcVX3dybMVCC+0r3oJkxodtctxlmaejJ6AJdfJNyDW1oHqBo2k
	 Xmd9fe11PyqGvDWGBsrC4NkfA3G73zGyyqt8ncJo=
X-QQ-mid: zesmtpip4t1793706111ta085392d
X-QQ-Originating-IP: RFz0t0K9zQcM29B2jlMJtyHx68cxFrQ7MIrgtCL3pL4=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15564578138357114516
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@suse.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: ADXL: verify component name types
Date: Tue,  3 Nov 2026 19:41:49 +0800
Message-Id: <20261103114149.76010-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: NXJos0iVVM8XK7Y6GpaH/bWqNwYx90fJ0x+zbQOviv3ayGPF+Pzbv9uP
	c6PbJyDbW9Ww0LaEgaAC0UZ6OXS6ZeJz8PAO+W7M2PaaUUJ3TsTCc77v6/988roAagOvXwi
	WHuv4Piq23N2AoFEwYls4PxKlpAmkMrA7InyRRpUs3Bu5PfBdBJTDioZN/jtogvJh3PE3JW
	SdDwmsIwELnvWEp1UE9DAKRyitN4lNlz/6piM8nBuuIiVkDVzfRmqAtGVr+fo4mnlAwsW0S
	ylUxQbTkbgVAdCuEF3n+AYKqCmNckM+QIJ9zZMuRSYQp+guUJXyoVOC+VgwTokZKD86R9zT
	OHaSFzoPdoE7SFnnWCBEI9rGjtb6+4OY3CFYN7tozSk9d0EfF7AorzuyZqHivfTCwmW8Vhi
	NVAcuvsBivw55TM0Dq9xCB1KN63IVWBJg7L+KKkAGRKy2yjnoKs5Uglhfm65apn3w9PUKKr
	OV6mVy5SV2kFkdhY4bLsGmTsP7asmTysS0GuuOM7qplEynQFVrcnreuSLAdkuFtDtl4Vfsh
	+fka0csLo1KJOafHdGnTQsc1weUN0ErvQzoPK/onS8wNsg/f0Jmkbtw6ptDZzt9Xhz2p30g
	19R3Z4VrWaLdod7omobhrn11iSGI84VNSbK1awNk8/CUjwDqNsYIz3fzoDtXhZrSRwtnx25
	lk30EYAnNlqs7GWenqhCgHw/Ak2GL7Q+FYPbEieBDJanakFDjI6Uxb4/lAyw0jflXig0Fbo
	96oy2Wl9cfnEV4IA23MjLlVdypx02MajzKrVJBKVflxJFZrTfJgMObL8vvlfF9f5ilOOhZN
	mVDyKgHpU1tw47XYHbajUKzM3UaROLsP1uRaSYGxdbG2I71iYjjVF9n5HivO0xbhzoQNgEn
	Gco39JFKDu/h3b+y+ea8v6jIxKNyHgtRb04q1N9GqSgzvv2MywqpY3Qsve71Y4T3Pxwz2Z3
	gOtNyp6YNzOvEiYIfYU+DKfxtLSbr8bZeG+tw27VD6TQZsFY7IWl2TQgGwih03e7Vi1/0S6
	G8hMk45rYiWtEC04vTrjP60jKCxtd/U0TFEmBcFQxKS/cohw/WU853kIvQZ4Y=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

adxl_init() stores p[i].string.pointer for every component name
without checking that the element is a string.  An integer element
makes the pointer the integer value, which adxl_decode() consumers
dereference with strcmp() and %s, causing a wild read during boot on
machines with an ADXL object.

Reject the interface if any component name is not a string.

Fixes: 4cf841e39850 ("ACPI/ADXL: Add address translation interface using an ACPI DSM")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/acpi/acpi_adxl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
index 13c8f7b50c46..de646b312eba 100644
--- a/drivers/acpi/acpi_adxl.c
+++ b/drivers/acpi/acpi_adxl.c
@@ -184,8 +184,17 @@ static int __init adxl_init(void)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < adxl_count; i++)
+	for (i = 0; i < adxl_count; i++) {
+		if (p[i].type != ACPI_TYPE_STRING) {
+			pr_info("Bad component name type %d\n", p[i].type);
+			kfree(adxl_component_names);
+			adxl_component_names = NULL;
+			ACPI_FREE(params);
+			params = NULL;
+			return -ENODEV;
+		}
 		adxl_component_names[i] = p[i].string.pointer;
+	}
 
 	return 0;
 }
-- 
2.34.1

