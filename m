From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
	again after booting windows
Date: Fri, 15 Dec 2006 14:10:07 +0000
Message-ID: <1166191807.7459.16.camel@pcjc2lap>
References: <457F37C0.3090003@gmail.com>
	 <1165966936.29844.37.camel@pcjc2lap>  <457FB1A1.2030602@gmail.com>
	 <1166012707.22903.4.camel@pcjc2lap>  <4582A607.8040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:46791 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbWLOOKs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Dec 2006 09:10:48 -0500
In-Reply-To: <4582A607.8040302@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 2006-12-15 at 08:41 -0500, Lincoln Baxter, III wrote:
> [snip]

> When I boot the computer with ACPI support, there's an audible hum that 
> comes from the CPU whenever the processor is idle.
> This hum does not occur in windows, and when I boot with "noapic 
> pci=noapic acpi=off" in the kernel options, the sound is gone.
> 
> Does anyone have any ideas how I can fix this? Is it possible to load 
> ACPI as a module? Should I play around with which ACPI features are 
> compiled in, and see which one, if it is just one, is the kicker?

I saw this on my old desktop computer (Nforce2 chipset, AMD XP+2800).
Not ACPI related perhaps, but definatly CPU load related. When the CPU
was "thinking", the humming stops. When it was idle, it would humm.

My presumption was that the CPU was bouncing the power rails to the
sound chip at a given frequency which was coming through. (Sound was on
the mobo, and I wasn't bothered enough to get the oscilloscope and probe
it).

It is possible that since ACPI is related to power-saving of your CPU,
removing ACPI - (and hence the power saving) stops the CPU powering up
and down / changing clock speed so much, removing the fluctuation on the
power rails.

All of this is a bit of a guess, but do see if the humming quietens
under load.

(Try the following C program...)

spinloop.c

int main( int argc, char **argv )
{
	while( 1 );
}

(Compile with gcc spinloop.c -o spinloop)

Run ./spinloop

Ctrl-C will break out of it.

(Run multiple times for each CPU core you have!)

Peter C.

