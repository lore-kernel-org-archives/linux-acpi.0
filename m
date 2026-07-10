Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13553C4B9A
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687921; cv=none; b=RBzCVcKk4rF9pISRzSqkL/uFPa1VM7SUZyfZh5PQBHwaR2gtpjtXp4jv0Gh52Z2Pex83LrGCMW/uh8bO+LfbvWWahJ+xnpBiS/BX2t43LayNnsfGTYo0NnvwpHrrCLdMgMUYxsFRfO5hALIRa2dmZZOshzcaRm82f4c5/fIr+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687921; c=relaxed/simple;
	bh=BBoDEhRUurM8TgH473tCzhjdD8EcVZAN75nPP8HB6i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dz6PNB5TPIMM3aqeJPvqXb6XLMmd1cZtnT1DmfsFcLtfBIjg+/NsZlNBwhOt/idPw3pYO198/B3u+5k9NcXScKC47/etF8Rm3dC8QX0g8Nqf8ysg6pKxeGO+vvxbRqaRoNf/HNm2KuB9tiJFQz0tFXkt4iFYjIByYUeL2ppbhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYBett47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYBett47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783687918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O812endyR1ginYJsJ1zWhua4+/4DYcvmWCdmrFT/HHM=;
	b=OYBett47Mtjk1LjO0BgQYjegpvRkhAmXfFB6SWv2+cx/sBo5OzPnO3knKtG/AYng+Wmen+
	ikEGsk/DrdLti6gZuUixgpwjxH3CUxyo7mRzqhYJtmOdyjM47NTz1gLr2NHjRPXpCRniea
	vnPyWLj4bQHPdi/8IaNeVGyc+fLkDj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-kYVJvR_kPoiySUHev5N3Mw-1; Fri,
 10 Jul 2026 08:51:55 -0400
X-MC-Unique: kYVJvR_kPoiySUHev5N3Mw-1
X-Mimecast-MFC-AGG-ID: kYVJvR_kPoiySUHev5N3Mw_1783687914
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 878291800267;
	Fri, 10 Jul 2026 12:51:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.67.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 418C9180029C;
	Fri, 10 Jul 2026 12:51:50 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2] acpi: battery: Sanitise model_number by dropping unprintable characters
Date: Fri, 10 Jul 2026 20:51:22 +0800
Message-ID: <20260710125122.1621877-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The battery Embedded Controller (EC) may return the model name with
trailing unprintable or non-ASCII characters. For example, on some systems:

$ cat /sys/class/power_supply/BAT0/model_name
LNV-5B10W51864��

If a non-ASCII or an unprintable character is found, it will be replaced
with '\0' to ensure the model_number is a valid string. If left intact,
the malformed string prevents udev rules and hwdb working correctly.

Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/acpi/battery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f5e0eb299610..4409fb95b988 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "ACPI: battery: " fmt
 
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
@@ -483,6 +484,15 @@ static int acpi_battery_get_status(struct acpi_battery *battery)
 	return 0;
 }
 
+static void acpi_battery_clean_unprintable_chars(char *str, size_t length)
+{
+	for (unsigned int i = 0; i < length; i++) {
+		if (!isascii(str[i]) || !isprint(str[i])) {
+			str[i] = '\0';
+			break;
+		}
+	}
+}
 
 static int extract_battery_info(const int use_bix,
 			 struct acpi_battery *battery,
@@ -524,6 +534,10 @@ static int extract_battery_info(const int use_bix,
 	    battery->capacity_now > battery->full_charge_capacity)
 		battery->capacity_now = battery->full_charge_capacity;
 
+	if (!result)
+		acpi_battery_clean_unprintable_chars(battery->model_number,
+					ARRAY_SIZE(battery->model_number));
+
 	return result;
 }
 
-- 
2.55.0

