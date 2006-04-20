From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: how to back from suspend without shutdown
Date: Thu, 20 Apr 2006 18:07:01 +0100
Message-ID: <1145552821.2888.2.camel@localhost.localdomain>
References: <1145454577.14935.13.camel@localhost.localdomain>
	 <200604201121.03452.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:59088 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751173AbWDTRHM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 13:07:12 -0400
In-Reply-To: <200604201121.03452.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: acpi devel <linux-acpi@vger.kernel.org>

Hi,
unload acpid (service acipd stop)  before suspend is more easy and
works.

thanks,

On Thu, 2006-04-20 at 11:20 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 19 April 2006 23:49, Sergio Monteiro Basto wrote:
> > Hi everybody,
> > I have a new laptop one HP Compaq NX6110 , that works quite well with
> > suspend and hibernation.
> >
> > But after suspend , how I bring back computer ?, the only key that I
> > know is power button, but after press power button and laptop wake-up,
> > Begins the shutdown process because is triggered the power button
> > shutdown .
> > any ideas ?
> >
> > Other question klaptop let me choose performance profile:
> >  userspace or performance, which one is better ? and why ?
> >
> > Klaptop allows also to define CPU throttling which is in 00% but I can
> > choose 0,12 25, 37, 50, 62, 75 and 87. What is the propose of this
> > settings ?
> >
> > thanks in advance ,
> 
> Try building acpi button support as a module and unloading it during the 
> cycle.
> 
> Regards,
> 
> Nigel

