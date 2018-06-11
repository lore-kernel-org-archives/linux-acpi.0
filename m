From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V2] ACPI LID: increment wakeup count only when notified.
Date: Mon, 11 Jun 2018 10:57:59 -0700
Message-ID: <20180611175759.181681-1-ravisadineni@chromium.org>
References: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, ravisadineni@chromium.org, ravisadineni@google.com
Cc: dmitry.torokhov@gmail.com, tbroch@google.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rajatja@google.com, bleung@google.com, furquan@chromium.org
List-Id: linux-acpi@vger.kernel.org

Currently ACPI LID increments wakeup count irrespective of the wake source.
This is because we call acpi_lid_initialize_state on every resume.
Userland deamons using wakeup_count to identify the potential wake
source for the last wake will be thrown off by this. Instead increment
the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 V2: Increment the wakeup count only when the lid is open.

 drivers/acpi/button.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5ee2dbbc..d2fe03e4faf05 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 		button->last_time = ktime_get();
 	}
 
-	if (state)
-		acpi_pm_wakeup_event(&device->dev);
-
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -366,7 +363,8 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device,
+				 bool is_notification)
 {
 	int state;
 
@@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	if (state < 0)
 		return state;
 
+	if (state && is_notification)
+		acpi_pm_wakeup_event(&device->dev);
+
 	return acpi_lid_notify_state(device, state);
 }
 
@@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 		(void)acpi_lid_notify_state(device, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -409,7 +410,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			users = button->input->users;
 			mutex_unlock(&button->input->mutex);
 			if (users)
-				acpi_lid_update_state(device);
+				acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
 
-- 
2.18.0.rc1.242.g61856ae69a-goog
