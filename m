From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: Export mutex functions
Date: Sat, 15 Apr 2017 00:30:12 +0200
Message-ID: <2456461.gJP0PmoWKK@aspire.rjw.lan>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net> <20170412212241.GA12384@roeck-us.net> <94F2FBAB4432B54E8AACC7DFDE6C92E37E592822@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54434 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751371AbdDNWgN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 18:36:13 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E592822@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, April 12, 2017 09:56:37 PM Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Sent: Wednesday, April 12, 2017 2:23 PM
> > To: Moore, Robert <robert.moore@intel.com>
> > Cc: Zheng, Lv <lv.zheng@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; linux-
> > acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > 
> > On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > > The ACPICA mutex functions are based on the host OS functions, so they
> > don't really buy you anything. You should just use the native Linux
> > functions.
> > >
> > 
> > You mean they don't really acquire the requested ACPI mutex, and the
> > underlying DSDT which declares and uses the mutex just ignores if the
> > mutex was acquired by acpi_acquire_mutex() ?
> > 
> [Moore, Robert] 
> 
> OK, I understand now. Yes, these mutex interfaces are in fact intended for the purpose you mention:
> 
> * FUNCTION:    AcpiAcquireMutex
>  *
>  * PARAMETERS:  Handle              - Mutex or prefix handle (optional)
>  *              Pathname            - Mutex pathname (optional)
>  *              Timeout             - Max time to wait for the lock (millisec)
>  *
>  * RETURN:      Status
>  *
>  * DESCRIPTION: Acquire an AML mutex. This is a device driver interface to
>  *              AML mutex objects, and allows for transaction locking between
>  *              drivers and AML code. The mutex node is pointed to by
>  *              Handle:Pathname. Either Handle or Pathname can be NULL, but
>  *              not both.
> 
> 
> And yes, both the acquire and release interfaces should be exported.

OK, so I'm assuming this will go in through the upstream ACPICA.

Thanks,
Rafael

