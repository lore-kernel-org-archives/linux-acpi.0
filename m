From: Len Brown <lenb@kernel.org>
Subject: Re: battery: current a factor of 10 off?
Date: Wed, 26 Nov 2008 17:27:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811261727140.3895@localhost.localdomain>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>
 <8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
 <4926C87D.20308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34617 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYKZW14 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2008 17:27:56 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAY0024GP2955Y8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 26 Nov 2008 16:27:46 -0600 (CST)
In-reply-to: <4926C87D.20308@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-acpi@vger.kernel.org

trailing whitespace repaired.
applied for 2.6.28.

thanks,
-Len


On Fri, 21 Nov 2008, Alexey Starikovskiy wrote:

> Hi Ferenc,
> This patch should be better -- no integer overflow.
> 
> Regards,
> Alex.
> 
> Alexey Starikovskiy wrote:
> > Hi Ferenc,
> > 
> > Good catch.
> > ACPI battery interface report its state either in mW or in mA, and
> > discharge rate
> > in your case is reported in mW. power_supply interface does not have
> > such a parameter,
> > so current_now parameter is used for all cases. But in case of mW,
> > reported discharge should
> > be converted into mA.
> > 
> > Please test the attached patch.
> > 
> > Thanks,
> > Alex.
> > 
> > On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
> >   
> > > Hi,
> > > 
> > > on my ThinkPad R50e the current_now reading seems something like 10
> > > times the actual value.  Documentation/power/power_supply_class.txt
> > > says it's in uA, and a tipical discharge value is around 15259000,
> > > that is, 15 A on my system.  At the same time voltage is 11756000,
> > > that is, 12 V, which sounds reasonable, but then the power is 15*12 VA,
> > > ie 180 W, which is insane.  However, the numerical derivative of
> > > energy_now gives 18 W, which is both reasonable and consistent with
> > > the assumed factor of 10 error in current_now.  Is this possibly a bug
> > > in 2.6.26.6?  During a quick glance over battery.c nothing obvious
> > > jumped at me, but I'm no expert on this.
> > > --
> > > Thanks,
> > > Feri.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > >     
> 
> 
