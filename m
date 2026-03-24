Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D02361DD0
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312809; cv=none; b=ppXQjW/L2BGZQMq84yaU8Oc4mPQzWRzan162h5tXklMyFuDHKMJuuHSbTHNV84sqwhjbJOaVGCjcHEMsyy9q8wq7he2FfV+YvhobR0i3z65GbKkIcB26tOHxta7RCCgWJA9an8FU6fioMhAGU+tF9GaKzsrj/mD/ol/drlpMVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312809; c=relaxed/simple;
	bh=Gk/XhY40PWnO3LOxD5YjgUSYIokh9KUYlW7/pTRxeiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFYPXFbuPp79yiGf54C3NcLus/+zGcs4Sm/KyOJqfdGSta3G/emDaLmp/zHJ/VQIFPy68AsWiNPVAvGem1uKCihfnyYU3zjKLlDKDs3gjjiiAWXxZeHY6Wzogvujhm9AIg3NUc0O0RQTixgg8G4zzkXgpUdnmIHkpB2Yiq0t6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWVTJn04; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWVTJn04"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2752800eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312804; x=1774917604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu5Dic5CoGqaGahlCm060hwT3Wf5ekOnX3Fgg92paMs=;
        b=YWVTJn04HsQ7Hey2ly/vcOQJ0BW3ruRAR8L1AM/MCVZ6TjlSa723dYiSjNMq43+ema
         xRC2HHBAINwUF9q01onv65Nb5e4h+CmdDnfdI09ZXrXPxfuKdznGXcWx9VtKxOyx5BMe
         QZ9KGwHI3yNkk1cUDeSG0ukA9WXzI3nmPlSZLT/FUK7avvGb5v/V8YLOr3q2prJMwTfu
         4Iq6/QOZZ1jUiUqUxUSVxdLmKdsx2dlsf1Xc/fYlaJv6jmrsLbXztIvuioCyJFs92+FW
         lf+0EyMf8I605Qu6KG2z0xKDhVjal82jtV5CvRymIDpKf+Y4vNag5iVj+3sFA/tLwfff
         bg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312804; x=1774917604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iu5Dic5CoGqaGahlCm060hwT3Wf5ekOnX3Fgg92paMs=;
        b=loGCBn3jcqKZf0G9hmEkq1hM8HE/Lx2igJmFkGzfoc/WeBCX/h/t3hXhz3XOYxl5X/
         V3w5pCEyX0byk54Uumne9KLU23HoQG628VBgbeeKihg7hMQcHPb2TnHFj6sfb8KJG4OY
         nvp7oZV+vdNbHVNi2HHpIeqmyqQ4mMFOsnGdPmz7uQFoKv5artpNyuuI/0zf0ceTnyUD
         nDiZSUaJbQlviE1WOMEaPY8Ksf2awMvymE7szgplN251yID4/hhjlrrY6ZovQz7NV3ta
         14rYAzTNhZUVZbmpC2bnsOQDx8fG7RBcyS/2E91BFJJGVnMEOxJOmVUBYofDZY/xxpQY
         S4Og==
X-Forwarded-Encrypted: i=1; AJvYcCUqPkqyetcs/KgKbSr4yv35VOPYStEweOH8o+o6c1QB/FB17LM19S6ClesSXD+1bXn+qs8s+YNsHPw9@vger.kernel.org
X-Gm-Message-State: AOJu0YzyP+TiDRRnWPjuPo3ofRULfIjgzf0AIkcTvZ/jUOFlHiWh56xw
	5q7g5iBpzY7qXvKdz9ZgLOUO61pqKpH47fuiw4jFzi10omwLn3BFsSU9
X-Gm-Gg: ATEYQzy696sA8Nv/okX43KUhk/SKXW1t3/M8visKn65nlR12Gi5IAQ1tWMS/cuRsAtp
	F3Wq7H3JDieClchDsOo7D9t7ZTBt6NqW+hhPA76yjpycJfZVtOA0Z1h+OeuwRpPygRm1XYqCCPV
	UQqAyESUXo7iMWOJseBGseLxLIdF2OuWjUGjqT0UYO6y4j7JkwDJjBQibAgcvFTq2elBHcxGgO5
	G2Dn1kea6D/pdOQwg9nprk0y/3j4YyMXxE7df4oq06IizyOSsZytfqSNLUZS8d7aGo3mMJZaCOD
	SK7zyQKDWl9V2oSVS2ymVFfmM5+GaPCqVMF/jsk3kk9YRYagg9Gf+KFS4PLwzbUCV+RhZll5gqP
	lzUMSQ1lRvywXDQg7NqBrg+KDV5unJQ61n8HpP2qT8iu33RO4ktjXCw3vpzkPrlHnHdGpjifCyy
	AlFDJBeingFxifeuJx2qY1RUYzuaceFDBwvY8RHP8fHc3NQudjFjTCUeOyaqt/y6Aye+qqGLZx3
	UgWkQxMnfg8SKI=
X-Received: by 2002:a05:7301:1486:b0:2ba:68d6:47ae with SMTP id 5a478bee46e88-2c1097ab4a5mr6019191eec.34.1774312804390;
        Mon, 23 Mar 2026 17:40:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm17543148eec.10.2026.03.23.17.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:40:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 23 Mar 2026 17:39:40 -0700
Subject: [PATCH 4/4] x86/geode: use PROPERTY_ENTRY_REF for GPIO properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-property-gpio-fix-v1-4-9cb46e5fe7df@gmail.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
In-Reply-To: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
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

