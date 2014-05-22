From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Subject: [PATCH] acpi: Use time_before() for time comparison
Date: Thu, 22 May 2014 22:56:36 +0200
Message-ID: <1400792196-28477-1-git-send-email-manuel.schoelling@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
List-Id: linux-acpi@vger.kernel.org

To be future-proof and for better readability the time comparisons are =
modified
to use time_before() instead of plain, error-prone math.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
---
 drivers/acpi/acpi_pad.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 37d7302..0a3bbf5 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -156,12 +156,13 @@ static int power_saving_thread(void *data)
=20
 	while (!kthread_should_stop()) {
 		int cpu;
-		u64 expire_time;
+		unsigned long expire_time;
=20
 		try_to_freeze();
=20
 		/* round robin to cpus */
-		if (last_jiffies + round_robin_time * HZ < jiffies) {
+		expire_time =3D last_jiffies + round_robin_time * HZ;
+		if (time_before(expire_time, jiffies)) {
 			last_jiffies =3D jiffies;
 			round_robin_cpu(tsk_index);
 		}
@@ -200,7 +201,7 @@ static int power_saving_thread(void *data)
 					CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
 			local_irq_enable();
=20
-			if (jiffies > expire_time) {
+			if (time_before(expire_time, jiffies)) {
 				do_sleep =3D 1;
 				break;
 			}
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
