From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 18:52:35 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BB8@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usea-naimss3.unisys.com ([192.61.61.105]:784 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S965038AbWEBXwk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 19:52:40 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, akpm@digeo.com
Cc: sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, kmurray@redhat.com, linux-acpi@vger.kernel.org

> On Tuesday 02 May 2006 09:41, Brown, Len wrote:
> 
> > You are right.  This code is wrong.
> > It makes absolutely no sense to reserve vectors in advance 
> for every 
> > RTE in the IOAPIC when we don't even know if they are going to be 
> > used.
> > 
> > This is clearly a holdover from the early IOAPIC/MPS days 
> when we were 
> > talking about 4 to 8 non-legacy RTEs.
> 
> Yes I agree. A lot of the IO-APIC code could probably need 
> some renovation.
>  
> > This is where the big system vector shortage problem should be 
> > addressed.
> 
> If we go to per CPU IDTs it will be much less pressing, but 
> still a good idea.
> 

I've been trying to put together something on per-CPU IDTs also, and got
entangled in all those issues that you just discussed... Dynamically
assigning vectors to IRQs sounds like great improvement of the mechanism
(why would they need to be static really), and vectors are right
entities to manipulate with - while keeping IRQs stable and representing
the interrupts sources clearly to the user.
Len, I suppose it would make sense to accept the Kimball's timer fix for
now, before the whole re-implementation happens?

--Natalie
