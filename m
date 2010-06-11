From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: commit 'ACPICA: Minimize the differences between linux GPE
 code and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 23:32:02 +0300
Message-ID: <1276288322.2651.4.camel@maxim-laptop>
References: <1276256839.4251.7.camel@maxim-laptop>
	 <201006112123.17706.rjw@sisk.pl>  <201006112143.54654.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:24263 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815Ab0FKUcI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 16:32:08 -0400
Received: by fg-out-1718.google.com with SMTP id d23so424414fga.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jun 2010 13:32:06 -0700 (PDT)
In-Reply-To: <201006112143.54654.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg59 <mjg59@srcf.ucam.org>, len.brown@intel.com, "Moore, Robert" <robert.moore@intel.com>, Linux PM <linux-pm@lists.linux-foundation.org>

On Fri, 2010-06-11 at 21:43 +0200, Rafael J. Wysocki wrote: 
> On Friday, June 11, 2010, Rafael J. Wysocki wrote:
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
> 
> Also, regardless of whether or not this helps, please try to revert only the
> changes made by the "guilty" commit in drivers/acpi/acpica/evxface.c and see
> if that helps (this revert will conflict with the patches above, so you'll need
> to unapply them before).
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Yes, reverting changes in 'drivers/acpi/acpica/evxface.c' do restore
correct behavior.

Best regards,
Maxim Levitsky

