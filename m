From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v1 4/8] gpio: acpi: Even more tighten up ACPI GPIO
 lookups
Date: Fri, 24 Mar 2017 11:46:10 +0100
Message-ID: <1490352370.2404.5.camel@hadess.net>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
         <20170323194618.26548-5-andriy.shevchenko@linux.intel.com>
         <20170323201241.GB2502@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51942 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935578AbdCXKqt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2017 06:46:49 -0400
In-Reply-To: <20170323201241.GB2502@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

On Thu, 2017-03-23 at 13:12 -0700, Dmitry Torokhov wrote:
> 
<snip>
> > To prevent the possible misconfiguration tighten up even more ACPI
> > GPIO lookups
> > for case without connection ID provided.
> 
> I wonder if this will break Goodix. Irina, Bastien?

My Goodix tablet has been on the fritz for nearly a year. Hopefully,
32-bit-UEFI support will be available for my preferred distribution
soon, and I'd be able to tell you.
