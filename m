From: Frank Ursel <listadress@gmx.net>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works again after booting windows
Date: Sat, 16 Dec 2006 09:17:57 +0100
Message-ID: <20061216081757.GA3571@invalid.invalid>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com> <20061216043002.GA29560@tangens.sinus.cz> <4583A779.3000902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030748AbWLPISC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 03:18:02 -0500
Content-Disposition: inline
In-Reply-To: <4583A779.3000902@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Sat, Dec 16, 2006 at 02:59:53AM -0500, Lincoln Baxter, III wrote:
> Pavel Troller wrote:
> >Hi!
> >  
> >Try the following:
> >  cat /proc/acpi/processor/*/power in the following situations:
> >  1) After loading the processor module being on the battery,
> >  2) After loading the processor module being on AC,
> >  3) After disconnecting the AC,
> >and compare the results. I think that for 1), you will see more C-states 
> >than
> >for 2) and that possibly the missing C-states are not added for 3).
> >  
> And the reason the hum seems to go away when AC is plugged back in, is 
> because it switches to C2.
> 
> I have this question, however. While the CPU is powered down, 
> /proc/cpuinfo still shows the full frequency of the chip, at 1823Mhz. 
> When I enable cpufrequtils, and clock down the processor, there is no 
> change in noise or power consumption, it's still noisy, and it's still . 
> If this is the case, then why bother with cpufrequtils in the first 
> place... also... I still have the question of why doesn't this happen in 
> windows? What power state is windows running in to get as much or more 
> battery life, and still have no humming noise?
> 
> It seems like the processor module must be doing something that isn't 
> quite right. I heard that there's supposed to be a C0, and a C4 power 
> state for the core duo processor, but I don't see those in the list of 
> options. Any ideas as to why they don't show up?

As far as i know, the humming appears in windows too. I tested it with
the RMClock utility and on my laptop, switching to C4 was making the
humming. But every other C-State was quite. You should tune the timing
frquencies, like Pavel pointed out.

But i'm curios, why on linux the C4-State does not show up. The maximum
working C-State on my system, on AC or battery is C3. Is there any
hidden switch to enable it?

with regards, frank

