From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: GPEs occur, but no EC (_Qxx) events
Date: Thu, 25 Aug 2016 03:16:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC11E60@SHSMSX101.ccr.corp.intel.com>
References: <20160824144911.GA31547@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753369AbcHYEyJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Aug 2016 00:54:09 -0400
In-Reply-To: <20160824144911.GA31547@al>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Peter

> From: Peter Wu [mailto:peter@lekensteyn.nl]
> Subject: GPEs occur, but no EC (_Qxx) events
> 
> Hi Lv,
> 
> The Asus X550ZE laptop does not trigger EC events, resulting in
> non-working Fn keys and inability to detect lid close events. From
> /sys/firmware/acpi/interrupts/ I observe that GPE 0x15 is continuously
> increasing, but no _Qxx methods are invoked. Any idea what to try?


According to your description, if GPE 0x15 is the EC GPE, you surely need to check the EC debugging logs:
# echo "file ec.c +p" > <debugfs>/dynamic_debug/control

> 
> The original bug report is at
> https://bugzilla.kernel.org/show_bug.cgi?id=115021

OK, I'll help there.

Thanks
Lv

> 
> More debug dumps can be found in
> https://lekensteyn.nl/files/Asus-X550ZE/
> 
> Reproduced with various kernel versions including 4.6.3, 4.7 and
> v4.8-rc2-348-g6040e57.
> --
> Kind regards,
> Peter Wu
> https://lekensteyn.nl
