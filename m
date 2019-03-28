From: "Chen, Hu" <hu1.chen@intel.com>
Subject: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when resume
Date: Thu, 28 Mar 2019 18:34:48 +0800
Message-ID: <20190328103448.20335-1-hu1.chen@intel.com>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: hdegoede@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I run Android on x86 PC (it's a NUC). Everytime I press the power button
to wake the system, it suspends right away. After some debug, I find
that Android wants to see KEY_POWER at resume. Otherwise, its
opportunistic suspend will kick in shortly.

However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
add a knob "/sys/module/button/parameters/key_power_at_resume" for users
to select.

Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---

 drivers/acpi/button.c | 6 +++++-
 drivers/acpi/sleep.c  | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a19ff3977ac4..f98e6d85dd2b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -129,6 +129,10 @@ struct acpi_button {
 	bool suspended;
 };
 
+/* does userspace want to see KEY_POWER at resume? */
+static bool key_power_at_resume __read_mostly;
+module_param(key_power_at_resume, bool, 0644);
+
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
@@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			int keycode;
 
 			acpi_pm_wakeup_event(&device->dev);
-			if (button->suspended)
+			if (button->suspended && !key_power_at_resume)
 				break;
 
 			keycode = test_bit(KEY_SLEEP, input->keybit) ?
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 403c4ff15349..c5dcee9f5872 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
 	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
 }
 
+static void pwr_btn_notify(struct device *dev)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+
+	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
+}
+
 /**
  *	acpi_pm_finish - Instruct the platform to leave a sleep state.
  *
@@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
 				      find_powerf_dev);
 	if (pwr_btn_dev) {
 		pm_wakeup_event(pwr_btn_dev, 0);
+		pwr_btn_notify(pwr_btn_dev);
 		put_device(pwr_btn_dev);
 	}
 }
-- 
2.20.1
