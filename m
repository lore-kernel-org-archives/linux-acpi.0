From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 0/8] gpio: acpi: Make it working
Date: Fri, 24 Mar 2017 15:48:29 +0200
Message-ID: <5aa07c34-cb35-d54d-cf94-32d92ed895ff@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:51967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756726AbdCXNuy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 09:50:54 -0400
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On 03/23/17 21:46, Andy Shevchenko wrote:
> After this series it's possible to use GPIO pins for input (interrupt)
> which were configured as output by BIOS by some reason. It's a crucial
> functionality for IoT open connected boards where user may choose any of
> available pin for almost any of available function, including GPIO input
> (interrupt).
>
> Current bad behaviour was first reported by Jarkko Nikula few months ago.
>
It was actually due HW reset default is input buffer disabled and BIOS 
didn't touch that pin at all if I recall correctly.

For the set:
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
