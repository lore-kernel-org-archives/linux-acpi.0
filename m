From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: disable SBS by default
Date: Thu, 6 Jul 2006 11:27:23 -0400
Message-ID: <d120d5000607060827s71b4b003l99d9000c90211f23@mail.gmail.com>
References: <200607052346.04966.dtor@insightbb.com>
	 <20060706075604.66b33036.freetz@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:54413 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030329AbWGFP1Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jul 2006 11:27:24 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2713012ugf
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2006 08:27:23 -0700 (PDT)
In-Reply-To: <20060706075604.66b33036.freetz@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fryderyk Dziarmagowski <freetz@gmx.net>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, akpm@osdl.org

On 7/6/06, Fryderyk Dziarmagowski <freetz@gmx.net> wrote:
> --- Dmitry Torokhov <dtor@insightbb.com> wrote:
>
> > From: Dmitry Torokhov <dtor@insightbb.com>
> >
> > ACPI: disable SBS by default
> >
> > Kconfig help even says that SBS is pretty rare and already
> > obsolete so it does not make sence to keep it enabled.
>
> it is not rare (see SBS related trafic on this list in last weeks and
> even months).
> How can it be already obsolete? What is a replacement for that driver?
>

I am relying on author's description here. Here is what Kconfig help says:

"This driver adds support for the Smart Battery System. Depends on I2C
(Device Drivers ---> I2C support). A "Smart Battery" is quite old and
quite rare compared to today's ACPI "Control Method" battery."

Note that "quite old and rare". Besides, the patch does not remove the
driver, it just makes it not enabled in default build as not every box
has an SBS.

-- 
Dmitry
