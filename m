From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: the errors about two EC patches
Date: Thu, 11 Sep 2008 17:16:19 +0800
Message-ID: <1221124579.3989.254.camel@yakui_zhao.sh.intel.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>
	 <48C7BF94.6010204@gmail.com>
	 <1221100968.3989.224.camel@yakui_zhao.sh.intel.com>
	 <48C8D348.6050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32724 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYIKJBj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 05:01:39 -0400
In-Reply-To: <48C8D348.6050209@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com

On Thu, 2008-09-11 at 12:14 +0400, Alexey Starikovskiy wrote:
> >
> > But we should investigate why EC transaction is not finished when
> > timeout happens. Is it related with EC hardware or EC driver?
> > If EC can't update the status register in time after issuing
> > command/address, it is reasonable that it is regarded as timeout. If
> > not, maybe it is related with the EC driver.
> >
> >   
> We should investigate that only if we receive such timeouts.
> This is clearly only needed for debug purposes, as no user
> of EC driver is interested in why exactly it did not made a
> transaction, only that it failed temporarily (as opposed to
> -EFAIL or -ENODEV), which indicate permanent failure.
> Thus, there is no reason to make flowchart (your favorite)
> any more complex.
    If the timeout is caused by that EC controller can't return response
in time, it is reasonable that it can be regarded as -ETIME. It
indicates that EC can't work well. 
    But if the timeout is caused by that OS has no opportunity to issue
the EC command set completely, IMO it is not reasonable that it is
regarded as -ETIME. If such an error happens while turning on the FAN
device through EC, maybe the catastrophic accident will happen.

   Maybe it is faster to do transaction directly from interrupt context.
But in some case EC transaction can't be processed correctly although EC
controller works well.
   IMO it is not very stable that OS does transaction directly from
interrupt context.
   
   
> > Based on the above analysis IMO the flow of EC transaction is quite
> > reasonable. Of course what should be improved is how to make it
> > reasonable when waiting whether EC status is what OS expected.
> >
> > Please check whether the attached is reasonable.
> >
> > Of course in the attached patch there is no detect mechanism of EC GPE
> > interrupt storm.
> >
> >   
> Regards,
> Alex.

