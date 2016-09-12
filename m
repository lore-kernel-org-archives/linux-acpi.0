From: =?UTF-8?Q?Jos=C3=A9_Foronda?= <josemauricioforonda@gmail.com>
Subject: Unreadable battery on HP Envy m4-1015dx
Date: Sun, 11 Sep 2016 22:07:55 -0400
Message-ID: <CANCd0q1A8-LskT-LkQ1ndo5inz=mY+TEPLNK1W4E12nDj98cyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36298 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755307AbcILCH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2016 22:07:56 -0400
Received: by mail-vk0-f51.google.com with SMTP id m62so61074285vkd.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Sep 2016 19:07:56 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,

I get the following errors on my HP Envy m4-1015dx with Insyde F.18
BIOS and the mainline kernel (4.8-rc5), after which battery state
becomes unreadable:

ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0.MMRD]
(Node ffff8802468b4f50), AE_AML_INFINITE_LOOP (20150930/psparse-542)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0.RDMB]
(Node ffff8802468b5938), AE_AML_INFINITE_LOOP (20150930/psparse-542)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0.RDMW]
(Node ffff8802468b5960), AE_AML_INFINITE_LOOP (20150930/psparse-542)
ACPI Error: Method parse/execution failed
[\_SB.PCI0.LPCB.EC0.BAT0._BST] (Node ffff8802468b54d8),
AE_AML_INFINITE_LOOP (20150930/psparse-542)

This makes every process that depends on reading battery state hang
(upowerd, suspend, shutdown). I can't find any trigger as dmesg stays
silent for several minutes before this happens. It has happened after
sessions lasting from 7 minutes up to a couple of days, it never takes
longer.

I've had this problem for as long as I have Linux on this machine,
which goes from kernel 3.19 up to current mainline.

If anyone wants to check the acpidump, you may find it here
(https://dl.dropboxusercontent.com/u/109420370/acpidump.txt)

I previously filed a bug report for the Ubuntu maintainers where you
might find more information
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1615200)

Hope somebody can take a look at this, it's made Linux very unreliable
for me for a long time.

Thanks
