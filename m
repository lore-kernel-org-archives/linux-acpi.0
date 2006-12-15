From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Fri, 15 Dec 2006 09:38:12 -0500
Message-ID: <4582B354.3080206@gmail.com>
References: <457F37C0.3090003@gmail.com>	 <1165966936.29844.37.camel@pcjc2lap>  <457FB1A1.2030602@gmail.com>	 <1166012707.22903.4.camel@pcjc2lap>  <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:42902 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbWLOOiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Dec 2006 09:38:14 -0500
Received: by wx-out-0506.google.com with SMTP id h27so706160wxd
        for <linux-acpi@vger.kernel.org>; Fri, 15 Dec 2006 06:38:14 -0800 (PST)
In-Reply-To: <1166191807.7459.16.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

Peter Clifton wrote:
> I saw this on my old desktop computer (Nforce2 chipset, AMD XP+2800).
> Not ACPI related perhaps, but definatly CPU load related. When the CPU
> was "thinking", the humming stops. When it was idle, it would humm.
>
> My presumption was that the CPU was bouncing the power rails to the
> sound chip at a given frequency which was coming through. (Sound was on
> the mobo, and I wasn't bothered enough to get the oscilloscope and probe
> it).
>
> It is possible that since ACPI is related to power-saving of your CPU,
> removing ACPI - (and hence the power saving) stops the CPU powering up
> and down / changing clock speed so much, removing the fluctuation on the
> power rails.
>
> All of this is a bit of a guess, but do see if the humming quietens
> under load.
>
> (Try the following C program...)
>
> spinloop.c
>
> int main( int argc, char **argv )
> {
> 	while( 1 );
> }
>
> (Compile with gcc spinloop.c -o spinloop)
>
> Run ./spinloop
>
> Ctrl-C will break out of it.
>
> (Run multiple times for each CPU core you have!)
>
> Peter C.
>   
Yes. I definitely noticed that it's load based, however, here's the kicker.
When I power up the system with the AC adapter plugged in, and then 
proceed to remove the adapter after ACPI has done its initial checks at 
bootup, there is no humming sound.

Also, this hum does not occur unlesss the specific ACPI module, which is 
what I expected... the processor, is loaded into the kernel.

Is there a way to attempt to load this as a module after boot time?

ACPI Support
<y> Processor

Thanks again!

