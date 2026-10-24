Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792873568;
	b=mTrIStqx+ouvMRz+e1IoNDfZIZBkaCdqdOvsQjbk8qqBLcBBd2liAM/ZSxULP98a43V4
	 xHWpTKSGdpMvZQP0BNi0ddk3QQaFz9fu+3afpWlQ9KMUNyUQqX8V3WhWqgtyiux8tSW/y
	 ahoG6JIjMGx71RPVScApzPA7w+sDgxaezZCFwTPwOtj7NSQ5WvfM4VKGLzBexwAiBsU9W
	 +9aiqbMUIvU8r2Ai1uOWS7F+3Nm5SBS3iblMF1LBVNDRX5WUkwZhiCa881mcjADwv1QqR
	 5Xk179cpl7/XhfPCgbEW5Ejjr2qalO9a0m1Ld3bFAEloVv4dRFfdP2MQF27WJDjA67g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=gHoG30hc5z3pOlv7X43P6j5V04jBghcXzqd4q4XF6SM=;
	b=JXNJZMmNKgnaXeesWUhRVcgNnSnG22a2Rq8LLji24vUlEd7CS5ec5TX4UJLMsCREBQAS
	 MAP1SmnHnZ6Qz2lYvbcZXj6Uf63VwXE2k9WIqnnGYESPm5tMmgzG3k4D7UDDEZDxEAl/n
	 0oLPjXZaREMXPMWoEF8AWStd8UUB3fvsANrDv8+0GjdPzNbW0f6kIWDtF+EC0PpSbz4EI
	 JSxkdmhfZQm1l76sRH2PPnOZIrADxmEg+1inpjyuztyRAdzmwbMfLOvaxz90yDAEs1h64
	 Ysarbg4hPvYcUfm0OzWAC+U9X8CX9Zs8Hxym3HzhVxO1nxfGvd2Oz9tOsxSwoz3xRaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V0PSNFqM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE24606A31A
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 20:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V0PSNFqM
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso3321649eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 13:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792873567; cv=none;
        d=google.com; s=arc-20260327;
        b=Wyukgfm1a/0n0QUxeY9xm6P2nSghzNZBlFm49HrgEPSH+eC7ajD+5Yf7c2o1IZJpay
         smkaKte20NTElldzqiYiXJzqRNHGmr5tF7KULRXMUfkx1pKf9taixszn+ObdSwikc0jj
         7oZxdq0jPaWC5vxI5WF24NPSB05Na24p+9bdBfQCMJlVoVHihhltz4O218X7c4sYqyBz
         pyVwZIcnI30QoR70tNANLMGwe3Gq7UP1IrYTBV1R9FY11EFncCHDANrwGBVVWqM7AAtC
         YVkeESvPPgQo6vlwzDWJQeqDUoOvEP6TTUwW+9qEfUpzK234GV+evsybJgT/NhblNLRW
         D4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gHoG30hc5z3pOlv7X43P6j5V04jBghcXzqd4q4XF6SM=;
        fh=0QMGdxaJTtgLgMv6MVUYG8DlntGYqUYDUdWLbeLhGpI=;
        b=SLNXsX3wDxcMlQCQFS23T9sq4PvKkT9ZCVlU0s6FMUsNxrw/0kQZE6dwvxoJSm6y5h
         1G7vJSkPCGX8pgAjeYJTuolb4Gx7fasxtYoroCAaP48AXed5ypjc6tGfIm3NpK9BDU/j
         S8mgcjeLF6tC0Ode/sF6z3jkyqDQsMw5rqMySRzY4IVL9dp79q1JdxjNl2Z/7m8O+yT6
         G3B99d7z0fS39O5o5sqAUZWgmZ37mwmB9ybY38dCtvrjtsrsaCAcZqAf5yBmREO3jAB9
         mfiV6GCsazHC5wzHNRPPnPcS5ruvZPRtHMgIMn1kiOym/xDTYVDj8x7O9rZDfP2KHEOj
         DtnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873567; x=1793478367; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gHoG30hc5z3pOlv7X43P6j5V04jBghcXzqd4q4XF6SM=;
        b=V0PSNFqMpMpPoQha7yeJfl4BtqMdiWDoWJdKCYzKmNrD6dtLrhoybQZonpjdVND5MN
         9QWX23H1LIwqusIj3pFkrhecBKF4sHifAXqWYZ2h+MpCaxz8y2RvloyESsK79yNKj6e2
         d+HeeXsi/AKTMUxah7CKVXYRiRCutCw9bGM4aAJ3t3C4GFQn/Bk4xuKidtrDE6fq+Fc8
         YX49duubIDwBzl2f8x6Sx3iygIWjkqLHH35iy0LFPZm3VeYQ4sRDJEziDbtLDMRoJwHo
         6hwc8lLo7kMRNRXPpKYIGmdTh/+Rotp3aLPOqa8kDBcO6Mj7G4FMBHd6/Eq7Brsl51ZH
         5sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873567; x=1793478367;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHoG30hc5z3pOlv7X43P6j5V04jBghcXzqd4q4XF6SM=;
        b=yyJSwKLD7siWxVU5Y6ee4UI7Gek9rP6RvML6d81kIjqB6iex2er1dFESiEybnjfv2x
         /waSHJ2hox2BsFGGIsABJzjOiIWszRXR4fUHVKfplmGKNYOaPr1Bn5Sq+Ep48+bTEI7R
         5szfzeQN6XcMh9MQxWMGFq9UZtly1Mv4PABNHgxKE+dO3SRZCzNR228rUUSzdmBp+RlX
         AkDLpnqdyjY3dM7L9kPEmaWR3xWjFn+x/IMhVxmsLfiWvEgU/tTktZgzACwU8v74/C44
         jkW3RMD4J4jqg4iS815u6aWWP/ncy8fVVdyyvshd9EvlgXs8jWb0G4dPy1u1aRGpqrCr
         n06Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVeEo8caclZ2+iYuODLEcPOVqp9Ogv6xc/R/pmTvkqxLvSsst+g+exbXBEvd49MABC5bJl3PhAmydS@vger.kernel.org
X-Gm-Message-State: AFq9FYKF1B7DRGzDB96Zg+rYMRivW54SZ0hc0lrQwFcIwRjAz7dRPnVY
	kQPfU5dn9NJwBieugdKzRYRL90Xs8eVU/FmEKVWyIPdFyX42F8KXZGrH/iqDqfq5GR1O1gdE5ja
	KiN/jJGY3h0wd8iWjZQDNItkdE59KFV8=
X-Gm-Gg: AYBFou2xYV2PJTmTCnQjYXEq/aEMyPock4DsI/P/X1mc9Z8kPuXvqdiRw6auNJYQ47o
	eHWezyqXS1Z3jlbuAXw7w7pyEH0menwbms0cr+U7zyIp9L2b0ePnALJxOtqH6tY8+DqH5F3xS/3
	zFwsHihVwM0XVjKhbalp277GxbcYLryxbku+oPgQ3kMfcxF4EfAIMJ4QPG2UK2UqMRGyeoFFnDY
	RGYoCi5PgpTAWrGrw5VYF/BVBeyTnVaypSobwdG0wDWsOaRTT55yVe1j1rqTiGWibiNSPGTJfi5
	9IZqPXsHa3/wdorKoTFqGYoTZAdq+Uukcg4BbBPQz/Llj434sTIxvRv8pNShsfftFFa2GKQhXhm
	MXphuUEiC1ntdNhAjbn/J0Jpsc+EguBehv0Y=
X-Received: by 2002:a05:7022:418a:b0:151:2e62:fe6d with SMTP id
 a92af1059eb24-19935beba2amr5489424c88.22.1792873566673; Sat, 24 Oct 2026
 13:26:06 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Sebasti=C3=A1n_Luna?= <sl140998@gmail.com>
Date: Sat, 24 Oct 2026 17:25:54 -0300
X-Gm-Features: AclHuK_mVXIzMRT0uhg4ySn7Xzly3tR8AM0RGicQvCjKb2dm22Pn8B9uv-_ZiaM
Message-ID: <CABB517KGWdM2xb+h6y41sWXu_NsRTjcmZuaVWALTw-NKbSS20A@mail.gmail.com>
Subject: [PATCH] ACPI: resource: Add AIR SRL CX307XX to irq1_edge_low_force_override[]
To: rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, 
	lpieralisi@kernel.org, sudeep.holla@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, sunilvl@ventanamicro.com, andy@kernel.org, 
	westeri@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The AIR SRL CX307XX (board name CX30000, BIOS 1.09, Ryzen 3 3200U)
describes the PS/2 keyboard IRQ in its DSDT as:

    IRQ (Edge, ActiveLow, Shared, ) {1}

and the MADT has no Interrupt Source Override for IRQ 1. Since the
kernel ignores the DSDT IRQ description for IRQ 1 on AMD Zen systems,
the keyboard ends up with the default ISA settings (edge, active high)
and receives no interrupts: the i8042 counter in /proc/interrupts stays
at 0 and atkbd logs "Failed to deactivate keyboard on isa0060/serio0".

Booting with acpi=noirq works around it, but then the internal touchpad
(I2C-HID behind pinctrl_amd) stops working.

Add the machine to the irq1_edge_low_force_override[] DMI table. With
this entry the keyboard and touchpad both work without any kernel
parameters and the i8042 interrupt counter increments normally.

Tested on the CachyOS 7.3.0-4 kernel (drivers/acpi/resource.c is the
same table as in mainline).

Signed-off-by: Luna Sebastian <sl140998@gmail>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -548,6 +548,13 @@
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
  {
+ /* AIR SRL CX307XX */
+ .matches = {
+ DMI_MATCH(DMI_SYS_VENDOR, "AIR SRL"),
+ DMI_MATCH(DMI_BOARD_NAME, "CX30000"),
+ },
+ },
+ {
  /* MECHREVO Jiaolong17KS Series GM7XG0M */
  .matches = {
  DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
