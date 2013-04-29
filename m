From: Michel Lespinasse <walken@google.com>
Subject: ACPI fan driver: uninitialized variable when CONFIG_PM is not set
Date: Mon, 29 Apr 2013 05:32:11 -0700
Message-ID: <CANN689GoQm8dGEN6L1xuuc_aZ_65G3N7tBPbEXHjAfebB7xrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47930 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab3D2McL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2013 08:32:11 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so7184625ieb.13
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2013 05:32:11 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

In the following code:

static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
                             *state)
{
        struct acpi_device *device = cdev->devdata;
        int result;
        int acpi_state;

        if (!device)
                return -EINVAL;

        result = acpi_bus_update_power(device->handle, &acpi_state);
        if (result)
                return result;

        *state = (acpi_state == ACPI_STATE_D3 ? 0 :
                 (acpi_state == ACPI_STATE_D0 ? 1 : -1));
        return 0;
}

With CONFIG_PM not set, acpi_bus_update_power() returns 0 and does not
initialize acpi_state. This results in acpi_state being used before
initialization.

(I found out by random chance, as I suppose people don't normally
build without CONFIG_PM anymore ?)

I'm not sure what a proper fix would be, so I'll just report this here
and enable CONFIG_PM locally :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
