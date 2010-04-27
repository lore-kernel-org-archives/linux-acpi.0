From: jeff@jgarrett.org (Jeff Garrett)
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Tue, 27 Apr 2010 07:47:03 -0500
Message-ID: <20100427124703.GA16706@jgarrett.org>
References: <20100126084740.GA5265@jgarrett.org>
 <87y6jkee1b.fsf@basil.nowhere.org>
 <20100205160900.GA2736@jgarrett.org>
 <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
 <20100426194002.586fbaa5@fido5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jgarrett.org ([64.5.53.252]:33866 "EHLO jgarrett.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab0D0NOI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 09:14:08 -0400
Content-Disposition: inline
In-Reply-To: <20100426194002.586fbaa5@fido5>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Apr 26, 2010 at 07:40:02PM -0700, Philip Langdale wrote:
> On Fri, 05 Feb 2010 12:45:21 -0500 (EST)
> Len Brown <lenb@kernel.org> wrote:
> > Jeff,
> > What do you see if you apply just the patch below?
> > 
> > Also, in addition to "powertop -d" to show what the kernel requests,
> > please run turbostat to show what the hardware actually did:
> > 
> > http://userweb.kernel.org/~lenb/acpi/utils/pmtools-latest/turbostat/turbostat.c
> > 
> > eg.
> > # turbostat -d -v sleep 5
> > 
> > thanks,
> > -Len Brown, Intel Open Source Technology Center
> > ---
> 
> To resurrect this thread...
> 
> I have a giga-byte GA-P55M-UD4 motherboard and I have this same problem
> as well. Len's patch "works" in that I see C6 being used, but it also
> cripples the system - if I do a make -j16 kernel build, I see most jobs
> serialized onto one or two cores. Without the patch, I see the
> full utilization of all 8 hyper-threads as expected.
> 
> Now, gigabyte have already b0rked these boards up by using the UHCI
> controllers on the PCH instead of the rate matching hubs. Maybe that's
> directly the cause of BM activity - maybe they screwed something else
> up - is it possible for BIOS/ACPI mistakes to lead to this behaviour?
> 
> Jeff - is your board gigabyte too?
> 
> --phil

My board identifies it as a Dell.  No idea if they rebranded a gigabyte.

The patch seems to work for me as well, powertop shows 97.5% c3,
turbostat shows 93.6% c6 now.  I do get weird latency spikes (on I/O)
from time to time.

When I was investigating, I completely configured USB off, and it still
wouldn't go into deep sleep.  Not sure how well that meshes with your
UHCI theory.

-Jeff
