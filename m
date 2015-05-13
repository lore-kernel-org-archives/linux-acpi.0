From: Adam Goode <agoode@google.com>
Subject: Registering a device driver before _INI?
Date: Wed, 13 May 2015 18:25:07 +0200
Message-ID: <CAOf41NnAjRG-2H=h8pUDBPQs2pePH4GNY0+XNnC+iXiRf30srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:33512 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965142AbbEMQZ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 12:25:28 -0400
Received: by vnbf1 with SMTP id f1so3291136vnb.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2015 09:25:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The Macmini7,1 addresses SystemCMOS memory in _INI methods. Currently,
this fails since _INI is called before the acpi_cmos_rtc_space_handler
is registered.

I proposed registering a default handler on the ACPICA list, but was
told that because the device has a _HID it should require a device
driver.

So, is it possible to register a device driver before _INI is called?
Otherwise, Thunderbolt doesn't get initialized properly on this
hardware.



Thanks,

Adam
