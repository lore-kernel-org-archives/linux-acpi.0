Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1E470E8B;
	Wed, 23 Sep 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152094; cv=none; b=efVTiPeQ90UdkMA+PotRZaGeJqQhcm5urwy3p7bep/kzldhsu21pWfNXJa+RfTeVErlsGa7O4Lbyy1sFwzeos3yxG55ShLHChKxVywwjhCKEt3HqkHH/zxXNm1TqgKVdqJtBJUaLIhMRQXPdqY/w4+Lrgy+1Ygku/4UUf8h9x/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152094; c=relaxed/simple;
	bh=vBKofHIxKgFnl5oFh8wqyoczYxMd0lYKmIxJgCAxYqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiGPYD08PiAZxWd+OXvihBRt/vHRXs/KJuSBRkH31N5RYShRvReI/KqDa4zq/2doRd7VCFDXAwEpiDp82KtNJIXQFccWgvUDwin/ZN9C1wPVLokFzkkcWMA+uXC5jAR5KSxICIV6DIuNrTDfYZSUpU+XFcoxeTVrCBDxF9KyhHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VRSTjQJO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VRSTjQJO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=FiSHWoM+FuPAUXumNSwVLaBlcQXePNtuGBaf/1AwqjA=; b=
	VRSTjQJOrBz34fkWC83aRPEPmmKKifeu/cnTYfkr9c+Y3ZoeO/opHZLLU7nMUBJueW2n4n6OmDCaR
	Kjet5IMI6IFdgfrRIID2kVeZDXC0AkKWqG7xd7vp2bfrB/7t7O7pcclPQBaDzyPRhsEKUg6kV3gx8
	/sNsQDT128Soncr3szhe3QsVnTFED7+EQ8UINoX2YbmysWG+iS3weEesS8XPN14JznpS4BBWreUW8
	Wtio8OWpEq5qXIIsaF1FujMKsNx4UkZWsG0otpqQPXroLTuIq0gAiwlbmq5i7P2X9HLtKfj6mhGg/
	KYFNf1pojdP2Qo/DZJ04BMVCd5Fj+OCtjQ==;
Received: from [49.36.127.125] (helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x9IKg-00628i-Bv; Wed, 23 Sep 2026 10:28:02 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH v2 1/2] acpi: battery: Query Battery charge time ("_BCT") method
Date: Wed, 23 Sep 2026 13:59:31 +0530
Message-ID: <20260923082932.1049270-2-uajain@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923082932.1049270-1-uajain@igalia.com>
References: <20260923082932.1049270-1-uajain@igalia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add plumbing for querying the Battery Charge Time ("_BCT") method.
If present, set ACPI_BATTERY_BCT_PRESENT in battery flags to denote
that the method is supported in ACPI.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 drivers/acpi/battery.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d..a1b7a821abaf 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
+	ACPI_BATTERY_BCT_PRESENT,
 	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 	/* On Lenovo Thinkpad models from 2010 and 2011, the power unit
 	 * switches between mWh and mAh depending on whether the system
@@ -110,6 +111,7 @@ struct acpi_battery {
 
 	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
+	unsigned long long charge_time;
 	int revision;
 	int rate_now;
 	int capacity_now;
@@ -613,6 +615,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+
+	arg0.integer.value = 100;
 
 	lockdep_assert_held(&battery->property_lock);
 
@@ -638,6 +644,15 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 
+	if (test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags)) {
+		status = acpi_evaluate_integer(battery->device->handle, "_BCT",
+					       &args, &battery->charge_time);
+	if (ACPI_FAILURE(status))
+		acpi_handle_info(battery->device->handle,
+				 "_BCT evaluation failed: %s",
+				 acpi_format_exception(status));
+	}
+
 	/* For buggy DSDTs that report negative 16-bit values for either
 	 * charging or discharging current and/or report 0 as 65536
 	 * due to bad math.
@@ -1083,6 +1098,8 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 			if (result)
 				return result;
 			acpi_battery_init_alarm(battery);
+			if (acpi_has_method(battery->device->handle, "_BCT"))
+				set_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags);
 		}
 
 		result = acpi_battery_get_state(battery);
-- 
2.55.0

