From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / LPSS: Remove lpss_iosf_enter_d3_state()
Date: Tue, 27 Jun 2017 17:38:13 +0300
Message-ID: <1498574293.22624.203.camel@linux.intel.com>
References: <20170626215700.14445-1-hdegoede@redhat.com>
         <20170626215700.14445-2-hdegoede@redhat.com>
         <1498570276.22624.191.camel@linux.intel.com>
         <015e7c83-9ee1-5d0f-5c79-1db71278aa79@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64958 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdF0OiW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Jun 2017 10:38:22 -0400
In-Reply-To: <015e7c83-9ee1-5d0f-5c79-1db71278aa79@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 2017-06-27 at 15:56 +0200, Hans de Goede wrote:
> Hi,
> 
> On 06/27/2017 03:31 PM, Andy Shevchenko wrote:
> > On Mon, 2017-06-26 at 23:57 +0200, Hans de Goede wrote:
> > 
> > I didn't get why the first patch exists if you effectively remove
> > what
> > it brought here.
> 
> The first patch calls lpss_iosf_exit_d3_state() on activate, but
> if you're right that the probe functions will cause a runtime_resume
> when enabling runtime-pm then that may not be necessary. If that is
> right it does make one wonder why we have the activate function at all
> though? I guess to de-assert the reset ? But shouldn't that then not
> be
> all it does ?

Sorry for misleading comment.

ACPI (and so platform drivers) should take care of power (runtime PM) by
themselves.

So, I dunno how to make the code less uglifying except put
pm_runtime_get_sync() on each ->probe() of LPSS drivers. Perhaps your
patch does that in better way and we may get rid of DW DMA uglified
piece of code.

> 
> > 
> > > If lpss_iosf_enter_d3_state() hits the code path where it actually
> > > puts the DMA controllers into D3, then, at least on Bay Trail, the
> > > LPSS
> > > PWM controller will stop working / gets stuck. After this
> > > happening
> > > the
> > > PWM controller's control reg will always reads 0x00010000 and
> > > writes
> > > seem to be ignored.
> > > 
> > > Note that the chances of this code-path actually being hit are
> > > actually
> > > very low. On Bay Trail devices with an AXP288 PMIC and on any
> > > Cherry
> > > Trail
> > > device, the I2C controller connected to the PMIC has (runtime)
> > > suspend
> > > disabled, so the condition of all LPSS and SCC devices being in D3
> > > will
> > > never happen.
> > > 
> > > Even on Bay Trail devices with another PMIC testing has shown that
> > > lpss_iosf_enter_d3_state() will only put the DMA controllers in D3
> > > during
> > > early boot when not all devices have been initialized yet, which
> > > is
> > > enough
> > > to get the PWM controller stuck, while not resulting in any
> > > significant
> > > power saving as this only happens during boot.
> > > 
> > > So in practice lpss_iosf_enter_d3_state() is almost always a no-op 
> > > and
> > > when it is not, it is causing problems. Therefor this commit
> > > simply
> > > removes it.
> > 
> > Let's continue discuss in your letter regarding IOSF LPSS stuff.
> 
> Ok.
> 
> Regards,
> 
> Hans

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
