Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DE3E00A9
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090849; cv=none; b=bmE0xbEldhAWC2S7kVpJk6OQuHWihhMAT3AaiFvxwlK9NhB79Yg01St6MQws1HPDOVpXtRYvfqCs7LP2gdrtzZJPgr+PywfDZtFFC5beB1kxuCGh/BkuqqjGTslRl9Yg0ux/+YMh+dRxLlq8HSwpO67ccWht1Vwan9dc7bOZT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090849; c=relaxed/simple;
	bh=8WXTBqMNIFhnx+3wevtqjrf8Oa5MXDmznN+ABA2Tczo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om/FzZ5KGs32yI8bb3NyD55kuw5rNpjW/d3fnxbdLcLVf+Yct0o8olG5TyMi7RNdICyS/ojCrZ7ne8/qFUG7+BZAUyHaK2wDG750ZwGWBYlxtkOlxVfIuX9LC8ofdghQKj86PW9lVYvsVU7tPeA4AvE+H1GjthRX41++muuL7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2keNu9O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2keNu9O"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so10951775e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090843; x=1779695643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okI3jpGXkOilPpvASVElza3EnDJyjYuX7GFWIHz3VNk=;
        b=i2keNu9OWdFMUlDbwio69D4tRisuVmYEXpIDfycV7XuF59QdfBWFiKMTm8LsMc+pDX
         GXwhynpcQmFKp8cVqAwAVZg6fHxnsN6SeC2dg8007zfIJsz4PDVWx4zZeyktKO9Gt4zn
         hxiXArqgb3fi92voRUkzBwTUt7kE9sRIgceGaQ9/qNZW26QEj7uyYOVpYhA74B+zFRnd
         Te9xYL64lVT2WmegkWyon1/jyc4hPlVhXfr2xypVHglE/v4CGqR6ZBFXuYn+gPibyB3Y
         oMpAIW+W61IvC8p5+snstsyPUecpUoVgh6vfquaFQwoNRhFTgtX/+m9AZsKFKCeJvUri
         CG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090843; x=1779695643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okI3jpGXkOilPpvASVElza3EnDJyjYuX7GFWIHz3VNk=;
        b=Wqu9siSakw/rcwM+X2U4FRcP1aEYdad8gixKQJL4zAmm9avepsW4ScsgYkf/adnTHl
         9cmrbVnfg8Bx+E6hs4ufy+RHB2VuwTcrEymbVTkdZW7CtGpCS+L2n9QbxyHWwLC65UAe
         dOxAejMR8AByM4Z2yxmQM/zsWtkogwcemSGA5oR2fgELoZ8VxiLUncnJsOzbJOEF3LRZ
         Up+LMFE1vlGT95kIjoO+qvUL5ZgV/sud32k9rG2MXnhFh+UfVOu23dLINFCC/CThZ/xy
         IICg86+XdY+swWTWuPjdIG8dUwfvQhhvBz6EvokgzySKoD+BpTqBkr1kUii0SFA589Wp
         d1SA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZDtNBud5GCFB00cI6Qk7OxWGkEGwpdrsGioxynigUS9m2VDn6EUmZ7zYCs+sSK5XE0jzooBGbSOLm@vger.kernel.org
X-Gm-Message-State: AOJu0YypOR7aSTk6pTgOx7SgDr6ebJN+SIB/3DueJoZpXM2vQr2I6C7b
	RVrD8S9Mo49gC7a6oc6Vyjd9EZAGT0Wqy17eSjggw1KnLwzxlzeniuoK
X-Gm-Gg: Acq92OEn8g6qvQpIn70IFwc/oVOSOcOupcETnt25LAM1+FuMYSqHjKsqzaL5gYbVnqG
	quo1raa66o6M9JUXvjZ4AVnAfsVy0pBHIkV72VzMPMfOkEeIiVoPa7aWtF7KvQP3ON4CLHtxVPf
	7e07ZFc6w7UOzilAMgAitXSJfF71YYVRlRtETsZ3lIuwMJP6b/IPWWyhtcloDPybCI6DfcBJttY
	eIv0tg9vdY2crgw1dgK0y4rhN4+FGEfSTXMIx1VnH1h9rdrnUnFi7GEg6Cmdg1vbHxZSplXDPWA
	rPn8Ja+QlZV1G0c+wulhiOracZ8E2A6lw9rDBjeYGqpq29KPkXtHNaDGXRDPBRSc/FrV2V8+aK3
	xN6Nj+ulAbu7V0qRWn4MJd33zHkSkyNdIsksaFkR6GflUAWucSQKuvJmATtNhPszlr7n/h5yS2H
	g+oRPPXiwrpy6yOUY=
X-Received: by 2002:a05:600c:858d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48fe6514873mr166371845e9.23.1779090843109;
        Mon, 18 May 2026 00:54:03 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:02 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 02/12] gpiolib: acpi: Modernize string parsing in quirks layer
Date: Mon, 18 May 2026 09:53:47 +0200
Message-ID: <20260518075357.112584-3-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518075357.112584-1-mscardovi95@gmail.com>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975..761ef49b5314 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -24,14 +24,12 @@ MODULE_PARM_DESC(run_edge_events_on_boot,
 static char *ignore_wake;
 module_param(ignore_wake, charp, 0444);
 MODULE_PARM_DESC(ignore_wake,
-		 "controller@pin combos on which to ignore the ACPI wake flag "
-		 "ignore_wake=controller@pin[,controller@pin[,...]]");
+		 "controller@pin combos on which to ignore the ACPI wake flag ignore_wake=controller@pin[,controller@pin[,...]]");
 
 static char *ignore_interrupt;
 module_param(ignore_interrupt, charp, 0444);
 MODULE_PARM_DESC(ignore_interrupt,
-		 "controller@pin combos on which to ignore interrupt "
-		 "ignore_interrupt=controller@pin[,controller@pin[,...]]");
+		 "controller@pin combos on which to ignore interrupt ignore_interrupt=controller@pin[,controller@pin[,...]]");
 
 /*
  * For GPIO chips which call acpi_gpiochip_request_interrupts() before late_init
@@ -75,7 +73,6 @@ bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list,
 {
 	const char *ignore_list, *controller, *pin_str;
 	unsigned int pin;
-	char *endp;
 	int len;
 
 	switch (list) {
@@ -98,8 +95,20 @@ bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list,
 		len = pin_str - controller;
 		if (len == strlen(controller_in) &&
 		    strncmp(controller, controller_in, len) == 0) {
-			pin = simple_strtoul(pin_str + 1, &endp, 10);
-			if (*endp != 0 && *endp != ',')
+			char pin_buf[16];
+			size_t pin_len = 0;
+			const char *p = pin_str + 1;
+
+			while (*p && *p != ',') {
+				if (pin_len < sizeof(pin_buf) - 1)
+					pin_buf[pin_len++] = *p;
+				else
+					goto err;
+				p++;
+			}
+			pin_buf[pin_len] = '\0';
+
+			if (kstrtouint(pin_buf, 10, &pin))
 				goto err;
 
 			if (pin == pin_in)
-- 
2.54.0

