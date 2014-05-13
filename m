From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: correct DMI tag for Dell Inspiron 7520
Date: Tue, 13 May 2014 09:51:50 +0800
Message-ID: <53717AB6.3020905@intel.com>
References: <CAOrdFjM6RytffEPqd0VQ2ufrzauY70shf7K_gkdjY5t1o9UPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12759 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbaEMBvw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 May 2014 21:51:52 -0400
In-Reply-To: <CAOrdFjM6RytffEPqd0VQ2ufrzauY70shf7K_gkdjY5t1o9UPzQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?VMOpbyBNYXphcnM=?= <teomazars@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

The DMI tag used to identify Dell Inspiron 7520 should be product name
instead of product version.

Reported-and-tested-by: T=C3=A9o Mazars <teomazars@gmail.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D909552
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index fced27d8e42f..010d259a2466 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -508,7 +508,7 @@ static struct dmi_system_id video_dmi_table[] __ini=
tdata =3D {
 	 .ident =3D "Dell Inspiron 7520",
 	 .matches =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7520"),
 		},
 	},
 	{
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
