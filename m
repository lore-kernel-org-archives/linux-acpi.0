From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI / gpio: Add support for naming GPIOs
Date: Sun, 9 Oct 2016 20:08:15 +0300
Message-ID: <CAHp75Vf9Sw63tGbdv2X+fqcsBzi=6vbfPOvfPHcBi2WcC5R6Rg@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
 <20160929133944.158596-3-mika.westerberg@linux.intel.com> <CAHp75Ve8QctOkt58tXeMpLTqeE5s_jTqjr7D46u41bXPg_NiBw@mail.gmail.com>
 <20161009150127.GY30800@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36504 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbcJIRIR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Oct 2016 13:08:17 -0400
In-Reply-To: <20161009150127.GY30800@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Oct 9, 2016 at 6:01 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Fri, Oct 07, 2016 at 08:05:14PM +0300, Andy Shevchenko wrote:
>> On Thu, Sep 29, 2016 at 4:39 PM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:

>> > +       if (!chip->names)
>> > +               acpi_gpiochip_set_names(acpi_gpio);
>> > +
>>
>> I'm okay with this, though wouldn't be better to call it
>> unconditionally like it's done for below call and move check inside?
>
> DT does it like this. I can move the check inside the function as well.

Up to you. If it even worth to change.

-- 
With Best Regards,
Andy Shevchenko
