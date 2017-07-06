From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table for the first PWM controller
Date: Thu, 06 Jul 2017 22:44:55 +0200
Message-ID: <6978852.i014fFYBpT@aspire.rjw.lan>
References: <20170706164927.15076-1-hdegoede@redhat.com> <1499361099.22624.292.camel@linux.intel.com> <5a6aa544-fbe5-6eb2-901f-39a3814cea1d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49665 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751974AbdGFUwm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2017 16:52:42 -0400
In-Reply-To: <5a6aa544-fbe5-6eb2-901f-39a3814cea1d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

On Thursday, July 06, 2017 08:08:03 PM Hans de Goede wrote:
> Hi,
> 
> On 06-07-17 19:11, Andy Shevchenko wrote:
> > On Thu, 2017-07-06 at 18:49 +0200, Hans de Goede wrote:
> >> At least on the UP board SBC both PWMs are enabled leading to us
> >> trying to add the same pwm_lookup twice, which leads to the following:
> >>
> >> [    0.902224] list_add double add: new=ffffffffb8efd400,
> >>                 prev=ffffffffb8efd400, next=ffffffffb8eeede0.
> >> [    0.912466] ------------[ cut here ]------------
> >> [    0.917624] kernel BUG at lib/list_debug.c:31!
> >> [    0.922588] invalid opcode: 0000 [#1] SMP
> >> ...
> >> [    1.027450] Call Trace:
> >> [    1.030185]  pwm_add_table+0x4c/0x90
> >> [    1.034181]  bsw_pwm_setup+0x1a/0x20
> >> [    1.038175]  acpi_lpss_create_device+0xfe/0x420
> >> ...
> >>
> >> This commit fixes this by only calling pwm_add_table for the first
> >> PWM controller (which is the one used for the backlight).
> >>
> > 
> > Thanks, my comment below.
> > 
> > For the quick fix I agree on this:
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you.
> 
> Rafael, can we get this added to 4.13 soonish please ? One of the 2
> commits this fixes has been causing trouble for some users since 4.11.3.

Should be possible.

Thanks,
Rafael

