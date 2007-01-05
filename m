From: Thomas Renninger <trenn@suse.de>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
	again after booting windows
Date: Fri, 05 Jan 2007 15:18:27 +0100
Message-ID: <1168006707.17171.59.camel@d36.suse.de>
References: <457F37C0.3090003@gmail.com>
	 <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com>
	 <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com>
	 <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com>
	 <20061216043002.GA29560@tangens.sinus.cz> <4583A779.3000902@gmail.com>
	 <20061216081757.GA3571@invalid.invalid>  <458B0027.2000909@gmail.com>
	 <1166740851.5576.5.camel@pcjc2lap>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:45566 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161087AbXAEOS3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 09:18:29 -0500
In-Reply-To: <1166740851.5576.5.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>, linux-acpi@vger.kernel.org

On Thu, 2006-12-21 at 22:40 +0000, Peter Clifton wrote:
> On Thu, 2006-12-21 at 16:44 -0500, Lincoln Baxter, III wrote:
> [snip]
> > Can someone point me to the code that determines the voltage / amperage 
> > pairings for CPUs in power saving mode? Is this handled by the ACPI bios 
> > (bios function call), or does the kernel directly affect the power setting?
> > 
> > I'd like to take a look and see what's going on.
> 
> I can't recall where in the code this is, but it is the bios which
> provides the voltage/frequency pairings. The speed-step drivers for
> older processors actually have them hard-coded as a table.
> 
> If you're not seeing the highest frequency - I don't know what the
> problem is. Mine re-appeared after the rmmod psmouse trick I posted
> earlier. The CPU specs are in a separate SSDT on my laptop, which only
> shows up when the appropriate bios setting for speedstep is ticked, and
> the bios is "happy" (psmouse removed before shutdown).

Can you try patch from comment #180 from bug:
http://bugzilla.kernel.org/show_bug.cgi?id=5534
and also apply this one (didn't find any reference url, so it's copy and
pasted, this one comes from the cpufreq list posted by Bruno Ducrot on
21.Nov.06). Be careful that you get into the "correct" firmware state
before by booting windows (or unplug AC and battery for some minutes
should also help, but not sure). Is this enough to get the machine to
work correctly and stable with ACPI (cpufreq and ACPI info, pls try
without suspend to disk, there are other issues with these machines)?:

processor_perflib.c::acpi_processor_ppc_notifier() check if the value
returned by the processor's _PPC method is 0 and return failed if so.
This is wrong since 0 indicate that the bios think the processor can go
to the highest frequency.  This patch for example fix the HP NX 6125 to
allow its highest frequency to be available.

Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>

--- linux-2.6.19-rc6/drivers/acpi/processor_perflib.c   2006/11/21
10:18:39     1.1
+++ linux-2.6.19-rc6/drivers/acpi/processor_perflib.c   2006/11/21
10:18:55
@@ -83,8 +83,6 @@ static int acpi_processor_ppc_notifier(s
                goto out;
 
        ppc = (unsigned int)pr->performance_platform_limit;
-       if (!ppc)
-               goto out;
 
        if (ppc > pr->performance->state_count)
                goto out;


Thanks,

    Thomas

