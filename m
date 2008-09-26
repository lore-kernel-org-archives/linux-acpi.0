From: Julien Brunel <brunel@diku.dk>
Subject: [PATCH] drivers/acpi: dereference without an error test
Date: Fri, 26 Sep 2008 15:51:57 +0200
Message-ID: <200809261551.58262.brunel@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753869AbYIZNwV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

After a variable is assigned the result of backlight_device_register, an error
test should be performed before a dereference. 

A simplified version of the semantic match that finds this problem is
as follows: 
(http://www.emn.fr/x-info/coccinelle/)
// <smpl>
@def0@
expression x;
position p0;
@@

x@p0 = backlight_device_register(...)

@protected@
expression def0.x,E;
position def0.p0;
position p;
statement S;
@@
x@p0
... when != x = E
if (!IS_ERR(x) && ...) {<... x@p ...>} else S

@unprotected@
expression def0.x,E;
identifier fld;
position def0.p0;
position p != protected.p;
@@
x@p0
... when != x = E
* x@p->fld
// </smpl>

Signed-off-by: Julien Brunel <brunel@diku.dk>
Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/acpi/video.c |    2 ++
 1 file changed, 2 insertions(+)

diff -u -p a/drivers/acpi/video.c b/drivers/acpi/video.c
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -752,6 +752,8 @@ static void acpi_video_device_find_cap(s
 		sprintf(name, "acpi_video%d", count++);
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
+		if (IS_ERR(device->backlight))
+			return;
 		device->backlight->props.max_brightness = device->brightness->count-3;
 		/*
 		 * If there exists the _BQC object, the _BQC object will be
