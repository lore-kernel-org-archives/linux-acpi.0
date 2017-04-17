From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:53:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93D3A@SHSMSX101.ccr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
 <20170417194527.GA16734@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E593580@ORSMSX110.amr.corp.intel.com>
 <20170417210353.GA19771@roeck-us.net>
 <CAJZ5v0jyxRH_B7Yj7HxRdxhofZjgRf175WqmyjtsupWPQYx6tQ@mail.gmail.com>
 <20170417223257.GA22495@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8567 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757885AbdDQXx5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Apr 2017 19:53:57 -0400
In-Reply-To: <20170417223257.GA22495@roeck-us.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

Hi,

> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> 
> On Mon, Apr 17, 2017 at 11:29:38PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Apr 17, 2017 at 11:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Mon, Apr 17, 2017 at 08:40:38PM +0000, Moore, Robert wrote:
> > >>
> > >>
> > >> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > >> > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >> >
> > >> > On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> > >> > >
> > >> > > > From: Moore, Robert
> > >> > > > Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >> > > >
> > >> > > > There is a model for the drivers to directly acquire an AML mutex
> > >> > > > object. That is why the acquire/release public interfaces were added
> > >> > > > to ACPICA.
> > >> > > >
> > >> > > > I forget all of the details, but the model was developed with MS and
> > >> > > > others during the ACPI 6.0 timeframe.
> > >> > > >
> > >> > > >
> > >> > > [Moore, Robert]
> > >> > >
> > >> > >
> > >> > > Here is the case where the OS may need to directly acquire an AML
> > >> > mutex:
> > >> > >
> > >> > > From the ACPI spec:
> > >> > >
> > >> > > 19.6.2 Acquire (Acquire a Mutex)
> > >> > >
> > >> > > Note: For Mutex objects referenced by a _DLM object, the host OS may
> > >> > also contend for ownership.
> > >> > >
> > >> > From the context in the dsdt, and from description of expected use cases
> > >> > for _DLM objects I can find, this is what the mutex is used for (to
> > >> > serialize access to a resource on a low pin count serial interconnect,
> > >> > aka LPC).
> > >> >
> > >> > What does that mean in practice ? That I am not supposed to use it
> > >> > because it doesn't follow standard ACPI mutex declaration rules ?
> > >> >
> > >> > Thanks,
> > >> > Guenter
> > >> >
> > >> > >
> > >> [Moore, Robert]
> > >>
> > >> I'm not an expert on the _DLM method, but I would point you to the description section in the
> ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).
> > >>
> > >
> > > I did. However, not being an ACPI expert, that doesn't tell me anything.
> >
> > Basically, if the kernel and AML need to access a device concurrently,
> > there should be a _DLM object under that device in the ACPI tables.
> > In that case it is expected to return a list of (AML) mutexes that can
> > be acquired by the kernel in order to synchronize device access with
> > respect to AML (and for each mutex it may also return a description of
> > the specific resources to be protected by it).
> >
> > Bottom line: without _DLM, the kernel cannot synchronize things with
> > respect to AML properly, because it has no information how to do that
> > then.
> 
> That is all quite interesting. I do see the mutex in question used on various
> motherboards from various vendors (I checked boards from Gigabyte, MSI, and
> Intel). Interestingly, the naming seems to be consistent - it is always named
> "MUT0". For the most part, it seems to be available on more recent
> motherboards; older motherboards tend to use the resource without locking.
> However, I don't see any mention of "_DLM" in any of the DSDTs.
> 

OK, then you might be having problems in your opregion driver.

> At the same time, access to ports 0x2e/0x2f is widely used in the kernel.
> As mentioned before, it is used in watchdog, hardware monitoring, and gpio
> drivers, but also in parallel port and infrared driver code. Effectively
> that means that all this code is inherently unsafe on systems with ACPI
> support.
> 
> I had thought about implementing a set of utility functions to make the kernel
> code safer to use if the mutex is found to exist.

As what you've mentioned, there are already lots of parallel accesses in kernel without enabling ACPI.
Are these accesses mutually exclusive (safe)?
If so, why do you need to invent a new synchronization mechanism?

> Right now I wonder, though,
> if such code would have a chance to be accepted. Any thoughts on that ?

Is that possible to make it safe in the opregion driver?

Thanks
Lv
