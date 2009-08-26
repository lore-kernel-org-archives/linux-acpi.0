From: Lin Ming <lin@minggr.cn>
Subject: Re: ACPI explodes in -next (ACPI video it seems)
Date: Wed, 26 Aug 2009 09:24:33 +0800
Message-ID: <d3f22a0908251824p9711c0eie1e8609f50e5f192@mail.gmail.com>
References: <20090825154037.675e8848@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:63554 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbZHZBYd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2009 21:24:33 -0400
Received: by wa-out-1112.google.com with SMTP id j5so653023wah.21
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2009 18:24:34 -0700 (PDT)
In-Reply-To: <20090825154037.675e8848@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Tue, Aug 25, 2009 at 10:40 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
>
> Trace is during a modprobe
>
> strcmp of NULL pointer from

Looks like the HID/UID NULL pointer issue that was fixed by
acpi-fix-null-bug-for-hid-uid-string-2.patch in -mm tree

Lin Ming

> acpi_device_probe + 0xA3/0x123
> driver_probe_device
> __driver_attach
> bus_for_each_dev
> driver_attach
> __driver_attach
> bus_add_driver
> driver_register
> acpi_bus_register_driver
> acpi_video_register [video]
> acpi_video_init [video]
> _stext + 49
> acpi_video_init + 0x0
> ..
> ..
> sys_init_module
>
> /sbin/modprobe -b acpi:LNXVIDEO: abnormal exit
>
> IRQ routing has also broken which worked fine before (resulting in no USB)
>
> HP (Compaq) Presario V5000 F.15 (Intel Video, Intel Celeron CPU @1.46GHz)
>
>
> (note I'm not subscribed to linux-acpi)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
