Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C73ED3BF
	for <linux-acpi@vger.kernel.org>; Wed,  8 Jul 2026 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494500; cv=none; b=O2Te7iSw1XRB3YnxkTOsZCUo3MrqDy0tNli8llBmzOj1lW2da1TDBY/LsJ/qMU9+9hV1Ts6h207pss16u/JNUYLmbvroHSMt6qH8PUNX29Wb+gyp5RcoUVl6hek6Y6K83hVebCNYxf4ac2/b7vNiMDC9grX84PXCQgL2FrTpgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494500; c=relaxed/simple;
	bh=dmo/JOIl9EZbvk+FriZDVg4oB+HUW5SDVZpf0ay89Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYkeCOprBE79Zt0pqQGSJ6iGiNNzKK4aB/MccE3QI0OqUnU6X93E2cWb/4RSyVzhHaSCX8nuChUGBm8fvxgnAL6gM/H19OuHKUgY7mmE8rFxLi3vs/cgC2YWp4w2QAPC5401+RqOjZ9OXuMcldgLMhP2e2FoK2Gw3qgamH3mAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpfAFne5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpfAFne5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783494473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tIdt7kuXG6JzI/0FPYNWoiUqZ9++YAn8mQFdRDP13LM=;
	b=dpfAFne5p/0LHb9qcnZZ/Y2AbuUdSRDXyBnEgTPuNXaLS6B2OHTMkaTKUPOy/ASD4ch8PE
	rqwTaxoiYj+wZBwjDIVOF1FUuDvgV6p6n5MoGxE5kIyX0kBIBKmh/RXLh/pPCmxrQWBa1e
	EJnsYQ/OV7UpffwYohv7ZuZVQjpIjlY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-SPlN2H7mNJqN-Pku1_NVHw-1; Wed,
 08 Jul 2026 03:07:48 -0400
X-MC-Unique: SPlN2H7mNJqN-Pku1_NVHw-1
X-Mimecast-MFC-AGG-ID: SPlN2H7mNJqN-Pku1_NVHw_1783494467
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05119180047F;
	Wed,  8 Jul 2026 07:07:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.67.32.168])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D73A175F;
	Wed,  8 Jul 2026 07:07:42 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kate Hsuan <hpa@redhat.com>
Subject: [PATCH] acpi: battery: Sanitise model_number by dropping unprintable characters
Date: Wed,  8 Jul 2026 15:07:32 +0800
Message-ID: <20260708070732.578046-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The battery Embedded Controller (EC) may return the model name with
trailing unprintable or non-ASCII characters. For example, on some systems:

$ cat /sys/class/power_supply/BAT0/model_name
LNV-5B10W51864��

Strip these unprintable characters to ensure the model_name attribute
contains a valid string. If left intact, these malformed strings prevent
udev rules and hwdb from matching the attribute correctly.

Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/acpi/battery.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f5e0eb299610..dea0c3cc5160 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "ACPI: battery: " fmt
 
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
@@ -194,6 +195,21 @@ static int acpi_battery_handle_discharging(struct acpi_battery *battery)
 	return POWER_SUPPLY_STATUS_DISCHARGING;
 }
 
+static void acpi_battery_remove_special_chars(char *str)
+{
+	char *out = str;
+	unsigned int i = 0;
+
+	while (*str && i < MAX_STRING_LENGTH) {
+		unsigned char c = *str++;
+
+		if (isascii(c) && isprint(c))
+			*out++ = c;
+		i++;
+	}
+	*out = '\0';
+}
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -524,6 +540,9 @@ static int extract_battery_info(const int use_bix,
 	    battery->capacity_now > battery->full_charge_capacity)
 		battery->capacity_now = battery->full_charge_capacity;
 
+	if (!result)
+		acpi_battery_remove_special_chars(battery->model_number);
+
 	return result;
 }
 
-- 
2.55.0

