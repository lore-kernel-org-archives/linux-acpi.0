From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH, resend] misc: Add dell-wmi driver for hotkey control
Date: Tue, 30 Dec 2008 15:50:35 -0800
Message-ID: <20081230155035.8224ca86.akpm@linux-foundation.org>
References: <20081228153128.GC13424@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55142 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335AbYL3XvQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 18:51:16 -0500
In-Reply-To: <20081228153128.GC13424@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

On Sun, 28 Dec 2008 15:31:28 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> misc: add dell-wmi driver
>     
> Add a WMI driver for Dell laptops. Currently it does nothing but send a
> generic input event when a button with a picture of a battery on it is
> pressed, but maybe other uses will appear over time.
>     

One wonders whether this driver should really live in drivers/input/?

+#include <linux/input.h>
+static struct input_dev *dell_wmi_input_dev;
+static int dell_wmi_getkeycode(struct input_dev *dev, int scancode,
+static int dell_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
+			input_report_key(dell_wmi_input_dev, key->keycode, 1);
+			input_sync(dell_wmi_input_dev);
+			input_report_key(dell_wmi_input_dev, key->keycode, 0);
+			input_sync(dell_wmi_input_dev);
+static int __init dell_wmi_input_setup(void)
+	dell_wmi_input_dev = input_allocate_device();
+	if (!dell_wmi_input_dev)
+	dell_wmi_input_dev->name = "Dell WMI hotkeys";
+	dell_wmi_input_dev->phys = "wmi/input0";
+	dell_wmi_input_dev->id.bustype = BUS_HOST;
+	dell_wmi_input_dev->getkeycode = dell_wmi_getkeycode;
+	dell_wmi_input_dev->setkeycode = dell_wmi_setkeycode;
+			set_bit(EV_KEY, dell_wmi_input_dev->evbit);
+			set_bit(key->keycode, dell_wmi_input_dev->keybit);
+			set_bit(EV_SW, dell_wmi_input_dev->evbit);
+			set_bit(key->keycode, dell_wmi_input_dev->swbit);
+	err = input_register_device(dell_wmi_input_dev);
+		input_free_device(dell_wmi_input_dev);
+		err = dell_wmi_input_setup();
+			input_unregister_device(dell_wmi_input_dev);
+		input_unregister_device(dell_wmi_input_dev);

