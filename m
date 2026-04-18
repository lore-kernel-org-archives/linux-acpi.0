Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51F26CE2C
	for <linux-acpi@vger.kernel.org>; Sat, 18 Apr 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531007; cv=none; b=WLtiM4PQzqpX03DZsUVAk1eWGM6t3sEvmSQ1OJGKAR05KVMWMbf8m+vFYD2t7UJYQGSHXK7kLHzHpphmWVLo2fn33OjMCWf6j1kgdqvyphXJanrKjkSqRtybB6rubixyvO3QUOP9LtBAoQaEEluVCe3TnIvEv0Bz2CaK2JtTKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531007; c=relaxed/simple;
	bh=w1tzFvqfBOjNQPH8XlS/WSCtfxbNsAtCxqkiOna20KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXSSOnr4c6VFe1rcHtSLwQ1t5rral9vjINbVdTgPHBPnwPUqHVuOLkaKY24mI4JiTe6HFouloXRHsa2XvGKTihqW6MOD36rzDVbrnc4rLj7tsC4faKxgLApF/hVXsAGKsiyokc+EWqGxwLBg2/HPtQqTgsFP+nLx+HzXR1vkTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA24P/NV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA24P/NV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso12453585e9.0
        for <linux-acpi@vger.kernel.org>; Sat, 18 Apr 2026 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531004; x=1777135804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKQkIRa74x5lADi7CNb+Bghk3/CFXCC1R8y1s3ARJuY=;
        b=XA24P/NVofyHAvCcAf0NfQc+ge7ApXORFwAGQcdgniTjgcki4+cDllagM/NRu6ytKM
         d8EMnyadgh5abLsW3AqKS8krfVQdad1/QLX2vR2WFhxYIDIpgVZM4R3lEHmAK/IZ8A2Y
         KDiF/YDgsz4x7v5QrfaeZLRIFsY6h7kTyNuWkRcsb8vE+qy78SQZzOmCSucVYkrXbqq4
         YO2GQFBPiXPIhSTZ4dTY+kED9WdT7hfVIhFgaPhPMYYTI5Ouwzq24Sda+ZiKUgsBu8Yk
         jDKUHfZfclb9FvMbq3OnlExWc9PPGzd2P9PgQaUXkdwf4G2akLErbkOhNKgA+dT2sEGp
         dQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531004; x=1777135804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKQkIRa74x5lADi7CNb+Bghk3/CFXCC1R8y1s3ARJuY=;
        b=St3A8d3b0y9sIsj7UGtTD+MsNYVneCuZyAJKReJjkrh6URWWfbIIqiDW1bCZw7A0rD
         nKi1iJEUbVlC4T938OTxaLBXKqhGKgfEhQzAOhvgQ/eYMk9up3QZ1lJCJIX070GW0HYM
         9vti7sHtAVfQ+CIQl6w2MdNX90GayQ6yLrgfC3fYHlcQrtDksq+jVFatKGMJjm8iN42P
         oRyHB7tdU5DrRh/trO308vQS7yPF2jRxq2XP1kMapANlP7W6RoZnxceVncnF624fHDGZ
         /9gPPiNJRI9qqhOBVvF6FWAWVLdBgMtE9t4O4NboSeICSEhWFbsM/I9Lqmj6FZ5/W0DF
         z/PA==
X-Gm-Message-State: AOJu0Yz0bey0CyxeS3n6ZeDsl1M3sM8obAYHWLatsilkQwSPsJsB4Cud
	ZVs35vGiAmrNWGdznxo+0iuSksKz1ztCOSagWNRFG1/YXg66lhRMHZSN
X-Gm-Gg: AeBDievVM7PE+COI3lJ2SNuVm/I2Vnui830QO3tksgTCus95LlrPd/BcTW79JNnn5G4
	r6pnqFuqd46h95JUSW1928HtUt+hwpljG7rM2CfbJnMMbdBISsKCq4S9+sMwuGmavQkyRPp2cSQ
	9hq1EfE0RY/ZrF9fu4hisAqleZjIRTzeZHAcC23zFEI+I7zUVXU2kP8viJ+fBCEPXCWSiExTkGo
	zEmefNwizlpAULlM66BUbBm4Ke9BPm1gD5x3JpCekRO4lWqnfr2JkvhJbnDJYdyCW2l7DFvfhWo
	sJuTyfWFFpy/6D3++NQ7dQ3evSwaEVmhcqOui286atE/f+I41Ign5JfZEt+Gt/DIr4dJeeD47Yo
	+kcjBfYduGkDQ1/+afJmUUsPnF8xbYPdnu1OLKiirrBurAtDLZouJNM10hJgQvVHO6O37se0zuv
	sLMIgUeaGBnPd6oJHwnyvoOAdPfmcrm1DQdC6KOhVmjmEWurCtLw==
X-Received: by 2002:a05:600c:45d1:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488fb75a1bdmr107851025e9.13.1776531003651;
        Sat, 18 Apr 2026 09:50:03 -0700 (PDT)
Received: from cachy.aybu.edu.tr ([95.183.210.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a166sm14197469f8f.19.2026.04.18.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:50:03 -0700 (PDT)
From: =?UTF-8?q?Z=C3=BCht=C3=BC=20Eren=20=C4=B0ncekara?= <incekarazuhtu04@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	devel@acpica.org,
	=?UTF-8?q?Z=C3=BCht=C3=BC=20Eren=20=C4=B0ncekara?= <incekarazuhtu04@gmail.com>
Subject: [PATCH] ACPICA: Dispatcher: Treat AE_ALREADY_EXISTS as a warning
Date: Sat, 18 Apr 2026 19:49:47 +0300
Message-ID: <20260418164948.7423-1-incekarazuhtu04@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eec034b8-7fa3-4169-915d-6e7173779d6c@kernel.org>
References: <eec034b8-7fa3-4169-915d-6e7173779d6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans,

I've implemented the ACPICA core patch as you suggested. I modified dswload2.c 
to treat AE_ALREADY_EXISTS as a warning instead of a fatal error, allowing 
the table load to continue.

I tested this on my ASUS Vivobook X7400PC with a custom 7.0.0-dirty kernel. 
The patch successfully allows the problematic SSDT to load.

Verification from dmesg (The patch is working):
[    0.190917] ACPI Warning: Namespace lookup: Object [APLD] already exists, continuing table load
[    0.190940] ACPI Warning: Namespace lookup: Object [_UPC] already exists, continuing table load (20251212/dswload2-333)
[    0.190971] ACPI Warning: Namespace lookup: Object [_PLD] already exists, continuing table load (20251212/dswload2-333)

However, despite the table loading successfully, the missing thermal symbols 
still persist in my logs:

Persistent AE_NOT_FOUND errors:
[    6.809032] ACPI BIOS Error (bug): Could not resolve symbol [\CTDP], AE_NOT_FOUND (20251212/psargs-332)
[    6.829784] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.LPCB.EC0.SEN1._CRT.S1CT], AE_NOT_FOUND
[    6.829840] ACPI Error: Aborting method \_SB.PC00.LPCB.EC0.SEN1._PSV due to previous error (AE_NOT_FOUND)

It appears the namespace collision was indeed preventing the table from 
loading, but even with the table loaded, these specific thermal symbols 
are still not resolvable. This might indicate they are truly missing 
from the BIOS tables or defined elsewhere.

Should we proceed with this ACPICA change, or should I go back to 
providing these symbols via a quirk in asus-wmi?

Best regards,
Zühtü Eren İncekara

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow ACPI table loading to continue when a named object already exists. This addresses BIOS bugs where SSDT tables redefine objects present in the DSDT, which prevents essential symbols (like thermal zones) from being loaded.

Signed-off-by: Zühtü Eren İncekara <incekarazuhtu04@gmail.com>
---
 drivers/acpi/acpica/dswload2.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index bfc54c914..9d0deb2f7 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -323,9 +323,23 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 	}
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR_NAMESPACE(walk_state->scope_info,
-				     buffer_ptr, status);
-		return_ACPI_STATUS(status);
+		/*
+		 * If the object already exists, do not abort the table load.
+		 * Instead, issue a warning and continue with AE_OK.
+		 * This allows the rest of the SSDT to be loaded even if the
+		 * BIOS incorrectly attempts to redefine an existing object.
+		 */
+		if (status == AE_ALREADY_EXISTS) {
+			ACPI_WARNING((AE_INFO,
+				      "Namespace lookup: Object [%s] already exists, continuing table load",
+				      buffer_ptr));
+			status = AE_OK;
+		} else {
+			/* For all other fatal errors, abort the method/table load */
+			ACPI_ERROR_NAMESPACE(walk_state->scope_info,
+					     buffer_ptr, status);
+			return_ACPI_STATUS(status);
+		}
 	}
 
 	if (!op) {
-- 
2.53.0

