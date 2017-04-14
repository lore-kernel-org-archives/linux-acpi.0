From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Fri, 14 Apr 2017 23:32:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E592F3B@ORSMSX110.amr.corp.intel.com>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
 <20170412212241.GA12384@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E592822@ORSMSX110.amr.corp.intel.com>
 <2456461.gJP0PmoWKK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:63835 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755233AbdDNXcu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 19:32:50 -0400
In-Reply-To: <2456461.gJP0PmoWKK@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Friday, April 14, 2017 3:30 PM
> To: Moore, Robert
> Cc: Guenter Roeck; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> 
> On Wednesday, April 12, 2017 09:56:37 PM Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > > Sent: Wednesday, April 12, 2017 2:23 PM
> > > To: Moore, Robert <robert.moore@intel.com>
> > > Cc: Zheng, Lv <lv.zheng@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; linux-
> > > acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >
> > > On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > > > The ACPICA mutex functions are based on the host OS functions, so
> > > > they
> > > don't really buy you anything. You should just use the native Linux
> > > functions.
> > > >
> > >
> > > You mean they don't really acquire the requested ACPI mutex, and the
> > > underlying DSDT which declares and uses the mutex just ignores if
> > > the mutex was acquired by acpi_acquire_mutex() ?
> > >
> > [Moore, Robert]
> >
> > OK, I understand now. Yes, these mutex interfaces are in fact intended
> for the purpose you mention:
> >
> > * FUNCTION:    AcpiAcquireMutex
> >  *
> >  * PARAMETERS:  Handle              - Mutex or prefix handle (optional)
> >  *              Pathname            - Mutex pathname (optional)
> >  *              Timeout             - Max time to wait for the lock
> (millisec)
> >  *
> >  * RETURN:      Status
> >  *
> >  * DESCRIPTION: Acquire an AML mutex. This is a device driver interface
> to
> >  *              AML mutex objects, and allows for transaction locking
> between
> >  *              drivers and AML code. The mutex node is pointed to by
> >  *              Handle:Pathname. Either Handle or Pathname can be NULL,
> but
> >  *              not both.
> >
> >
> > And yes, both the acquire and release interfaces should be exported.
> 
> OK, so I'm assuming this will go in through the upstream ACPICA.
> 

Yes, done for next release.
Bob



> Thanks,
> Rafael

