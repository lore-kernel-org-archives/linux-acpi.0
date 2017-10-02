From: <Mario.Limonciello@dell.com>
Subject: Automatically enabling keyboard wakeup on S2I
Date: Mon, 2 Oct 2017 15:55:17 +0000
Message-ID: <844f1c87647c409ab7955b6caf4a69df@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:4560 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751313AbdJBPzT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2017 11:55:19 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Recently an issue raised around S2I brought up a topic that I think is wort=
h talking about.

The question was around keyboard wakeup from S2I.=A0 Rafael had mentioned:
> You need to do
> # echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup
> (as root) for it to work.

I'm wondering, does it make sense to perhaps do that by default in the S2I =
scenario?=A0=20
That's actually what Windows does.=A0 It allows wakeup from both keyboard a=
nd mouse=20
when coming out of modern standby.

