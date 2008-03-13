From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Thu, 13 Mar 2008 15:59:32 +0100
Message-ID: <20080313145932.GA17940@kernel.dk>
References: <20080313120514.GH17940@kernel.dk> <20080313122344.GD27873@ics.muni.cz> <20080313124633.GS17940@kernel.dk> <20080313125503.GE27873@ics.muni.cz> <20080313125933.GT17940@kernel.dk> <20080313130934.GG27873@ics.muni.cz> <20080313131334.GV17940@kernel.dk> <47D93C2C.8040907@gmail.com> <20080313143930.GZ17940@kernel.dk> <47D93F95.50807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:3791 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbYCMO7g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 10:59:36 -0400
Content-Disposition: inline
In-Reply-To: <47D93F95.50807@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Arkadiusz Miskiewicz <arekm@maven.pl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 13 2008, Alexey Starikovskiy wrote:
> Jens Axboe wrote:
> >On Thu, Mar 13 2008, Alexey Starikovskiy wrote:
> >  
> >>Jens Axboe wrote:
> >>    
> >>>On Thu, Mar 13 2008, Lukas Hejtmanek wrote:
> >>> 
> >>>      
> >>>>On Thu, Mar 13, 2008 at 01:59:34PM +0100, Jens Axboe wrote:
> >>>>   
> >>>>        
> >>>>>The BIOS isn't that old, probably updated it a couple of months ago.
> >>>>>     
> >>>>>          
> >>>>I use the latest BIOS for my T61 and it just works. At least the event 
> >>>>is
> >>>>generated either for acpid or for Xserver.
> >>>>   
> >>>>        
> >>>This is an x60, so there may be other differences there.
> >>>
> >>> 
> >>>      
> >>There are was some playing with acpi_osi=Linux in this timeframe, known
> >>to deal with sound buttons too.
> >>Some of Thinkpads were inserted into the blacklist to need this OSI.
> >>It might be that your Thinkpad needs it too...
> >>    
> >
> >Please talk to me like I'm an ACPI ignorant - because I am. Where is
> >this blacklist?
> >
> >  
> drivers/acpi/blacklist.c:485.
> You probably could set acp_osi=Linux as kernel parameter to check if it 
> helps.

I booted with acpi_osi=Linux and it has made no difference.

-- 
Jens Axboe

