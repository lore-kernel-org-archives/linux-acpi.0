From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 'ACPICA: Minimize the differences between linux GPE code and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 21:23:17 +0200
Message-ID: <201006112123.17706.rjw@sisk.pl>
References: <1276256839.4251.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54108 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756819Ab0FKTZM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 15:25:12 -0400
In-Reply-To: <1276256839.4251.7.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg59 <mjg59@srcf.ucam.org>, len.brown@intel.com

On Friday, June 11, 2010, Maxim Levitsky wrote:
> Just bisected it.
> 
> I also tried linux-acpi-next/test, and no change.
> 
> The sympthoms are that EC does't sent any GPEs, and therefore battery
> insert/removal events don't show up.
> 
> It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
> With regression the line is shown like this:
> 
> 
> /sys/firmware/acpi/interrupts/gpe1C:   1	enabled
> 
> Without regression it is
> 
> /sys/firmware/acpi/interrupts/gpe1C:   22889	enabled
> 
> and steadily increasing.
> 
> After suspend/resume, regression disappears.

Hmm.

Can you please apply the following patches:

https://patchwork.kernel.org/patch/104903/
https://patchwork.kernel.org/patch/104912/
https://patchwork.kernel.org/patch/104909/
https://patchwork.kernel.org/patch/104911/
https://patchwork.kernel.org/patch/104910/

on top of current -git and see if the problem is still there?

Rafael
