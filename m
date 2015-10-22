From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Thu, 22 Oct 2015 12:17:58 -0500
Message-ID: <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
	<20151021085056.GV1526@lahna.fi.intel.com>
	<CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
	<20151022080157.GI1526@lahna.fi.intel.com>
	<CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36396 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbbJVRR7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2015 13:17:59 -0400
Received: by ioll68 with SMTP id l68so99122751iol.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2015 10:17:58 -0700 (PDT)
In-Reply-To: <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

> The next issue is that the I2C-core isn't matching the device to the
> "at24" driver, which has the alias "24c02".

Here is what I found.
i2c-core is creating the device with the ACPI name "24C02:00".
The at24 driver uses "24c02" as the alias.
i2c-code is matching devices to drivers using strcmp().

Result: no match. ("24c02" != "24C02:00").

If I modify acpi_i2c_add_device() to cut off the name at the ':' and
covert to lowercase when populating info.type, it matches and works.
I must be missing something here, because this would have never worked as-is.
I'll ask on the I2C mailing list.

Thanks again,
Ben
