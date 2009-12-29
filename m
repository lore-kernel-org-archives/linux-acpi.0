From: Albert Vilella <avilella@gmail.com>
Subject: discrete ATI switch on/off for Acer Timeline 4810TG and 3810TG
	laptops
Date: Tue, 29 Dec 2009 22:16:13 +0000
Message-ID: <358f4d650912291416j432137f0ua8971a3e5ca61a07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33884 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZL2WQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 17:16:14 -0500
Received: by ewy19 with SMTP id 19so3169115ewy.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 14:16:13 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi again,

This time it's from a Linux user of the Acer Timeline 4810TG and the
rearer 3810TG models,
with an ATI discrete graphics card and an integrated intel GMA.

Also derived from the lenovo_acpi.c by Sylvain Joyeux, but in this
case, the ACPI
methods are called _SB_.PCI0.OVGA.ATPX and _SB_.PCI0.OVGA.XTPX.

I am not aware of an acer-laptop module, so it's up to you guys to
decide where this
could fit, but you see the trend here :-p

Cheers,

Albert.

########################################

/* Linux kernel module that disables the discrete graphics board for Lenovo
 * U330. Other lenovo laptops could work, but I don't know.
 *
 * Copyright (c) 2009: Sylvain Joyeux <sylvain.joyeux@m4x.org>
 */
#include <acpi/acpi.h>

MODULE_LICENSE("GPL");

static acpi_handle root_handle;

static int __init kill_ati(void)
{
    int i;
    acpi_status status;
    // The device handle
    acpi_handle handle;
    // The package elements
    union acpi_object package_elements[3];
    // The arguments to ATPX
    union acpi_object atpx_arg_elements[2];
    struct acpi_object_list atpx_arg;
    // For the return value of ATPX
    struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };

    status = acpi_get_handle(root_handle, "\\_SB_.PCI0.OVGA.ATPX", &handle);
    if (ACPI_FAILURE(status))
    {
        status = acpi_get_handle(root_handle, "\\_SB_.PCI0.OVGA.XTPX", &handle);
        if (ACPI_FAILURE(status))
        {
            printk("lenovo_acpi: cannot get ACPI handle: %s\n",
acpi_format_exception(status));
            return -ENOSYS;
        }
        printk("lenovo_acpi: in discrete graphics mode\n");
        return 0;
    }

    for (i = 0; i < 3; ++i)
    {
        package_elements[i].type = ACPI_TYPE_INTEGER;
        package_elements[i].integer.value = 0;
    }

    atpx_arg.count = 2;
    atpx_arg.pointer = &atpx_arg_elements[0];

    atpx_arg_elements[0].type = ACPI_TYPE_INTEGER;
    atpx_arg_elements[0].integer.value = 2;

    atpx_arg_elements[1].type = ACPI_TYPE_PACKAGE;
    atpx_arg_elements[1].package.count = 3;
    atpx_arg_elements[1].package.elements = &package_elements[0];

    status = acpi_evaluate_object(handle, NULL, &atpx_arg, &buffer);
    if (ACPI_FAILURE(status))
    {
        printk("lenovo_acpi: ATPX method call failed: %s\n",
acpi_format_exception(status));
        return -ENOSYS;
    }
    kfree(buffer.pointer);

    printk("lenovo_acpi: disabled the discrete graphics card\n");
    return 0;
}

static void dummy(void)
{
}

module_init(kill_ati);
module_exit(dummy);

########################################
