From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] gpio: acpi: Add managed variant of
 acpi_dev_add_driver_gpios()
Date: Tue, 14 Mar 2017 14:27:06 +0200
Message-ID: <1489494426.20145.237.camel@linux.intel.com>
References: <20170302134805.81705-1-andriy.shevchenko@linux.intel.com>
         <CACRpkdYZVY0jYLkuH3Ti7SUnV1Dz_SkkLKv0cyZdvVjiGOR9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:9135 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdCNM1K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 08:27:10 -0400
In-Reply-To: <CACRpkdYZVY0jYLkuH3Ti7SUnV1Dz_SkkLKv0cyZdvVjiGOR9dQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2017-03-14 at 10:58 +0100, Linus Walleij wrote:
> On Thu, Mar 2, 2017 at 2:48 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Introduce device managed variant of acpi_dev_add_driver_gpios() and
> > its
> > counterpart acpi_dev_remove_driver_gpios().
> > 
> > The functions in most cases are used in driver's ->probe() and
> > ->remove() callbacks, that's why it's useful to have managed variant
> > of
> > them.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > This is supposed to go through GPIO tree.
> > 
> > Linus, can you create an immutable branch that other subsystems can
> > use
> > it if needed?
> 
> I have created ib-acpi-devm in the GPIO tree based on v4.11-rc1,
> applied
> this patch and merged that into my devel branch.
> 
> Anyone who needs it can grab that branch, I will push it out later.

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
