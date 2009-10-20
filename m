From: Amit Kucheria <amit.kucheria@canonical.com>
Subject: [PATCH] acpi: thermal: [TRIVIAL] Add EOL to the trip_point_N_type
	strings
Date: Tue, 20 Oct 2009 09:11:14 +0300
Message-ID: <37786d4b0910192311t7a9aad87i7adc62cf86bc29e2@mail.gmail.com>
References: <1255686362-30022-1-git-send-email-amit.kucheria@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62313 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZJTGLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 02:11:10 -0400
Received: by ewy3 with SMTP id 3so4441515ewy.17
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2009 23:11:14 -0700 (PDT)
In-Reply-To: <1255686362-30022-1-git-send-email-amit.kucheria@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, linux-acpi@vger.kernel.org

Rui,

This patch should perhaps have been cc'ed to you and the linux-acpi
list as well.

Regards,
Amit

---------- Forwarded message ----------
=46rom:  <amit.kucheria@canonical.com>
Date: Fri, Oct 16, 2009 at 12:46 PM
Subject: [PATCH] acpi: thermal: [TRIVIAL] Add EOL to the
trip_point_N_type strings
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com, Amit Kucheria <amit.kucheria@canonical.com>


=46rom: Amit Kucheria <amit.kucheria@canonical.com>

Make the trip_point_N_type sysfs files return a string ending in EOL fo=
r
consistency with other sysfs files.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
=A0drivers/thermal/thermal_sys.c | =A0 10 +++++-----
=A01 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sy=
s.c
index 4e83c29..6f8d8f9 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -180,15 +180,15 @@ trip_point_type_show(struct device *dev, struct
device_attribute *attr,

=A0 =A0 =A0 =A0switch (type) {
=A0 =A0 =A0 =A0case THERMAL_TRIP_CRITICAL:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "critical");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "critical\n");
=A0 =A0 =A0 =A0case THERMAL_TRIP_HOT:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "hot");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "hot\n");
=A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "passive");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "passive\n");
=A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "active");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "active\n");
=A0 =A0 =A0 =A0default:
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "unknown");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "unknown\n");
=A0 =A0 =A0 =A0}
=A0}

--
1.6.3.3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
