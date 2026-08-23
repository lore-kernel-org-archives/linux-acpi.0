Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD416386C36
	for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486189; cv=none; b=B/bC/TuNNztiBh4sup7xQ8iRNO9i8fWZHSldgBm3ig6tgJteBlJWp5rPuA59Hisz1PBvA3RfZoQGplAy/jAIjhjLw+vkzq2t6KMLFztXSOAUv5+QghucI5AKCPF3Jh4vhDfoQ7gvV4SQ6pfw83Eiu+AKEY9R9X0IW2cRZYXXe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486189; c=relaxed/simple;
	bh=9i4CmNtGZj76Ske03T0miA59Y+t25yQlxECHaxFUx+I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jr/oYCh80W+gNxrtzu5taqvYoeTLTT3Iw9gABNbW/vMNbaaErP7aC67APQmZdhvOxm/V//XAZ922sizunSk1eEsec4m0DT8ZewrFLtrB9FcV6b5//iT7JLss+GzFjIUFI2Se5xO3+h++eK+YjDfmaar5ikZ0Uk9c+6FG+TKsNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arG7UsA1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arG7UsA1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso19039625ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2026 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787486187; x=1788090987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMXLNsCEJBPVUF9Rtef7lSjv0r0TZUbgwcu2Y8b1UgU=;
        b=arG7UsA1cyfjgIozJntiYtaRKgHAyTJo3S29H44n5IK8aX+wAF4GPZtHbJ73KcnhmE
         6L4i/kgGnSjWxMhcj5p7DgfLmjEL9EkMumHI3nGr37rdQbM0I7TpZykT57NW1NgcwoDy
         QM4qambx1ysZ5CLIxU+WifHTRxLeh5RCHW6Rjmaf+aE9bPABnQ73nd16ue1efVzCspFT
         IZTmqzr6BghEckVHqcMw9Ie09hlHLZxSk7RplciA6EsMigHuuXsa6+ralFN7p4EDPVfc
         ALTZiTWnww3iuwcNNvyiyvSeGijbqVNhuiQUss38Tw7SPjR35QDzfo/H9inwCYQFaX5p
         7lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787486187; x=1788090987;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMXLNsCEJBPVUF9Rtef7lSjv0r0TZUbgwcu2Y8b1UgU=;
        b=L2WUlr2GyfoFvX9fFxDr6bqUPJaQVFyDcujWjFufTn8j+tGT8NpEV9VF9XEauv+2ke
         qMZ4cKcACNDcepv0XmSth6ABNCOhrH+IOP/05ft9B/oSlCxv0UgO84zCXEkKZ0V3DHhQ
         i1mmE+y2aCW1kBtwW4YIAlHKolUCP2rcEgQO0sp8yrazZNsy56lgtqHUwXBitfnFgCn7
         XoJmyCJjiNoinyRn42U1BNIcf5YpU7+hJstQuCl8ntXhR374bnln+Vvgz7uF8QHdohl7
         fyiK7fziYBFwbf3Xx5H/QsvMmoZwtjbXcf5kV6X5qwNnjp2ITDV87R1FJRcrDysuSMMh
         Q9xA==
X-Forwarded-Encrypted: i=1; AHgh+Rpigi7PcPVYV0cvc5uMqwEY9Yn0thfnr8+xk8Ckq6QYBv+Z1bJE08MbbfyxHqochs066dN/6mMjhE7Q@vger.kernel.org
X-Gm-Message-State: AFuF++lvepYMk//oV0ibGHRQSBNGotGPHfje3oxPDUMU+rw6I+/uMlBK
	y6TtN+ho7uJyzuwch8u756rH3TvYN284eriDom0lvQwka+I8mMPRYKSRIk0+5cRXYdT4mg==
X-Gm-Gg: AR+sD10Xz6DbmbXV4jslHhfXRSBuLjUYYRvh/1c33/Cc2rvT1qhVMDDZgnXP23/QIJN
	dfOCXiq492lgq/0LqZ6iknIP7s+3rtADKgyHabZc/NLTf4+guCpEg08n3bF04V8h5XTWu//zT4Z
	+IGDZID6DhMXbhKfAp3vHXEjx21LKjp6AK6nENb2+yQC0iXYENehGEA3/I4hgprLjy0S/X4MFWH
	6jbej9pjbhsEXdA0pG8weTpVabaRBbY9n0tTnkFsI8pmljKzjesENe5k2pUtCOO4hyopIYm/NZ3
	LMrbGbR0g4wWbdVSuBofve9oW8XOhiH0IxK6wvsWCQcQ/RQKqIChsapjxGr5WADbUYkay4dx6+V
	jAABNNxoIGD3vYrg/wTrmhOHBBqcVjRMqNNGU3Qf8XJuNR1FLHKN8PstAT3zFd2rG26JGysS1Ub
	J/IlJ74GvO7Pk9/V+LpZPEjs6YqTnfcUkMPKVfokaf0jJKlj9gn3N5MUm92ahKnejf2z0=
X-Received: by 2002:a17:903:1a30:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d64adce8e3mr358562255ad.6.1787486187179;
        Sun, 23 Aug 2026 04:56:27 -0700 (PDT)
Received: from [198.18.0.1] ([117.182.103.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768957bcsm9258405ad.43.2026.08.23.04.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 04:56:26 -0700 (PDT)
Message-ID: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
Date: Sun, 23 Aug 2026 19:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: andi.shyti@kernel.org, westeri@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
Subject: [PATCH] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

Assisted-by: Codex:GPT-5.6-Sol
Assisted-by: ChatGPT:GPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
---
  drivers/i2c/i2c-core-acpi.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id 
i2c_acpi_force_100khz_device_ids[] = {
       * the device works without issues on Windows at what is expected 
to be
       * a 400KHz frequency. The root cause of the issue is not known.
       */
+    { "DELL0A86", 0 },
      { "DLL0945", 0 },
      { "ELAN0678", 0 },
      { "ELAN06FA", 0 },
-- 
2.53.0

