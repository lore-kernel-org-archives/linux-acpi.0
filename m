From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:46:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93D1C@SHSMSX101.ccr.corp.intel.com>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
 <20170417194527.GA16734@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170417194527.GA16734@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 'Len Brown' <lenb@kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'devel@acpica.org'" <devel@acpica.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Tuesday, April 18, 2017 3:45 AM
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> 
> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Moore, Robert
> > > Sent: Monday, April 17, 2017 10:13 AM
> > > To: Guenter Roeck <linux@roeck-us.net>; Zheng, Lv <lv.zheng@intel.com>
> > > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> > > <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >
> > > There is a model for the drivers to directly acquire an AML mutex
> > > object. That is why the acquire/release public interfaces were added to
> > > ACPICA.
> > >
> > > I forget all of the details, but the model was developed with MS and
> > > others during the ACPI 6.0 timeframe.
> > >
> > >
> > [Moore, Robert]
> >
> >
> > Here is the case where the OS may need to directly acquire an AML mutex:
> >
> > From the ACPI spec:
> >
> > 19.6.2 Acquire (Acquire a Mutex)
> >
> > Note: For Mutex objects referenced by a _DLM object, the host OS may also contend for ownership.
> >
> From the context in the dsdt, and from description of expected use cases for
> _DLM objects I can find, this is what the mutex is used for (to serialize
> access to a resource on a low pin count serial interconnect, aka LPC).
> 
> What does that mean in practice ? That I am not supposed to use it because
> it doesn't follow standard ACPI mutex declaration rules ?
> 

Could you find related _DLMs in your DSDT?
If there is any, could you please post it here for reference?

Thanks
Lv

> Thanks,
> Guenter
> 
> >
> >
> >
> > Other than this case, the OS/drivers should never need to directly acquire an AML mutex.
> > Bob
> >
