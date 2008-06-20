From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 19:01:20 -0300
Message-ID: <20080620220120.GB3417@khazad-dum.debian.net>
References: <20080620152227.GA11828@srcf.ucam.org> <20080620193941.GC20498@khazad-dum.debian.net> <20080620195840.GA16284@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52148 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755438AbYFTWBY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 18:01:24 -0400
Content-Disposition: inline
In-Reply-To: <20080620195840.GA16284@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, 20 Jun 2008, Matthew Garrett wrote:
> On Fri, Jun 20, 2008 at 04:39:41PM -0300, Henrique de Moraes Holschuh wrote:
> > With such ACPI notifies, you could have HAL do some of the stuff kernel
> > drivers are doing.  So far so good (well, sort of).
> 
> That's not what I was thinking. Right now, older Thinkpads need polling 
> if you want to get some keyboard events. However, the BIOS seems to 
> impleemnt this by calling the ACPI CMOS update methods. Rather than 
> polling, we can therefore make it event driven. The events won't go out 
> to userspace, they'll just call a callback in the driver which then 
> generates input events or uevents or whatever.

Sounds like a good idea, but in order to do that, we just need to let
kernel drivers hook to GPE handlers somehow.  I'd be quite happy to add
support for it to thinkpad-acpi.

I thought your patch did a lot more than this.  If I am wrong about it,
I apologise.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
