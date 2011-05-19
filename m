From: aaron lwe <aaron.lwe@gmail.com>
Subject: any way to evaluate a device's _PS0 method when its power state is at D0?
Date: Thu, 19 May 2011 18:06:47 +0800
Message-ID: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33596 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1ESKGt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 06:06:49 -0400
Received: by bwz15 with SMTP id 15so2209920bwz.19
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2011 03:06:47 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

On init, a device's power state is set by acpi_bus_init_power, it got
the information either via power_resources or via _PSC.

My BIOS vendor here did this simply as follows:

Device (xx)
{
        Name (ABPS, 0)

        Method (_PSC, 0, NotSerialized)
        {
                Return (ABPS)
        }
}

So on init, this device's power state will be set to D0 due to ABPS is
0, but its _PS0 never get called.
If later I want to evaluate its _PS0 control method, what should I do?
acpi_bus_set_power will return if it found the set state is the same
with the current state.

Thanks,
Aaron
