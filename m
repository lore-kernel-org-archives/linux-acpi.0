From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:43:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93CFF@SHSMSX101.ccr.corp.intel.com>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48961 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbdDQXnS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Apr 2017 19:43:18 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, 'Guenter Roeck' <linux@roeck-us.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 'Len Brown' <lenb@kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'devel@acpica.org'" <devel@acpica.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

Hi,

> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, April 18, 2017 3:28 AM
> To: 'Guenter Roeck' <linux@roeck-us.net>; Zheng, Lv <lv.zheng@intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; 'Len Brown' <lenb@kernel.org>; 'linux-
> acpi@vger.kernel.org' <linux-acpi@vger.kernel.org>; 'devel@acpica.org' <devel@acpica.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; Box, David E <david.e.box@intel.com>
> Subject: RE: [PATCH] ACPICA: Export mutex functions
> 
> 
> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, April 17, 2017 10:13 AM
> > To: Guenter Roeck <linux@roeck-us.net>; Zheng, Lv <lv.zheng@intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> > <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > kernel@vger.kernel.org
> > Subject: RE: [PATCH] ACPICA: Export mutex functions
> >
> > There is a model for the drivers to directly acquire an AML mutex
> > object. That is why the acquire/release public interfaces were added to
> > ACPICA.
> >
> > I forget all of the details, but the model was developed with MS and
> > others during the ACPI 6.0 timeframe.
> >
> >
> [Moore, Robert]
> 
> 
> Here is the case where the OS may need to directly acquire an AML mutex:
> 
> From the ACPI spec:
> 
> 19.6.2 Acquire (Acquire a Mutex)
> 
> Note: For Mutex objects referenced by a _DLM object, the host OS may also contend for ownership.
> 
> 
> 
> 
> Other than this case, the OS/drivers should never need to directly acquire an AML mutex.

That sounds reasonable but the driver might invoke an ACPICA API accessing the _DLM returned mutexes.

Thanks and best regards
Lv

