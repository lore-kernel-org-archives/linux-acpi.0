From: Chris Chiu <chiu@endlessm.com>
Subject: Can't even enter X after kernel 4.12
Date: Thu, 30 Nov 2017 14:27:19 +0800
Message-ID: <CAB4CAwfOfsuOyuQqJvTMEUsWJi3dw=Ajqz_7YfusKXVz1JAQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46181 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbdK3G1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Nov 2017 01:27:20 -0500
Received: by mail-wm0-f51.google.com with SMTP id r78so10781913wme.5
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 22:27:20 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hdegoede@redhat.com, linux-acpi@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

Hi,
    I have a Intel cherry trail machine Haier HR101CW (CPU: x5-Z8350)
which used to work fine in kernel 4.11, fails to enter X after I
upgrade to kernel version later than 4.12. Even the latest 4.15, it
can't even enter X now. There's no panic, oops and even no obvious
error log. The panel backlight seems to be off but keyboard still
responds.

    Then I tried to do bisect, it tells me the commit
[b7ecf663c75eed1e764f57281f9508c49c18516e] ACPI / bus: Introduce a
list of ids for "always present" devices is the one which causes this.
After I revert this commit, the display back to normal.

    Maybe the DSDT file would help for your reference.
https://gist.github.com/mschiu77/e84687cc928ac644117baf05aef47f16


Chris
