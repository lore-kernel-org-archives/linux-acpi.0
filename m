From: Albert Vilella <avilella@gmail.com>
Subject: discrete nvidia switch on/off for Asus UL30Vt, Asus UL50V and Asus
	UL80V laptops
Date: Tue, 29 Dec 2009 22:11:11 +0000
Message-ID: <358f4d650912291411t687d0398y4ebc80fb254a2ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50732 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbZL2WLN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 17:11:13 -0500
Received: by ewy19 with SMTP id 19so3165264ewy.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 14:11:12 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

One of the Asus UL30Vt laptop Linux users has found a solution to
switch on/off the discrete nvidia card
in this laptop, which also comes with an integrated intel GMA.
By the looks of the DSDT tables
(https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/312756),
this also works for the U50Vt and UL80Vt models with nvidia card.

It uses the ACPI P0P1.VGA._OFF method, which is the same for all 3 models.

The code file, "asus_nvidia.c" is derived from "lenovo_acpi.c" by
Sylvain Joyeux.

Here is the original post and another one that adds hibernation support:
http://forum.notebookreview.com/showpost.php?p=5663702&postcount=1239
http://forum.notebookreview.com/showpost.php?p=5664880&postcount=1244

As you can see, this right now is a small extra module, but I imagine
it could be merged
into asus-laptop or whatever module is supposed to be holding this type of
information in the mainline acpi code.

Looking forward to hearing from you,

Cheers,

Albert.

asus_nvidia.c
========================================================
#include <acpi/acpi.h>
#include <linux/suspend.h>

MODULE_LICENSE("GPL");

static acpi_handle root_handle;

static int kill_nvidia(void)
{
    acpi_status status;
    // The device handle
    acpi_handle handle;
    struct acpi_object_list args;
    // For the return value
    struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };

    status = acpi_get_handle(root_handle, "\\_SB.PCI0.P0P1.VGA._OFF", &handle);
    if (ACPI_FAILURE(status))
    {
        printk("%s: cannot get ACPI handle: %s\n", __func__,
acpi_format_exception(status));
        return -ENOSYS;
    }

    args.count = 0;
    args.pointer = NULL;

    status = acpi_evaluate_object(handle, NULL, &args, &buffer);
    if (ACPI_FAILURE(status))
    {
        printk("%s: _OFF method call failed: %s\n", __func__,
acpi_format_exception(status));
        return -ENOSYS;
    }
    kfree(buffer.pointer);

    printk("%s: disabled the discrete graphics card\n",__func__);
    return 0;
}

static int power_event(struct notifier_block *this, unsigned long event,
                       void *ptr)
{
        switch (event) {
        case PM_POST_HIBERNATION:
                kill_nvidia();
                return NOTIFY_DONE;
        case PM_POST_SUSPEND:
        case PM_HIBERNATION_PREPARE:
        case PM_SUSPEND_PREPARE:
        default:
                return NOTIFY_DONE;
        }
}

static struct notifier_block power_notifier = {
        .notifier_call = power_event,
};

static int __init asus_nvidia(void)
{
    int ret = register_pm_notifier(&power_notifier);
    if (ret) return ret;
    return kill_nvidia();
}

static void dummy(void)
{
}

module_init(asus_nvidia);
module_exit(dummy);
========================================================

Makefile
========================================================
ifneq ($(KERNELRELEASE),)
  obj-m := asus_nvidia.o
else
  KERNELDIR ?= /lib/modules/$(shell uname -r)/build
  PWD := $(shell pwd)

default:
        $(MAKE) -C $(KERNELDIR) M=$(PWD) $(EXTRA_FLAGS) modules

clean:
        $(MAKE) -C $(KERNELDIR) M=$(PWD) $(EXTRA_FLAGS) clean

endif
========================================================
