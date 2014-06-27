From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: Interrupt in ACPI driver?
Date: Fri, 27 Jun 2014 11:20:29 +0800
Message-ID: <CAOLK0pzspBOf_nPx8kqi0VCeCV18VNOrrzR5FOSHoOiYvgV63Q@mail.gmail.com>
References: <AA3DED1F9B922246BC60FBFF3BE7EA20F7DDF2@CRSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:33825 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbaF0DUa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2014 23:20:30 -0400
Received: by mail-qa0-f49.google.com with SMTP id w8so3545517qac.8
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2014 20:20:29 -0700 (PDT)
In-Reply-To: <AA3DED1F9B922246BC60FBFF3BE7EA20F7DDF2@CRSMSX102.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cazeao, Haroldo R" <haroldo.r.cazeao@intel.com>
Cc: Julian Wollrath <jwollrath@web.de>, "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>

2014-06-27 7:12 GMT+08:00 Cazeao, Haroldo R <haroldo.r.cazeao@intel.com>:
> All,
> For a given platform, the CPU and the PCH are being enumerated along the ACPI bus. We have been using polling for temperature thresholds trip points. Now, we are looking to use interrupts instead. I haven't seen too many examples of of acpi drivers with interrupts enabled. Any suggestions on where to start? Any templates I can use?
>

I think you can have a look at EC driver which uses GPE as its interrupt.

> Thanks and regards,
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
