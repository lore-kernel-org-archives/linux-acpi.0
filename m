Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089B3921DD
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837681; cv=none; b=O9Y8xeD8/87cwc07PGxZy7P1QIH4rvtvmVXBmH2GI0ZLuLgzlH1lHlbI2en7ceB3PEcW4GuyyDZecKVveLmP3ZzrqrB+eqXWuuLEJET1yfQ4NNIDEWJ6pbMBiXjApmOzaHNeerKeVO1U8vXDbAO4Ai87uMUT3ZLu5r2vxXD+Aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837681; c=relaxed/simple;
	bh=WAA48TAgXPKh6OTsM9jfu2LAkNr3B0EfohpnQi0pV2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5NlwmGMQXZlXiqML7gp+uMkuk3CruWeFUxN+KcSSHEoYohkCeBQwG0QHbfrm4ngvczGT1Angmqvrs8d0Vd2cSCEZkB1hAfGKatczAksZ9f1hSmDuzvYBLpohUuSIxYijZEVFcSaMH+Djacbtsa6ZH7AGBsowRVBEewTctP6E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r58A0fyC; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r58A0fyC"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c56aa62931so656150eec.0
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837679; x=1775442479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMnha1VqvY6bmQXtBiFyEl6o1L0XqC/h5XlUXxbZCb0=;
        b=r58A0fyC4EgRvj1K6ixjPsSeRbJQtCpAUqcPv0FaJbb74ylmBOHQLNs+UqKJ0bUUz5
         EnOYRpaGFvedeyBVMlcn7KjLQd2N886BXoGoVu+xVW+cXHzUXAvJ3pu0WOPUA7nDFtxm
         lzRBg3QL1ocW4Ax+X9RjzFoMV/ljkOZVRRNo1b6lE+DqnMYdcnbgH53iOrq6HKRDPRln
         MmoEk125io7XROzhqYvs/t8+Qzslx2VeRBCDOnyB5cHXzC8HIiy68E/C+hJ96o+gO6ot
         l+t3Tp1HfI2uhHU2296F2GuNpJuD6gj2axfMwkaGnoX9AHLZrBTxwMzNpp6LjK7uqYKH
         7s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837679; x=1775442479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMnha1VqvY6bmQXtBiFyEl6o1L0XqC/h5XlUXxbZCb0=;
        b=IIeTVsJvUQgSxxriLhm9I3eTMNjPIgl2R2Qm2Jzgd929KLuXI7Smfmoa/0YuwpTMki
         wBAjWNyXh4iASb82esvVtGaitGQ9NwlfGrTTvdYty/4Xvn3Fr4SiBqEvqp3NE/jT8aCD
         H02A/rt0EAaEsHXwqg5FqDtXB5xJYT2VPh9vNzSd6wmud4lGs1Kn6dUcL8wHnMSi/8nz
         UfQNJ7gd63HnhOXTnccSjpLUHx3UM5p6TpFH0nvrv17SDtmFkFy1nL2lUqh88R2Leyul
         iSek38/R6uQEMWF6msBPE8G4/ZFYdWksM3a8QP8BVHf5ZfPXb4Ctl4uAnXAlQ7uQdzP9
         JsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8kLzyyU4EGQ0uTDkaR0bm/inQ+IeOY6tqOhhE1oJWg+1YcoW+36/x5cPqi603AH71TpcAthG5I/b@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/3Y78finozV05TMGLqX7OBcEX5gM2tvmX71DXCh0xnYxHyFV
	wXWG1UQ+kQa0shlkhlDoffe32UBu3g0LUjBphVY8m2GELWDmtwSvQ/Kq
X-Gm-Gg: ATEYQzxc1qBx9ynX93bTQ13b+N50FlrbYxcxnq8cL9BtIRJXvwDkLJK9VwFPCc/VEL6
	EqpYfjuxmsgfth022roopbrafdqSvkWnWV5kOqa9aV+3ljvNmFiBqtLZOmhcU3a2wAMJ7VYRbrb
	YzlHlmR10sPBJgV4P+MRyREPICl+tfE5RbrxVa/3x6GqsQlb6glWCQe3uw9bS93lwJhOl0JyjIX
	jyTkWPryJD/pfyK96K3N3w/9LQSh2YCiivWMRtVTJ/yRxUx1LA2a8DHKOGZuvaJ8cUxcnbtScYY
	mggJC00z5Zj9qW5PYkH7hGsn/lHIFjfXjXGzxbETPJz77sdAfXrmnWmuaAkSreETXPiq5H9njK+
	zrxForNtLIN46YUaA7lQkANDrzhI/lui/KFHTQKUsxvAi0d0IeW3V3xKVsTW/aTWHEAyEeBlb2u
	TYLorrpP7mWB8LILaURZ3yje5TTaZEBVs9OHaK6WRMFAzHFdrIM2T5RT1CmqXHpYCKhH1GFTYw0
	huCy/dRNWASYpo=
X-Received: by 2002:a05:7300:6423:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2c185e169aemr6118335eec.16.1774837679449;
        Sun, 29 Mar 2026 19:27:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:27:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 19:27:49 -0700
Subject: [PATCH v2 2/4] software node: allow passing reference args to
 PROPERTY_ENTRY_REF
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-property-gpio-fix-v2-2-3cca5ba136d8@gmail.com>
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

