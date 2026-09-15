Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFA4A3874
	for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476977; cv=pass; b=IaBInUm8YMU3Sub0SLp1T1b6qlVRZA+Gg/ytFSWSq++XxvqDxWNEuAArBne3hLWljmRBsn1PgHvFIbfF3CK53StqADPixwDGU0UQ/VUo4YNuPTQepguQUpndVpy0VUr/v0fG6VV/tH96y4TXVlempPXLBm7GqJf/wLXr34Oh47M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476977; c=relaxed/simple;
	bh=ywCk8ctzfLByvEShjkO8Y9JAFwBqQUBwzshad/GakFg=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=X+Wcos1zSLX63UM6wzWKjKgRUiNl1hs9kU0AS0C+51BUktJxSQrZKYlTvhq1kZrWFHrLGOjReihYna0RDxqyYGzdTdcXxQkvRYoQFo+HrkI8mjILNV8kKw0r0u0i9Tg/dRRIrhvFZtKLbzNFFTY+vD13CcQz4Y0NN2TIdGjpIJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeDpNhNq; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeDpNhNq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so1812605f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2026 05:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476974; cv=none;
        d=google.com; s=arc-20260327;
        b=M1xoPKbmfKWo/zwJWUXrdx5TeLsFGnDlh7/CdG8dnpg1umpBo/BtRyhnm/Y2DTOPj1
         mJ4pR6uiltbiDgAgrVuAE/F9Vk+CtEhfj018qjNFcQhXYgFPMtXtYt1wfDIA7wCaqz/f
         XqQU3vLOEDGMGuaw6+stzUDMPOShHuHGL/0yQZg3KYw5ESYIFjItDUPcgCUwM30X4Yl7
         CFtJlw5+X3tLXHzyd8V02+/gls+nSO9az7bl5CVnj2PhFBuQJXTaoc1OvgGjAY25yhiA
         nc0ZvNZ7KDROlH8j1liskcJvFOCPjNY6rsypIUw+oNWIM26L/mxTlQpF7emvgNKYE+4d
         VL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=P28SmSmKGpaCkTVR8wBuCYwuCl+D5JhrOzIJE7Pi2gM=;
        fh=mIB+3pUfRHZc/QiEZq0dp8FR9lu44L3/JnPU89X5Tko=;
        b=cNvjcJnxdiE2O1HZMuLS4e5lrTe5ipaOALN5fuIBqqoVH08UUJymJapZnUmapsAd0U
         nIvQ/SuYfmBMLGUWG4VsJL2lIp+HlB922CEhxj4+BlCpQNwf0hMQNpZqYo2zsZhlshf0
         WR625NlEvmLWfnGQaHku1QYcZqnaZaH4gjyki1auZmFVujUviKpvzOzXgS2otgqmjvH1
         LtLbl47wW6Ti351+PJ/Jv+28tSg51X0rFcvAYqRozaZVRBbygoeDatBIPHxBIVb6Bmo0
         /HiBLmbJaP8o5rSSYc7b/A+AIXxXP13EnqmlOm0moJLuFt4a1cuvB5xxRxwk26TGqLky
         AoMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476974; x=1790081774; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P28SmSmKGpaCkTVR8wBuCYwuCl+D5JhrOzIJE7Pi2gM=;
        b=eeDpNhNqMYiLVS5NGWLOQCTjPSXcSGesb4WDnQE97FIr8WDtXtMHBwpe6n0HU7bLIC
         vw+m3YK+x8KX3wAzmD9WnpvbPfP9e8quGqhIvsA5JrGaYzuPe1CxobPKLNLxWBX350R6
         xBQ42iV+Et0BET0QY7g7QnXrRDZZOT+qFAIddmEHvNrsOEfS6SYxsI930Oja+UjeNx49
         NqrMiaMjYgrqdl4/1iQecKXPKiVNfnQ2Q+Ppo0fFiGQ8CozTC907Q8ESUVs2MGqXV2Cp
         d8oaMjnIvpdP5umeMkTG3kFJwFqiVHTcddBvy5pdSRe2GzITRmZBcf92x1/vSwUt6LlM
         MzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476974; x=1790081774;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P28SmSmKGpaCkTVR8wBuCYwuCl+D5JhrOzIJE7Pi2gM=;
        b=fFqgtOIKocqaZRJ2ni0j2ZCQt1hBvGtuxUpfgnHdSV2UG+Gqr2HdLVEOdYLLhEEYbw
         Q2WqGGvamjgl1V2VS/8EK9CbJRp98CeHiJ1OqBeA0LUNZnUVZSmGAFygoug9sTW3Kaix
         b++4zzn19BHn6YVH1xlW/bSu0QqTnLuveprMqpLIAgRD2VSzBcuHg10uJ3QplS6EWKNN
         yE4Ent74i1892YfIo3dxsFTx01NvthlSQ6HocT27/vDvPekB10YdabWqt2A58qB/Q2aZ
         gEZ85NPNatOpESF1Tr0NMRqw1ht0TRBh/N8GSxKHhaoo4x8MViBEDelFr3/0/a+dJUEN
         vaEA==
X-Gm-Message-State: AFuF++nFlO6GpR0rl1NL5fR4OhzP484J+w2rz+StthTI1qnam2c1aHjB
	ylTgMjZ3/0XbmvBPzrshvYDelulXmYQZEjPiS6oLrwQ9qL0zCaW11EMTKHc2xHQDa/3pxEcOeOM
	nRD5iHSrgjDYYquYEqO/udzjMa4wMXO3ec7x3YJ0WjxNQ
X-Gm-Gg: AYBFou2rfHUVFUA+vhLRINL4jvX7DGLFsglOHcCDOVDyRFw8/DdABRTlQmSJqPpJBsy
	fG2T28xgCOLR3zWwkatOerXrdAfujDukMakKTWkGoKACZJzt3JyDHx4ex0vSnvJX3ntT51ypLVa
	SrViTFqPgoBmW7jKF+tcrDWVzJ6CDbFMBug9ofQmzmQqjScBMeRHm5zvLGkAiyAd1lUn8hpX22P
	m1nHAoWiSJboeYvXfxxR0Q3LvvBGWe5y8o2QDXpM4kOa3vG3vuQKQ9UH/zan5R3RLgHLgoQBde2
	qlR0CQwsMk7Nyrvkti1zN6tSIUF0/38eIUzbDbC2sVdTRC1tkJjXng==
X-Received: by 2002:a5d:5f88:0:b0:487:72f:fb42 with SMTP id
 ffacd0b85a97d-487072ffc70mr7287306f8f.14.1789476973811; Tue, 15 Sep 2026
 05:56:13 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:13 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:13 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:13 -0700
X-Gm-Features: AcwNN1WFpcBD6ITFW6cXO0dG90ph8PME3pbH4DMJAvt4ZwX5EgMci31_bLdJoKI
Message-ID: <CAF9RqJ4ip_egVwRKnwn3=X-Qxuwz0u_9pNrgfujBw8RSf2DTPQ@mail.gmail.com>
Subject: [PATCH] ACPI: sysfs: use strscpy() instead of strcpy()
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

strcpy() is deprecated in the kernel. Use strscpy() with the
compile-time known size of the trace_method_name buffer. The existing
length check already rejects overlong input, so behavior is unchanged.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/acpi/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efe..a99373547126 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>

 #include "internal.h"

@@ -181,10 +182,10 @@ static int param_set_trace_method_name(const char *val,

 	/* This is a hack.  We can't kmalloc in early boot. */
 	if (is_abs_path)
-		strcpy(trace_method_name, val);
+		strscpy(trace_method_name, val, sizeof(trace_method_name));
 	else {
 		trace_method_name[0] = '\\';
-		strcpy(trace_method_name+1, val);
+		strscpy(trace_method_name + 1, val, sizeof(trace_method_name) - 1);
 	}

 	/* Restore the original tracer state */
-- 
2.54.0.windows.1
