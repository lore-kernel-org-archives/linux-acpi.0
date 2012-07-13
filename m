From: AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Fri, 13 Jul 2012 15:07:38 +0800
Message-ID: <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
	<20120713064801.GA4910@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42830 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2GMHHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 03:07:39 -0400
Received: by vcbf11 with SMTP id f11so2064288vcb.19
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jul 2012 00:07:39 -0700 (PDT)
In-Reply-To: <20120713064801.GA4910@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

2012/7/13 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Fri, Jul 13, 2012 at 02:13:22PM +0800, AceLan Kao wrote:
>
>> I think it's safe not to generate the proc event while pressing the
>> suspend hotkey, since "/proc/acpi/event" is deprecated. And system can
>> enter S3 correctly without it.
>
> Why does this happen via /proc, but not via evdev?
There are many different events to inform the system concurrently,
evdev is just one of them.
I'm not sure which one trigger the system to suspend while pressing
the suspend hotkey, but
the following suspends are triggered by acpi proc event.


-- 
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
