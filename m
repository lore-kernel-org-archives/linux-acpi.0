Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318254;
	b=yOw3bePmt09tYQMi8J2+3nGY7lCbQ9v0YRiJLxfClpxgPkP/BEeTWig8kuv7a/dY0yG6
	 C04gch+RxtYwqSy6DQQA0jw8gSffocHd5ifZ6nZGUGynAg1zi5AktaPk5d21OLdKWYi1o
	 AXn2LFgKZqKbUzsJNgS6gyOObb04ej7kiqsln6Y0ypWDIohq8/EjAM0yZfUq22WqEd+u3
	 iXPlJQ+imWVMq6vh2kQHtQh/lGcHdlTJVOX7tZ8l9u1PUUkzqw3sWUVh+vETnhPu9NR9F
	 lOpF6ldOjML4RA6C50RvYXpLhHwzXs7K2JoLkxplhFafnlLChhM/FuFUMPa34jZ9Akg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318254;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=/8eG7V+IcDdBQXwPQjy8Y/TEnkXIzPepTQcL05EXyfs=;
	b=Um/k+erYjVHAUzjGZqQjvYfyBqPiKP81SRz+QhhxEIS09iyewZWMZgt0oPPWEi8Zux1e
	 r0NbESRy5Mu7gCOwXBpcn2Hfxp/CMaUCbTXecRMTnWzzcD67mwMCW9KXJ+YOJNEUQfcKY
	 rN+S3+gPLN92jDPA03PTjH0h+4YaRpbil9H3JoJgV4gIrqJL5Igk9UKK39tzZjeqjGAp1
	 Wmccr17r1yw9jV20GckTfsR4vx7Nl7YNsfFLdR0VFteg4ixWJjmaVjd2tltfUzLZ4J5JD
	 CsgNG4udnxbecvRXnjcpUBVj/1GG+DItTKy5eTPmsAzNDxWEiG+aasT9mJJVhcN/Z9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B0606A325;
	Tue, 10 Nov 2026 13:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB6B0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.97])
	by APP-01 (Coremail) with SMTP id qwCowACXwfubH_NqRy+3AA--.4075S2;
	Tue, 10 Nov 2026 21:44:02 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Tue, 10 Nov 2026 21:43:54 +0800
Subject: [PATCH] platform/wmi: Allow consumers to load without ACPI
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-wmi-no-acpi-v1-1-eebea07db551@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAJkf82oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3fLcTN28fN3E5IJMXUNTy0ST5DRDS1MLAyWgjoKi1LTMCrBp0bG
 1tQAnfNK4XQAAAA==
X-Change-ID: 20261110-wmi-no-acpi-159a4cf19580
To: Armin Wolf <W_Armin@gmx.de>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowACXwfubH_NqRy+3AA--.4075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18XF1kAw13uFWxWrW3KFg_yoW8ZryxpF
	4Utay0krWrXa9FkwsrA3ZrW3y5uF1fu348Wry8C343Za1rWw1kW3Z7tas8XF98Jr4xAa1S
	yFWkGay7ZFs8ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb_Ma5UUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBwIHDGry2F7bZwABst

Since commit 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from
nvidia_wmi_ec_supported()"), the ACPI video module uses WMI on all
architectures. When ACPI is disabled, e.g. on a devicetree boot,
acpi_wmi_init() returns -ENODEV, so the wmi module fails to load and so
do video, amdgpu and radeon, which depend on it.

Return 0 without registering the WMI bus instead. The exported helpers
then report that no WMI device exists. Skip the teardown on module exit
accordingly.

Fixes: 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
Tested on a HiFive Premier P550 booted with devicetree and an RX550,
with ACPI_WMI, ACPI_VIDEO and DRM_AMDGPU built as modules. Without
this patch, wmi fails to load and so do video and amdgpu. With it,
wmi, video and amdgpu load and the RX550 is initialized.
---
 drivers/platform/wmi/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
index a99da9b7039d787ce3c1e0ece74ffbd79fafd3f7..6668789904a903c8d4e7810976f4e485d7a1b32a 100644
--- a/drivers/platform/wmi/core.c
+++ b/drivers/platform/wmi/core.c
@@ -1598,8 +1598,9 @@ static int __init acpi_wmi_init(void)
 {
 	int error;
 
+	/* ACPI video still needs the exported helpers when ACPI is disabled. */
 	if (acpi_disabled)
-		return -ENODEV;
+		return 0;
 
 	error = class_register(&wmi_bus_class);
 	if (error)
@@ -1628,6 +1629,9 @@ static int __init acpi_wmi_init(void)
 
 static void __exit acpi_wmi_exit(void)
 {
+	if (acpi_disabled)
+		return;
+
 	platform_driver_unregister(&acpi_wmi_driver);
 	bus_unregister(&wmi_bus_type);
 	class_unregister(&wmi_bus_class);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261110-wmi-no-acpi-159a4cf19580

Best regards,
-- 
Han Gao <gaohan@iscas.ac.cn>

