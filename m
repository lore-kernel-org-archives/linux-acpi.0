From: Philip Langdale <philipl@overt.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Fri, 30 Apr 2010 07:57:03 -0700
Message-ID: <20100430075703.15dd05bb@fido5>
References: <20100126084740.GA5265@jgarrett.org>
	<87y6jkee1b.fsf@basil.nowhere.org>
	<20100205160900.GA2736@jgarrett.org>
	<alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
	<20100426194002.586fbaa5@fido5>
	<20100427124703.GA16706@jgarrett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100427124703.GA16706@jgarrett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Apr 2010 07:47:03 -0500
jeff@jgarrett.org (Jeff Garrett) wrote:


> My board identifies it as a Dell.  No idea if they rebranded a
> gigabyte.
> 
> The patch seems to work for me as well, powertop shows 97.5% c3,
> turbostat shows 93.6% c6 now.  I do get weird latency spikes (on I/O)
> from time to time.
> 
> When I was investigating, I completely configured USB off, and it
> still wouldn't go into deep sleep.  Not sure how well that meshes
> with your UHCI theory.

Does your board expose UHCI controllers or just EHCI with the rate
matching hubs? When you say 'configured USB off'?, do you mean off
in the BIOS or just no drivers?

--phil
