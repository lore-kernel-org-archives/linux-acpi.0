From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 3/4]  ACPI: Add "acpi.power_nocheck=1" to disable power
	state check in power transitio
Date: Fri, 18 Jul 2008 09:17:54 +0800
Message-ID: <1216343874.4135.11.camel@yakui_zhao.sh.intel.com>
References: <1216021174.32159.22.camel@yakui_zhao.sh.intel.com>
	 <487F3F98.8000305@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbYGRBGN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 21:06:13 -0400
In-Reply-To: <487F3F98.8000305@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-07-17 at 14:48 +0200, Andi Kleen wrote:
> As a general  comment I wonder if this problem is really wide spread enough
> to deserve an own command line option or if that could be just done
> with quirks.
Our target is that no power state check becomes the default. But maybe
it is too aggressive before more tests. 
When some people complain the similar problem, they can add the boot
option to confirm whether the problem can be fixed by the boot option. 
If the problem can be fixed, we can add the laptop/desktop to DMI check
table firstly.  After more tests, we expect that no power state check
becomes the default. In such case we can delete the DMI check table.

So now it is reasonable to deserve the command option.
> 
> > --- linux-2.6.orig/drivers/acpi/power.c
> > +++ linux-2.6/drivers/acpi/power.c
> > @@ -54,6 +54,14 @@ ACPI_MODULE_NAME("power");
> >  #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
> >  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
> >  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
> > +
> > +#ifdef MODULE_PARAM_PREFIX
> > +#undef MODULE_PARAM_PREFIX
> > +#endif
> 
> How can MODULE_PARAM_PREFIX be set here?
There exists the following macro definition in the
include/linux/moduleparam.h

#ifdef MODULE
#define MODULE_PARAM_PREFIX /* empty */
#else
#define MODULE_PARAM_PREFIX KBUILD_MODNAME "."
#endif

When this file is included, there will exist the macro defintion of
"MODULE_PARAM_PREFIX". So it is necessary to override it.

Thanks 
  Yakui
> -Andi

