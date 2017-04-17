From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 19:35:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E593480@ORSMSX110.amr.corp.intel.com>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753679AbdDQTfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Apr 2017 15:35:43 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Guenter Roeck' <linux@roeck-us.net>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 'Len Brown' <lenb@kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'devel@acpica.org'" <devel@acpica.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>



> -----Original Message-----
> From: Moore, Robert
> Sent: Monday, April 17, 2017 12:28 PM
> To: 'Guenter Roeck' <linux@roeck-us.net>; Zheng, Lv <lv.zheng@intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; 'Len Brown'
> <lenb@kernel.org>; 'linux-acpi@vger.kernel.org' <linux-
> acpi@vger.kernel.org>; 'devel@acpica.org' <devel@acpica.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; Box, David E
> (david.e.box@intel.com) <david.e.box@intel.com>
> Subject: RE: [PATCH] ACPICA: Export mutex functions
> 
> 
> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, April 17, 2017 10:13 AM
> > To: Guenter Roeck <linux@roeck-us.net>; Zheng, Lv <lv.zheng@intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> > <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux- kernel@vger.kernel.org
> > Subject: RE: [PATCH] ACPICA: Export mutex functions
> >
> > There is a model for the drivers to directly acquire an AML mutex
> > object. That is why the acquire/release public interfaces were added
> > to ACPICA.
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
> Note: For Mutex objects referenced by a _DLM object, the host OS may
> also contend for ownership.
> 
> Other than this case, the OS/drivers should never need to directly
> acquire an AML mutex.
> Bob

[Moore, Robert] 
Here is more information, from the ACPICA reference:

8.3.15 AcpiAcquireMutex

This function is intended to be used in conjunction with the _DLM (Device Lock Method) predefined name to directly acquire a mutex object that is defined in the ACPI namespace. The purpose of this is to provide a mutual exclusion mechanism between the AML interpreter and an ACPI-related device driver, in order to support multiple-operation transactions.

>From the ACPI Specification: "The _DLM object appears in a device scope when AML access to the device must be synchronized with the OS environment. It is used in conjunction with a standard Mutex object. With _DLM, the standard Mutex provides synchronization within the AML environment as usual, but also synchronizes with the OS environment."

The AML mutex node is pointed to by Parent:Pathname. Either the Parent or the Pathname can be NULL, but not both.

If the operation fails an appropriate status will be returned.


