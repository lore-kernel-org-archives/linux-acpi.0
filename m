From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: commit 'ACPICA: Minimize the differences between linux GPE
 code and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 22:51:40 +0300
Message-ID: <1276285900.30124.2.camel@maxim-laptop>
References: <1276256839.4251.7.camel@maxim-laptop>
	 <201006112123.17706.rjw@sisk.pl>  <1276285623.30124.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:38746 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760559Ab0FKTvq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 15:51:46 -0400
Received: by fg-out-1718.google.com with SMTP id d23so408265fga.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jun 2010 12:51:45 -0700 (PDT)
In-Reply-To: <1276285623.30124.1.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg59 <mjg59@srcf.ucam.org>, len.brown@intel.com

On Fri, 2010-06-11 at 22:47 +0300, Maxim Levitsky wrote: 
> On Fri, 2010-06-11 at 21:23 +0200, Rafael J. Wysocki wrote: 
> > On Friday, June 11, 2010, Maxim Levitsky wrote:
> > > Just bisected it.
> > > 
> > > I also tried linux-acpi-next/test, and no change.
> > > 
> > > The sympthoms are that EC does't sent any GPEs, and therefore battery
> > > insert/removal events don't show up.
> > > 
> > > It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
> > > With regression the line is shown like this:
> > > 
> > > 
> > > /sys/firmware/acpi/interrupts/gpe1C:   1	enabled
> > > 
> > > Without regression it is
> > > 
> > > /sys/firmware/acpi/interrupts/gpe1C:   22889	enabled
> > > 
> > > and steadily increasing.
> > > 
> > > After suspend/resume, regression disappears.
> > 
> > Hmm.
> > 
> > Can you please apply the following patches:
> > 
> > https://patchwork.kernel.org/patch/104903/
> > https://patchwork.kernel.org/patch/104912/
> > https://patchwork.kernel.org/patch/104909/
> > https://patchwork.kernel.org/patch/104911/
> > https://patchwork.kernel.org/patch/104910/
> > 
> > on top of current -git and see if the problem is still there?
> > 
> > Rafael
> 
> These patch don't apply nether on top of linus tree nor on top of
> acpi-test tree (which includes these?)

Drat, I was in .patches folder, and this is why these didn't apply... 
> 
> (Patches weren't damaged I know how to get them from patchwork)
> 
> Best regards,
> Maxim Levitsky 
> 


