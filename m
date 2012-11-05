From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 1/3] gpio / ACPI: add ACPI support
Date: Mon, 05 Nov 2012 14:14:21 +0200
Message-ID: <5097AD9D.7060808@linux.intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com> <1351928793-14375-2-git-send-email-mika.westerberg@linux.intel.com> <CACRpkdYGbNCzV7QOURcEzhrNWv=kbWq+r3i66GtC75Aytso5rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16804 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab2KEMLw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2012 07:11:52 -0500
In-Reply-To: <CACRpkdYGbNCzV7QOURcEzhrNWv=kbWq+r3i66GtC75Aytso5rw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, linux-acpi@vger.kernel.org

On 11/05/2012 01:53 PM, Linus Walleij wrote:
> On Sat, Nov 3, 2012 at 8:46 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com>  wrote:
>
>> +/**
>> + * acpi_get_gpio() - Translate ACPI GPIO pin to GPIO number usable with GPIO API
>> + * @path:      ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
>> + * @pin:       ACPI GPIO pin number (0-based, controller-relative)
>> + *
>> + * Returns GPIO number to use with Linux generic GPIO API, or errno error value
>> + */
>
> So by just looking at that we can see that this is yet another
> instance of papering
> over the fact that the Linux GPIO numbers are global to the kernel and not
> per-chip, as would be preferred.

Yes, it is. ACPI5 GPIO resources are numbered per-chip. This is just a 
way for device drivers to find the corresponding Linux GPIO.

per-chip based numbering sounds saner, but this deals with what we 
currently have.

>
> Can you please contribute to the parallel discussion on how to get rid of
> the global GPIO numberspace, thread named:
> "How about a gpio_get(device *, char *) function?"

I'll take a look at it, (and see if I got anything of value to add)

-Mathias
