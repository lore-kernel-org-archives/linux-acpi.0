From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Thu, 7 Sep 2017 08:39:03 +0100
Message-ID: <20170907073903.rz6d3jd4c6yc75hf@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170906104723.qs3b7p6p6x2ixmvb@dell>
 <20170906105209.uoutqilops3plna2@dell>
 <3358010.FqzdD3Emuf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33836 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbdIGHjH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 03:39:07 -0400
Received: by mail-wm0-f52.google.com with SMTP id 137so31561468wmj.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2017 00:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3358010.FqzdD3Emuf@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 07 Sep 2017, Rafael J. Wysocki wrote:

> On Wednesday, September 6, 2017 12:52:09 PM CEST Lee Jones wrote:
> > > > In any case, I wouldn't mind it if you took the [3/3] from this series, because
> > > > if there are any conflicts with it, they will be trivial to resolve.  And I
> > > > don't need an immutable branch with it or anything like that.
> > > 
> > > No problem.
> > 
> > Although you don't appear to have reviewed it?
> 
> I have reviewed it, although I haven't sent a tag.
> 
> Generally speaking, for drivers/acpi/pmic/ Reviewed-bys from Mika and Andy are
> sufficient (they likely are more familiar with the code in there than I am),

I don't see them in MAINTAINERS.  I thought it was Len and yourself.

> but please feel free to add an ACK from me to it too. :-)

Will do, thank you.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
