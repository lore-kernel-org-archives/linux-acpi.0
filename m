From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]  ACPI / Video: Fix initial brightness problem on Acer
 Ferrari One
Date: Wed, 07 Apr 2010 13:47:19 +0800
Message-ID: <1270619239.24064.4965.camel@rzhang1-desktop>
References: <201004010319.19366.rjw@sisk.pl>
	 <201004050119.19790.rjw@sisk.pl>
	 <1270533897.24064.4575.camel@rzhang1-desktop>
	 <201004062051.16998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16780 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab0DGFqU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Apr 2010 01:46:20 -0400
In-Reply-To: <201004062051.16998.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>

On Wed, 2010-04-07 at 02:51 +0800, Rafael J. Wysocki wrote:
> On Tuesday 06 April 2010, Zhang Rui wrote:
> > On Mon, 2010-04-05 at 07:19 +0800, Rafael J. Wysocki wrote:
> > > On Friday 02 April 2010, Rafael J. Wysocki wrote:
> > > > On Friday 02 April 2010, Zhang Rui wrote:
> > > > > On Fri, 2010-04-02 at 03:45 +0800, Rafael J. Wysocki wrote:
> > > > > > On Thursday 01 April 2010, Zhang Rui wrote:
> > > > > > > On Thu, 2010-04-01 at 09:34 +0800, Zhang Rui wrote:
> > > > > > > > On Thu, 2010-04-01 at 09:19 +0800, Rafael J. Wysocki wrote:
> > > 
> > > This patch may not be necessary after all.
> > > 
> > > I'll repost it if I find it's still needed.
> > > 
> > okay.
> > I re-read the code and find out that you're right. sorry for the noise.
> > 
> > please feel free to add an Acked-by from me next time you send it to the
> > list.
> 
> Thanks, but it looks like only one box is affected and because its BIOS returns
> the minimal brightness value in the initial _BQC.

> I'm not sure if it's worth
> changing the current behavior because of that.
> 

well. in the ACPI video driver, we assume that BIOS sets a PROPER
brightness level when loading OS.
so we use the _BQC return value as the default backlight, but apparently
this doesn't work well in this BIOS.
I would rather say this is a BIOS problem, which I'm not sure if we
should fix it in Linux kernel or not...

thanks,
rui

> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


