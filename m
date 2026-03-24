Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67D3563FA
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312804; cv=none; b=CVaJfAPDvsDe4l+GRhpj4QgMjZwZrJh3VGv8LrlEd2Ju3XJ3UgZTS/fwS6nrOZbsDeiep6Cw9Zdf9RieqExdj2+4ytO14Jw/UTOiYiLwv3yAQoRQCuve3edDiuOpbOhrHf+b3VnAOG5o60ZgN9/7Lk1VgYcfeHSbmyXyesIvrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312804; c=relaxed/simple;
	bh=WAA48TAgXPKh6OTsM9jfu2LAkNr3B0EfohpnQi0pV2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSnfFzcxFpNCAqe6RRtoK1bXRJ8qd0Vt0P3OC82dNwITqALzUGAdX1CY4YJkvNqerTB/aAOZ5lOC11GSt/1l/myxTOte3sXzE77Zn3W7DRH0A3hGkYBaneGyVWcObM//78d1FLejB6LdqcywIrlcdwasu8CmbofPMKDK4ef9iyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi4NVPgf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi4NVPgf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso847251eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312801; x=1774917601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMnha1VqvY6bmQXtBiFyEl6o1L0XqC/h5XlUXxbZCb0=;
        b=Yi4NVPgf81cfAe9ZHhZ0tGlyXftHJfw5ujoOfJwhDUEl3VenPFTq2nLQMneYek/Ayk
         1UVKtvsIq/+o9U9smEMxSaO9agj1zcNNlXCXBKl4t4WR9DRvZg2JWIYcds2B+OFggHcU
         D1KOi+3k4HdQbRxKamV3uWoKgqSQa/oavm9ptnPXj2WAubnS9wGOu27KKFQKK/sjNFMb
         zb0FKJm+7rYcg98MNpW6MHhB9jAfUPCJJxAPmZLoTNRLlQ2a4ZKDlB8aILCkITQ2fmc+
         6a+a5//nhgNYc/Kx3zfjtIrRBfPVH2Dzu1Q0+OXZhNI+VcVkhaG1i5hySlb39egO//Vn
         oDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312801; x=1774917601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMnha1VqvY6bmQXtBiFyEl6o1L0XqC/h5XlUXxbZCb0=;
        b=AHwtD/ltdaYdRVJMTg6jD2Y7FJNf3DcGDH3S52Y0m6vO+27vYRjsw8SGMkOK0bsly9
         B9j/RD39moqEGnwBCudpOyy7me0k/IlE1rxvyDWssljwZF9hSujMtzh54ScrPeOzsdMo
         4BkubXBariU2DhN6L7HQu9xQ1N1wJCiKkB56vkXRVKvBflHaO9KSJ37W0F45kskcfa9V
         RRM+DBTLaLmodtkUzRUrHoKHsT/abMz5vewOQ6IG1H7xLqW0TJs0kPTsdwhqU9PmgFqv
         fZIqnHnJ2WeJTLKpm70L7PclUShWFWuTlAkaM8bOyz9XzCk6u8ZXeH/AljP1cob/16Dp
         SSyA==
X-Forwarded-Encrypted: i=1; AJvYcCVsrVL7ztte6/8o+5VNJDcnPeUYciPt1J1TKbfgPxBFKFE752+p9W73gOqR88c1ySSk7fA4Pr7Jw7IL@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIYQgYfWGy8+7yvAU5TiU4xAiJV96ZyFHWDRf/MB+7IARoV42
	V7DuQ23ZhcmN0S7SxjZzELEa/JmF84zUEJFGq+GFwUp5pH+IFUHDmlsW
X-Gm-Gg: ATEYQzxlX7r5fPngDo8170eBKrymaACkzWbr8gROH+pvmVtVMEAl3c2fJW/N7eg1T6X
	VnJUujWdt9ofyEIkZwT/Dv8OI312EX3nwkHfM2/UmDe7dTrcm9x3Gy+QbgUgAGqG5kEpTWscgpO
	kByk7b/6OjDihjUNOWJuWuh/Bv0RyIRw7Yd8ZVo3NGLEeKuGqMQGSUQcajg0m4PJ3Dtz7KLcUuG
	F8G/8xehQVVIkIaYzB8u//VjG3SMsGqV17o04x1e+2N1MO/zp5sW7MXrIkurnz7clwxH4wFCkOL
	kaj5KQg+7S2Gz883MqP7sMp8ulCCXGBrkTEfvioz09ohMT/LFsvmKLQjvO3D2biLUqmQNsERxEM
	1cwI7oMXecvoOjGcgqihXM8a0pyed4huTWLzoyo1nFPxwwpa4GjcO2hDKUQhGkqgG9Cs1dP/MAt
	o8vU5Z3XmQMD5BHpU84P119RbxchdAhkGVRPfBPzyGybMsaQxtZTY+ZafBEMgdhF6rWk3Ae1oL2
	OUoMuR4/l7bXoU=
X-Received: by 2002:a05:7300:572a:b0:2c1:564:7127 with SMTP id 5a478bee46e88-2c1095a5b97mr5955288eec.4.1774312801221;
        Mon, 23 Mar 2026 17:40:01 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm17543148eec.10.2026.03.23.17.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:40:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 23 Mar 2026 17:39:38 -0700
Subject: [PATCH 2/4] software node: allow passing reference args to
 PROPERTY_ENTRY_REF
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-property-gpio-fix-v1-2-9cb46e5fe7df@gmail.com>
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

When dynamically creating software nodes and properties for subsequent
use with software_node_register() current implementation of
PROPERTY_ENTRY_REF is not suitable because it creates a temporary
instance of struct software_node_ref_args on stack which will later
disappear, and software_node_register() only does shallow copy of
properties.

Fix this by allowing to pass address of reference arguments structure
directly into PROPERTY_ENTRY_REF(), so that caller can manage lifetime
of the object properly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index e30ef23a9af3..942657e76993 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -471,12 +471,19 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)				\
 	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
+#define __PROPERTY_ENTRY_REF_ARGS(_ref_, ...)				\
+	_Generic(_ref_,							\
+		 const struct software_node_ref_args *: _ref_,		\
+		 struct software_node_ref_args *: _ref_,		\
+		 default: &SOFTWARE_NODE_REFERENCE(_ref_,		\
+						   ##__VA_ARGS__))
+
 #define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = sizeof(struct software_node_ref_args),		\
 	.type = DEV_PROP_REF,						\
-	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
+	{ .pointer = __PROPERTY_ENTRY_REF_ARGS(_ref_, ##__VA_ARGS__) },	\
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\

-- 
2.53.0.1018.g2bb0e51243-goog

