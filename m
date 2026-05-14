Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055B35F5ED
	for <linux-acpi@vger.kernel.org>; Thu, 14 May 2026 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778916; cv=none; b=tHG58tlRlkw3e+5rZTn7NAMRnp7DwCI9549bo0ZeB7ng8GNOe+jFPsxxDPqef0mnFaGkiiAR+PnD+YQy2iqN7SVL26pQrSB3teRoeNKrxfFqW5q5ni69YmJqzcZ1kXBPIoGHn18oUJH+qRHtOhc4L4X8KKqljhw3l/1luftdt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778916; c=relaxed/simple;
	bh=ivj++8EEc8JlI2w+Z2OFdOY8bVnTMVXsBXlbHYT0bAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+YAPr65cpvPpHJzVcktFSFHe9eOIkzkpOkrFSnDSrRClXgsb4SO/fgNSOJA7XPYVgekn8kmNOPNQkgY7+jr43VEpG7h0Rgpi3EGkHn8+uraGGg0Cd0vtX8pqfr3uAZBrKkwQ1z3mfxGFKxr0h8Gv0xaqcG6pDd0G4s1VaV8H9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coUibdoj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coUibdoj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48910865133so6292295e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2026 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778778913; x=1779383713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SacI+DuUhjcebVDrBlp90eiFYi0OuIGxxQMFGnDHmH4=;
        b=coUibdojHZrUbleRZ85GwmWZJYqcn+lJBuyML71+6yo4UOAFxTm/uQezbftOVYfLdS
         RrEUvOhq7wODdxsQTYIWrgmUXVZ7DwpvIjMc/Tx3RiSsBQL6nRujwLKAD4v7XMxmtyBp
         DhKamIzP3E/wcNolt1cib7cLZaUbpNpcHjXOkMXCI9v3YKBwJMptaLWgOwvVDo+VIR/u
         WHqU5YJayZpmKxxGN8u7Y8SR2z04kWUH5rQ2RwCOq+bCjMEcxF/q6kZzZSI1lVKVZWym
         OYnW1EKJ5mAEuVvsDEq4kCQ0y9wbrGtj9772Da4M6Qs6A2lKPUadeP8gD4nL5anKXT4k
         837w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778778913; x=1779383713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SacI+DuUhjcebVDrBlp90eiFYi0OuIGxxQMFGnDHmH4=;
        b=OYFJ0MU/ReDAV23MRtuYMW079WqXnEW5SsnazVzOjH1U/iNEiakX/PkNI1mCQotJRK
         qxDMfUnLACyg+feAFhELLB4/CBScXJvJvywbkuKQt6wDzZwnOpjhMnM72MDksRm7wako
         FdWbL0dqYVdKGd+QCJJXsnCo5ILktXhkTXbFOtDwUpoViWnCh5lahtVt/DbNhdth3VTp
         UBQpCVscBrLOAyrqXGbTvpJNkXm4UOirQMtV3Q76smad2XIignBANzmMg3mJFswNknRI
         CKRGx5t2JGt4d/QK0RBe5wliVHpEBRM3/wSNuLDR86Ph6PxwfJ4rXONB1AuMpMD6v88W
         whLw==
X-Forwarded-Encrypted: i=1; AFNElJ+FMha+ryGq+hI9HkIHIBqGL1EmqvDyVbrTCz2Yc91M/uNDt1mftb+ir5vY3WzbY/WL3c62nE7otDFb@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRwhMI2ZVRk4qwoA/ppsWSf/MLJTQm4JT7aj7/3+j6RNx4xtk
	wV/mY4WhvsLW/sKUb0VZVY1c7EtXhOsjBP4cNwEH1llFcVjCVkBA9Ap1
X-Gm-Gg: Acq92OEJBwGy9kaxq2JOKSae7caAB8lvcxnj86FowDzuPoiBWb1FknImm2JfLzbQUxg
	ZBs4ZXcrIOTXVMyxaKTABufyxzD8LRM/Fxj9zQ9OiK3r5IBz83SVCJF9oIn4r7fZRMIa6FPy3uX
	2uqS1WJ+C6XFrZNptIYTzNIoEyoDYjlHegA/0vTVgG1X8ApE+X4VcNkJWFfCNs3SypWn82XHhLe
	ch3UQG+bWPtH/daiQ0UMED8vR9FOnpnhMQ5w2OdulF1AniZepm7yGQ05SqmjOwebiVVakn7u7N1
	8gq1m0nWav8xc+kL0oF49oA2/i4XS4lagyrt11jslU43AH7uL+0wTeji/OyA8oubuEvX0qcYtlr
	hJSTReCKeGe2H109paqPMt6KIgstjAvhp+xPLQvCzX1ebxFACMJbGirIEvCOKoLM09D//xdJgDf
	CvarSreBddqyXq8DxSRYh5X1YKnMqkR7wg3Y8LRB6Fcj1P
X-Received: by 2002:a05:600c:4504:b0:48a:5664:f44a with SMTP id 5b1f17b1804b1-48fe5fd16f6mr2252655e9.2.1778778913036;
        Thu, 14 May 2026 10:15:13 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm6314265e9.8.2026.05.14.10.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:15:12 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: djrscally@gmail.com,
	heikki.krogerus@linux.intel.com,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] device property: fix fwnode reference leak in fwnode_graph_get_endpoint_by_id()
Date: Thu, 14 May 2026 22:14:55 +0500
Message-Id: <20260514171455.27271-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When called with FWNODE_GRAPH_ENDPOINT_NEXT, the function walks every
endpoint under the requested port and, for any endpoint whose ID is
greater than or equal to the requested one, may store a fwnode
reference in best_ep via fwnode_handle_get(). If a later iteration
finds an exact-ID match, the function returns that endpoint directly
without dropping the reference held by best_ep, leaking it.

Drop the saved candidate before returning the exact-match endpoint.

This affects callers that use FWNODE_GRAPH_ENDPOINT_NEXT to ask for
the next endpoint with ID >= the requested one (used by a number of
media drivers, e.g. imx7/8, sun6i CSI, omap3isp, xilinx-csi2,
stm32-csi). Each leak retains a fwnode reference until reboot/unbind.

Fixes: 0fcc2bdc8aff ("device property: Add fwnode_graph_get_endpoint_by_id()")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/base/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8e0148a37..e08eadd66 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1277,8 +1277,10 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 		if (fwnode_ep.port != port)
 			continue;
 
-		if (fwnode_ep.id == endpoint)
+		if (fwnode_ep.id == endpoint) {
+			fwnode_handle_put(best_ep);
 			return ep;
+		}
 
 		if (!endpoint_next)
 			continue;
-- 
2.43.0

