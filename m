Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BA3921F1
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837684; cv=none; b=OZu1ly6dhSJ1p0fq457vB7AkpNtgOZDGo3EJ5dChvWsFgqBFZ4d/mv3+TFNUOtQ1Xv4cH5Ow4R74TqqD4KcDeNhxX4+CPhna53hEFgGXDzWp6Dn4X5j51c9d5HeOWGub7A2cNaW1wvngIWzZmi7GYgkNd9ksa5eW2Np3DXtbZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837684; c=relaxed/simple;
	bh=Gk/XhY40PWnO3LOxD5YjgUSYIokh9KUYlW7/pTRxeiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cE4T6Dy8hcpsKT23xZUgSRmtybEqd0QwTVuFvmopVdYJaywCaYd5XCMTXWdpnbzXNNgwUIdCbpwuIEGbqgstW7bPFCZqC8WiG4QQX9XuuDvHs4miyH873JDVaKyovw7rpe51Uvzc+pd0Pzbm60qbgZ9fJDITzzudM27UTTb8WSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/b1HB/J; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/b1HB/J"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0c955a481so1096418eec.1
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837683; x=1775442483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu5Dic5CoGqaGahlCm060hwT3Wf5ekOnX3Fgg92paMs=;
        b=H/b1HB/JcxIsxcFzUtr9F0c5rPn6wZrccqxnNDU4GrNDLgdJNROKnDCqygupDb6f6w
         Yty04DEhmwqjHFA75nkDOZ4EUadLrlXM3pFkPGs1J2oaQePRGm73cZq8KQ2hYGgu7K4R
         wo1JEmRgj/8frN4ihuJo386C6i6N+wRLJRSFJEzkbBXKNt7+lwESg9SQiWYHVYcn1EXi
         IUVoZ6zL1mkkzpHZ9oO8PkNEuv9y0cL8Bd/u1lLntWbxXhRODh8wSB2PUX1UR7reby5U
         5eb/Wx0tAY4TJlf0s4SIsptIH6liVqylBTzTecdhnmmtYw6u2PulgufSO0OGnXuUBild
         5Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837683; x=1775442483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iu5Dic5CoGqaGahlCm060hwT3Wf5ekOnX3Fgg92paMs=;
        b=ldXd8xkB5ZYu0jxtpP9AjxHkfQAoPhIbPXZxqjqc9VyKYlx+RiSCNdsFIelWz+OQA9
         tVUchvQfy3H2Kaunfz/hYG2P9ggC7Y44WXr3bngpwOV3WeEhK0jGa/Fg7VEUCVm7NDkE
         7I01K9/CAX/dv/08MRYRdsp41IWHuYLnbAuN0SB9WxcL1JJOppvMo4kLee17oUVcasC+
         s7iLtJr5uYexf7wWbd2kAe4NV5d9wzVJRFN7rgnjrzB2fPTNpvMkOiKCmAH3oS3ddbAY
         qtObLoPAadOwBckYKmm90xw5Ny3j7sXN8s76+LRQew76FX6FaY4CstBKNUDoPkHFM6tT
         bvog==
X-Forwarded-Encrypted: i=1; AJvYcCV7SgKbPjL29/EeH/42BmIzujBNRx4qjMZ8wdTgg8WhHZQHmlOZ8a147x40AbSQitrtlsxckbgq2spy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhJi78cSiXagyr5dstc0q58+ZgI/R1KtCVThXsdfgIVsJ9Al4
	bWf5Mp3mW/m6cf+HBe1O0nQynZYhn6rFyRowCdZl00DV+U8BFJiwnvi0
X-Gm-Gg: ATEYQzxGfcguc4KBfJde4Y7eJ9kqVgbP5z+y4trJJjOy2kSYOik1SV3vQOShmO3oasf
	Ih3p5jbAIrGXa3Yj/i9tDU4LtrQeMvRvBqibVeTRbXlwtoEx+LK0CjtodN4ZEO+fIQw5uvDJvS5
	KtFiOtzLrrLQNLVFGKIAtmXiUEACSlB9WzWmspyHXJHI0OCQxFp8/thn/1wTs1q/7qEokC0L3t8
	a6Hwe5lGCeC4AwJHyCMP/cxABpMspm4wsJMatTmiqcMk5f2sd+n32kLWmrlSEIrNvqrguIRaskU
	g+6QyyPSrzi4/1ZLYttXDz+sJTORVaX5xsBPVRvCAD8hqyJk2vGGg/0Umx83aIMLOKlmKD53Er7
	peUIE3Ndq88XwxWkeHZbKdTqKMM84JzZSqhzexuWdX60nvO7BkHx/02UVcBxPtF4i7jhXJ2N4XR
	4wf37UZjz3IuxMlBVjkBWEluwsX857HD8PRjJWfJby5CCsI23rF4elfp7MkNGyYAobLZcyAHBG7
	O55E7sNeKT8ixc=
X-Received: by 2002:a05:7301:6781:b0:2c0:d690:7bc with SMTP id 5a478bee46e88-2c185e16735mr6142104eec.22.1774837682719;
        Sun, 29 Mar 2026 19:28:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:28:02 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 19:27:51 -0700
Subject: [PATCH v2 4/4] x86/geode: use PROPERTY_ENTRY_REF for GPIO
 properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-property-gpio-fix-v2-4-3cca5ba136d8@gmail.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
In-Reply-To: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev
X-Mailer: b4 0.15-dev-a6826

Now that the PROPERTY_ENTRY_REF macro can accept a pointer to struct
software_node_ref_args directly, we don't need to use the more
cumbersome PROPERTY_ENTRY_REF_ARRAY_LEN(..., 1) variant.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/x86/platform/geode/geode-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
index 1843ae385e2d..6572ae388d7d 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -31,7 +31,7 @@ static const struct software_node geode_gpio_keys_node = {
 static struct software_node_ref_args geode_restart_gpio_ref;
 
 static const struct property_entry geode_restart_key_props[] = {
-	PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &geode_restart_gpio_ref, 1),
+	PROPERTY_ENTRY_REF("gpios", &geode_restart_gpio_ref),
 	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
 	PROPERTY_ENTRY_STRING("label", "Reset button"),
 	PROPERTY_ENTRY_U32("debounce-interval", 100),
@@ -147,7 +147,7 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 						       leds[i].pin,
 						       GPIO_ACTIVE_LOW);
 		props[i * 3 + 0] =
-			PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &gpio_refs[i], 1);
+			PROPERTY_ENTRY_REF("gpios", &gpio_refs[i]);
 		props[i * 3 + 1] =
 			PROPERTY_ENTRY_STRING("linux,default-trigger",
 					      leds[i].default_on ?

-- 
2.53.0.1018.g2bb0e51243-goog

