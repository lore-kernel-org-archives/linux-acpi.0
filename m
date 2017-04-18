From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/6] ACPI-fan: Delete error messages for a failed memory
 allocation in two functions
Date: Tue, 18 Apr 2017 18:51:44 +0200
Message-ID: <261224e0-8a1a-fc1e-eb1c-9b6ac96a9cab@users.sourceforge.net>
References: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@suse.de>, Chun-Yi Lee <joeyli.kernel@gmail.com>, Colin Ian King <colin.king@canonical.com>, Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 17:10:40 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: Possible unnecessary 'out of memory' message

Thus remove such statements here.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/fan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 92878c7c523b..daa8f28a4b0e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -301,7 +301,6 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	fan->fps = devm_kcalloc(&device->dev, fan->fps_count, sizeof(*fan->fps),
 				GFP_KERNEL);
 	if (!fan->fps) {
-		dev_err(&device->dev, "Not enough memory\n");
 		status = -ENOMEM;
 		goto err;
 	}
@@ -334,10 +333,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	char *name;
 
 	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
-	if (!fan) {
-		dev_err(&device->dev, "No memory for fan\n");
+	if (!fan)
 		return -ENOMEM;
-	}
+
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
-- 
2.12.2
