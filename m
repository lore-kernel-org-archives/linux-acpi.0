Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8323D297
	for <linux-acpi@vger.kernel.org>; Sun,  7 Jun 2026 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780804295; cv=none; b=h2C5UCL4PwYZGs+Xn/T8gkSXwKzjBE+rLQ19TUYdpOGkiwRGFotnEQ9LDLug9ZV/qmBakml/s6ZfHyz8osOaaZiKmOyIk2m2V8xsEbEdaWebFjemsa57CpVR1PKrzxYBrmqju+BqGqASiL6Y9Q4svcNDlXa1195tH7ihIKGZpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780804295; c=relaxed/simple;
	bh=bZLe+6LzzFIVuKXA64lcJ3QreAqIAsCs5havUEqiero=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UgKLWNWV0XIDvMpAUqxHXFiVkDv1na4eGPGuNe9mGWHTBDapsK5uCp37OXUDlsLwhv1W30esvH7etBSy4XAC1mExKxZIswwWDQvYew5fDGq13xrQr07LIiZ+ESADdL6XpsznMVIOqFH7Pt34/dAByqMqVduoi8IyJdKc0o5YbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfBTzTRT; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfBTzTRT"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304f0039c02so5878887eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 06 Jun 2026 20:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780804293; x=1781409093; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IYt6F2f6eV7Auqh5TfQyg7EFSRsU97hdklgbVAkw34=;
        b=FfBTzTRT2LRJjTqrXww49jRqPfuHEIp/swz9smkGmCy2HwKKmPGyvtqzjo5acocz4J
         WXblZXIenSmU2otwK1grSUnF8DcoR4WzW+vgEJ++ersN7OkjyJ9v5/8qFKE0OeNxC7/i
         KZQlvcLPd6ooAnNiVCpkJj4jmd07P/FHDuGVteQf6IRmlV1ip2tICHUBJr4U9CwsWf3U
         FBV5KWaBQ4y3P/Rc0nbdfuPJGSkuNayXPn9zJnbWETs1CloexQI4+DZiDCI1pLSaiiLu
         QYXShq/15YUjjzkQ0JAsD58XYGniN2x1/5JxWEp87UchwPy7M854IVDArPTSKiRwflQq
         2zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780804293; x=1781409093;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IYt6F2f6eV7Auqh5TfQyg7EFSRsU97hdklgbVAkw34=;
        b=aFqoh1zUSHCXkRKuIRbeg/EWkb5QNkHnVnQp80nXSp7ek+XgdgKPHVjBA18zwPEtpp
         eXWoAGB8/3qmPeia0f1VIjjiJI5tJ5mmSp5M5X8qFkULJY/ynHzyJ2zjKNaLEu95+vba
         p+vPMMQDTOx58F8E3lqpzoPzPVDetLqlfHRAboYF2vTgNzJMPitj+Uf4OhSvpDaFvYrK
         i97lz1ejgZNRooM3aD18VtWNqdjTnDwEjZ0L1rzunx3IhwSNUjOelGIJFPjfZXLuBrwW
         wk/kczilnME1E5ybZnQ+sBKDL1m28JI+jx7nDNBxKBcUpyMmgoLdVj5go4gcOr++qktR
         oxog==
X-Forwarded-Encrypted: i=1; AFNElJ/0UktXK+gGpBOYfmJ902wWGUziBIRy58g7YHzx+o/wsX1syQKSwhMZ17PT0X0hOO+USzmr3bw2zoHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQuw18xpKTAKhpWkiY0jiH2FbqJX2OKuoQ/hbqItZ+Rb0p0qC
	Ivkw4PBrZoHto3+RYTXpISaqhH2Vf9xgkKlER5jKVDb1x91usm1ipw0d
X-Gm-Gg: Acq92OHNUWaD1arSKpYs/54F55uEBvwCZj2cHQVfkajnxEhoQCDhO9J7L6m0kitRLYt
	cvVYO9zkF89ZuwvgYy28I865KNktIOb909JEqUsYPh2WbUwK5f1L6bVxvu0rWP9/aYD7rMrxXg0
	XHmsSQCPyNY/W/0g+atPQdIUyWU7XVtlg+nweQi9XBVS9OBApVbQk3hywmCoIv6Hls6csTbJyig
	kArhjIvo8gFmbeWIckg7HRzjRYMO7AhHPYPDchhNf61JaIJp8cZOovyCl3TT947Ifs5OIY8QEPQ
	ZVIS/sax4KW8r4DQFK+qKIslVRrs14pwHWp494MEuE13JVJVrrVXJKwXWupahyOob/DZF0lBaeh
	psZR9eCYlYOscWubfqWoqVeTCrhu2WfD6/wivytT5/eroMe+HrNO/E6K7lk+wXfi8i1cbuygOgS
	YP9YPPzVHYb41ld2veXqyiQWb1cdz/XRm1b/h9q+oZ/pOVJjJd/S5OuTDXROm1gL7ILHNm58h4P
	5MSsRmdxTWxRQ==
X-Received: by 2002:a05:7300:320c:b0:2ed:6f94:9d9f with SMTP id 5a478bee46e88-3077b2e0c15mr5908783eec.11.1780804292844;
        Sat, 06 Jun 2026 20:51:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm15228525eec.3.2026.06.06.20.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 20:51:32 -0700 (PDT)
Date: Sat, 6 Jun 2026 20:51:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] software node: allow passing reference args to
 PROPERTY_ENTRY_REF()
Message-ID: <aiTo4dvKu8pyimHA@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When dynamically creating software nodes and properties for subsequent
use with software_node_register() current implementation of
PROPERTY_ENTRY_REF() is not suitable because it creates a temporary
instance of struct software_node_ref_args on stack which will later
disappear, and software_node_register() only does shallow copy of
properties.

Fix this by allowing to pass address of reference arguments structure
directly into PROPERTY_ENTRY_REF(), so that caller can manage lifetime
of the object properly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This is pulled from a larger series dealing with breakage on Geode:
https://patch.msgid.link/20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com

v3: addressed Andy's comments about formatting and commit description.

 include/linux/property.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index e30ef23a9af3..14c304db4664 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -471,12 +471,18 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)				\
 	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
+#define __PROPERTY_ENTRY_REF_ARGS(_ref_, ...)				\
+	_Generic(_ref_,							\
+		 const struct software_node_ref_args *: _ref_,		\
+		 struct software_node_ref_args *: _ref_,		\
+		 default: &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__))
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
2.54.0.1032.g2f8565e1d1-goog


-- 
Dmitry
