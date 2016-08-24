From: Peter Wu <peter@lekensteyn.nl>
Subject: GPEs occur, but no EC (_Qxx) events
Date: Wed, 24 Aug 2016 16:49:11 +0200
Message-ID: <20160824144911.GA31547@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:34866 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbcHXPSa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Aug 2016 11:18:30 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Lv,

The Asus X550ZE laptop does not trigger EC events, resulting in
non-working Fn keys and inability to detect lid close events. From
/sys/firmware/acpi/interrupts/ I observe that GPE 0x15 is continuously
increasing, but no _Qxx methods are invoked. Any idea what to try?

The original bug report is at
https://bugzilla.kernel.org/show_bug.cgi?id=115021

More debug dumps can be found in
https://lekensteyn.nl/files/Asus-X550ZE/

Reproduced with various kernel versions including 4.6.3, 4.7 and
v4.8-rc2-348-g6040e57.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
