Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D83FF88F
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169417; cv=none; b=Vdh7HyiHJ7intE/HANPBBHfEnUtS2ToyBggFCnoS+Mmu8oGORRdN40CKo/4BAta9xQlEX2PAPSbzUEOYs6ub5PWgjQA59LNRAbwcV9VikD8hknX17N5lfcTtwG/ViHSF9UAv/n+ewVpC2QEKSEcpiemm1ONhH/KxNdWM+7XTPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169417; c=relaxed/simple;
	bh=ntk97llymQTEU0KEjqE+MNyw0eKE+ZKGpkPvUCBIAgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ/DtvrDPAQkfdPykFgjgTuHcoglx0cKG5cAGrYNU7pVXq0jfSPhHvFZUhTY/1yI7udfHF7hxDqfQj7pFxiRDZGyb2UA0y4AAm7vemGuWjL9DGv2IhzVlk3c258RFDZkkawMU3Clpw81WeE5iDWWFW0xB4V4Noo64PdlPpJSNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwDfacF7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwDfacF7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so877149f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169414; x=1778774214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brOzny4+yWN8uVPImP/PIJYxaoTG6+wey9i24jM96cM=;
        b=YwDfacF7vZtwz/oubB1Qsbu/GmqE8jumu7lmx1iPFt1ZhgXMpQqLsrmUcQnBbE8TKz
         n9RX1o2f4J3xH7eBMN21UUglIFBJxfswiHn/+K/Ys6OH0AttuoJsUlAxkUEgTZ4Ojhp9
         7t3BwHkSCMwpR6kEhfQQYc81M/njPX0CyUaOODV8IcK18Lbks43D4mhSVsZ15qsPBGCU
         T+VZOvzRwmB9lrR6gx6vPr+9h2HfhDN6nzqfpQViwUKHZh3ZsxNW1Bmaa+tHVSN1uPaD
         YVd1AgJPzvbxr5Jjiwue9cUIiUe7MQfGgQp9PB2gSwF+2GsvuttkXoyNTqEAP3IqkTmB
         DLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169414; x=1778774214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=brOzny4+yWN8uVPImP/PIJYxaoTG6+wey9i24jM96cM=;
        b=XzselftG6DsORtprkIgKlW7Z/+D8WfrLMAn/gCeFK4jBpmRjChgA0cyVdNyt77TYZA
         oE1GnRYkWzqNKrOtXS8++R9fI6HH3ck9ZffSPLBAewR4t1/XmVDunkdfcEz3iKiQolwj
         hD9WYRMs2j/bPdTjOmOCD5DD3ZJJbwQakG8WHyM/Z0DQGdqXaW8/DjGqu417QvxGpWAC
         f+t9nnqZDW+73nRD27Esnk3Q59MGjIaD+Da4jl5yTIkJMrikceyyUOCh35jBfLJz01G5
         rC5+xuYM+m0Iy0zGVfxX5packozN9quntyYvWziLTLFFNchQhzXjWvs4FmGsrvc2CMW9
         4nxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SYs2OyWSSGMHgrX2xe6xLQtXucOf2u628AfzMdsja9uy1PHtdGSf/oNEB7hCyZ9ydkbJRwsMb+bP0@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeV6viKGMgubLwJxonNSMoUcPRFn9ntvntHGVYMlC1RhjsYEq
	bTTVRyEYYDW0be9gVz4MXyB8osj5LBy1ES61ANgQelphElbR+Of0iHI8yFBxpya6thxwkw==
X-Gm-Gg: AeBDietWTLQTlG+/AsNCAAFcMrQ0M2SW3EoiPE4S29l3C3ofSglcBjrIdgTFNasMGbZ
	TUwrrjL2XK7NLkJbLKoT3D5HKunweLsqnFIJtMWQL5HU/QjpqzG++iMdXih37JGuWoSTgP+2RfN
	ptMtufq7a4msnNEya+bz12fnxXXEOxCMbchFwK3jt/2bVwHCyBWWbLXyxu++taDXxsgE4FVHND4
	8ViK7ohrW/0ql/2PDF8NQa48/Jd0tv1/JamLlkKJ9niUDX6NffymBVtkC2UQ5+H8z24XllxyW3z
	Nf74FcHxii84/uVNqHDQfPjKkZWJrw7oE0pft077I34q5RzRRRHXGLBg+Szu4kcnpEq7PVrxA45
	X0+orsXSWQB8/y9F2ot44bCcWhBLUz1bKs7KR7EAn+Z1DabwATBn6HEFa+t1VtFaD+zJk9zpyT9
	CCcFg21TjQwlt9sew=
X-Received: by 2002:a05:6000:2386:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-4515d99fff7mr14008340f8f.38.1778169414094;
        Thu, 07 May 2026 08:56:54 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:53 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 1/6] ACPI: Move DEFINE_FREE(acpi_free) to global header
Date: Thu,  7 May 2026 17:56:42 +0200
Message-ID: <20260507155647.403964-2-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/linux/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..f58e704ee850 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -234,6 +234,8 @@ static inline struct acpi_table_header *acpi_get_table_pointer(char *signature,
 }
 DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))
 
+DEFINE_FREE(acpi_free, void *, if (_T) ACPI_FREE(_T))
+
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init_or_acpilib acpi_table_parse_entries(char *id,
 		unsigned long table_size, int entry_id,
-- 
2.54.0

