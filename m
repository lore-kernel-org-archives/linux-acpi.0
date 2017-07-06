From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table for the first PWM
 controller
Date: Thu, 06 Jul 2017 21:19:04 +0300
Message-ID: <1499365144.22624.296.camel@linux.intel.com>
References: <20170706164927.15076-1-hdegoede@redhat.com>
         <1499361099.22624.292.camel@linux.intel.com>
         <5a6aa544-fbe5-6eb2-901f-39a3814cea1d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdGFSUu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jul 2017 14:20:50 -0400
In-Reply-To: <5a6aa544-fbe5-6eb2-901f-39a3814cea1d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org

On Thu, 2017-07-06 at 20:08 +0200, Hans de Goede wrote:
> On 06-07-17 19:11, Andy Shevchenko wrote:
> > On Thu, 2017-07-06 at 18:49 +0200, Hans de Goede wrote:
> > > 

> > By the way, do you need a shell script that allows to setup pin
> > muxing
> > via external CPLD?
> 
> Thanks, but no thanks I don't want to make physical alterations to
> my boards.

I surprised it works for you by default. I have UP board (BIOS v0.4)
which doesn't provide any useful output since CPLD is configured by BIOS
to most safe state.

But okay, feel free to ask when you need it. Perhaps at some point I
just submit it to Github as a gist.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
