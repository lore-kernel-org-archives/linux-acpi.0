From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 00/12] gpio: acpi: Make it working
Date: Mon, 29 May 2017 16:09:08 +0300
Message-ID: <1496063348.28981.17.camel@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
         <CACRpkdZN33vNUg6of-2KdC0y1uB3DfY9NgeZnXtLTPVpW6e40Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdE2NKo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 May 2017 09:10:44 -0400
In-Reply-To: <CACRpkdZN33vNUg6of-2KdC0y1uB3DfY9NgeZnXtLTPVpW6e40Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

On Mon, 2017-05-29 at 11:31 +0200, Linus Walleij wrote:
> On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > This is second iteration of the fix of GPIO ACPI library to make it
> > robust against different ACPI specification generations and thus
> > firmwares.
> 
> I applied it all so we get some rotation.
> 
> Was a bit worried about hitting drivers/pnp/* but I suspect that is
> actually your turf so I just applied it.
> 

Thanks!


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
