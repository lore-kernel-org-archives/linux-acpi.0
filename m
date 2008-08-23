From: "=?ISO-8859-1?Q?Jochen_Vo=DF?=" <jochen.voss@googlemail.com>
Subject: Re: [PATCH v2 2/2] acpi_pm.c: check for monotonicity
Date: Sat, 23 Aug 2008 09:48:08 +0100
Message-ID: <ef1cd66f0808230148u317eb063xac80a319414c9f33@mail.gmail.com>
References: <20080810190759.GA1879@rhlx01.hs-esslingen.de>
	 <20080818121924.6b61f7af.akpm@linux-foundation.org>
	 <20080818193517.GA22097@isilmar.linta.de>
	 <20080818124755.162f24d1.akpm@linux-foundation.org>
	 <20080818200916.GA18209@comet.dominikbrodowski.net>
	 <20080818201033.GB18209@comet.dominikbrodowski.net>
	 <20080819024334.2f3e69fa.akpm@linux-foundation.org>
	 <20080819094938.GA21126@isilmar.linta.de>
	 <20080819025915.c34951b6.akpm@linux-foundation.org>
	 <20080822222604.GA704@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:64633 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYHWIsJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Aug 2008 04:48:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1054143wfd.4
        for <linux-acpi@vger.kernel.org>; Sat, 23 Aug 2008 01:48:09 -0700 (PDT)
In-Reply-To: <20080822222604.GA704@isilmar.linta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

some minor comments:

2008/8/22 Dominik Brodowski <linux@dominikbrodowski.net>:
> +       for (j = 0; j < ACPI_PM_MONOTONICITY_CHECKS; j++) {
> +               value1 = clocksource_acpi_pm.read();
> +               for (i = 0; i < 10000; i++) {
> +                       value2 = clocksource_acpi_pm.read();
> +                       if (value2 == value1)
> +                               continue;
> +                       if (value2 > value1)
> +                               good++;
> +                               break;
> +                       if ((value2 < value1) && ((value2) < 0xFFF))
The brackets arout value2 are not needed and look strange.

> +                               good++;
> +                               break;
> +                       printk(KERN_INFO "PM-Timer had inconsistent results:"
> +                              " 0x%#llx, 0x%#llx - aborting.\n",
> +                              value1, value2);
> +                       return -EINVAL;
> +               }
> +               udelay(300 * i);
300*10000 microseconds seems like a long time to me.  Is this the
intended maximal delay?

> +       }
> +
> +       if (good != ACPI_PM_MONOTONICITY_CHECKS) {
> +               printk(KERN_INFO "PM-Timer failed consistency check "
> +                      " (0x%#llx) - aborting.\n", value1);
> +               return -ENODEV;
If the inner loop runs out once, you alreay know that you will later
abort here.  Maybe move the check directly after the inner loop to
avoid the additional delay (10*10000*300 microseconds = 30 seconds) in
case of failure?

I hope this helps,
Jochen
-- 
http://seehuhn.de/
