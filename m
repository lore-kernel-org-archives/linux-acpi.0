Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056465;
	b=OSLJ2jhqpTfM6O6DAgF3I5Nn1hcomnS57dG9bLlMsllLNAS2wKh9hR5SxqNGEGWAYmDb
	 zGzaV+SpAVegMCLr0W2jMieGgpOwEHqu/6rXPvF/c4urrYKBB1vgtGMRKeHHRmFVFoZMe
	 mwdolTmLP5+xjmfgAbKnVcPFa8v9BM96O8GAZR7I0+zFl8GHjrcdSC6bHbwtlG0ZQW5to
	 m/ODmtiaB6aR8roZcDTjKXKgXxMKISKm2qx4EXOdrRwspnyr6BOv8pLbIP75tqR4bVGZl
	 p04wrqUKnaJCSq4Td1aZVMfdZfxyj2QKMyuYnQ5bot64I5dediFvu71ikAPrbgm45gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056465;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=l+YghEqCnRRjIq/8XXkjXQQcUdPpbOQkxuLMr0/VHek=;
	b=23cgTkIZ0M5bUmEsYixKz6qe0zmJ9XmiBZWmcCf3q+LHuHHUNfv87Ki5gpzXsd/fzRxW
	 FkVOw9EhxIxZp3uWnT6ekjH/UJC+oPyEtprpIUat9gpc1C9kKODAs7kq4adpngyDsLFKh
	 9AwPU+i9f8cbnFNPEPQcE+rQHPpeUtFmnxsPG2suZAgOd8TFm7jA5w8LyaNh93Ln79eDu
	 PzP0ShUIBhx0WMS2dM7WFgRoYiXKGUDwkhqfWW/cHK02O/HrM5E0DwFYuAXegV+inczbG
	 fwAkRTNHNGvEnBEt4o6hHwOIXb9L7w3BFr76JMQdxrJk8xUyWHFtXWkuDYHIi05UclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6F606A32C;
	Sat,  7 Nov 2026 13:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD6F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jMGPm3t8Kz8XrrJ;
	Sat, 07 Nov 2026 21:01:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A7D0tOr090908;
	Sat, 7 Nov 2026 21:00:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 21:00:58 +0800 (CST)
X-Zmail-TransId: 2afc6aef210a6d2-ae156
X-Mailer: Zmail v1.0
Message-ID: <20261107210058841pJqeakmrIVxw9Uu1aqCHK@zte.com.cn>
Date: Sat, 7 Nov 2026 21:00:58 +0800 (CST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>
Cc: <lenb@kernel.org>, <andy@kernel.org>, <westeri@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <rui.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJOiBscGF0OiBBdm9pZCBkaXZpc2lvbiBieSB6ZXJvIG9uIGRlZ2VuZXJhdGUgTFBBVCB0YWJsZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A7D0tOr090908
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 21:01:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEF210C.000/4jMGPm3t8Kz8XrrJ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

acpi_lpat_raw_to_temp() and acpi_lpat_temp_to_raw() linearly interpolate
between consecutive LPAT table entries by dividing the difference of the
other coordinate by delta_raw or delta_temp.  The table is provided by
the firmware through the LPAT control method and
acpi_lpat_get_conversion_table() only checks the package shape and the
element types, so nothing guarantees that two adjacent entries have
distinct raw (or temperature) values.

If the queried value lies between two consecutive entries that share the
same raw value, delta_raw is zero and acpi_lpat_raw_to_temp() traps with
a #DE exception and oopses the kernel.  The same happens in
acpi_lpat_temp_to_raw() when two adjacent entries share the same
temperature.  Callers such as int340x thermal zones and the Intel PMIC
opregion handlers pass firmware-controlled values straight into these
functions, so a malformed LPAT object is enough to trigger the trap.

Return the endpoint value instead of dividing when the delta is zero.  In
that case the query value necessarily equals the shared endpoint, so the
other coordinate of that entry is the natural fallback and no interpolation
is possible.

Fixes: c55d62820efe ("ACPI / LPAT: Common table processing functions")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with a TEST-ONLY hook and
initramfs, booted with oops=panic.  QEMU has no Intel PMIC or int340x
thermal device model, so the hook fabricates degenerate LPAT tables and
calls the real acpi_lpat_raw_to_temp()/acpi_lpat_temp_to_raw() at
late_initcall time; it is applied to both kernels and is not part of this
patch.  A normal interpolation runs first as a control, and lpat_test= on
the kernel command line selects one degenerate case per boot so that the
unpatched kernel reaches both:

  unpatched (two boots)                patched (one boot)
  raw_to_temp(50) = 200                raw_to_temp(50) = 200
  lpat_test=raw:                       raw_to_temp(50) = 300
    Oops: divide error, RIP            temp_to_raw(300) = 10
    acpi_lpat_raw_to_temp, panic
  lpat_test=temp:
    Oops: divide error, RIP
    acpi_lpat_temp_to_raw, panic

diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c
index 6141c9070eca..9090a83e0806 100644
--- a/drivers/acpi/acpi_lpat.c
+++ b/drivers/acpi/acpi_lpat.c
@@ -37,6 +37,8 @@ int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
 
 	delta_temp = lpat[i+1].temp - lpat[i].temp;
 	delta_raw = lpat[i+1].raw - lpat[i].raw;
+	if (!delta_raw)
+		return lpat[i].temp;
 	temp = lpat[i].temp + (raw - lpat[i].raw) * delta_temp / delta_raw;
 
 	return temp;
@@ -70,6 +72,8 @@ int acpi_lpat_temp_to_raw(struct acpi_lpat_conversion_table *lpat_table,
 
 	delta_temp = lpat[i+1].temp - lpat[i].temp;
 	delta_raw = lpat[i+1].raw - lpat[i].raw;
+	if (!delta_temp)
+		return lpat[i].raw;
 	raw = lpat[i].raw + (temp - lpat[i].temp) * delta_raw / delta_temp;
 
 	return raw;
