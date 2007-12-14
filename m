From: Len Brown <lenb@kernel.org>
Subject: Re: Help please
Date: Fri, 14 Dec 2007 14:28:20 -0500
Message-ID: <200712141428.20723.lenb@kernel.org>
References: <47629334.50201@thecybersource.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51895 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762631AbXLNT2u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Dec 2007 14:28:50 -0500
In-Reply-To: <47629334.50201@thecybersource.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cyber Source <peter@thecybersource.com>
Cc: linux-acpi@vger.kernel.org

On Friday 14 December 2007 09:29, Cyber Source wrote:
> Hello,
>   To simplify my question, I'm going to include an excerpt from a post 
> to our lug here. Would you possible have a work around for this problem? TIA
> 
> <snip>
> Ok, gotta throw one out for some help.
>  Long story short is, I have a laptop that I just purchased for a
> client, has nvidia and runs perfect with Ubuntu Gutsy except for 1
> little (kinda huge) problem.
>  The bios that ships with most laptops lately , COMPLETELY SUCK  (I
> hate phoenix). There is absolutely NOTHING in the bios to help control
> acpi or apic. My problem is that I have NO SOUND unless I boot with the
> kernel boot option of "acpi=off", then all works perfect except I have
> no battery monitoring, which on a laptop is pretty huge, if this was a
> desktop, it would be no biggie (not sure if it would affect ups
> monitoring). I notice that I have ERR=1 from /proc/interrupts. I have
> tried all sorts of combinations of boot options, including "noapic
> nolapic pnpbios=off" and I forget the rest I've tried, nothing works
> except for turning off acpi completely and then no battery monitor. I've
> looked into apm but can't recompile the kernel because then all the
> other "restricted" packages won't work with the custom kernel and that
> option is basically a pain in the ass. I feel this is probably related
> to the ERR=1 from interrupts but I can't seem to clear this, it only
> gets worse with other boot options I've tried.
> Does anyone know how to reroute irq's or make them behave better (yes
> I've tried pci=routeirq)?
> Has anyone else had this problem and found a solution?
> Currently my work around is 2 grub boot stanza's, one is to have sound
> which runs "acpi=off" and the other is to have no sound and everything
> else works (battery monitor), without the "acpi=off" option.
> Any help please? TIA
> <snip>

Please file a sighting here:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Category: config-interrupts

Please note if this has always not worked, or if a previous version of Linux worked.

Please attach the dmesg and /proc/interrupt from the acpi=off boot;
and the same for the boot with no boot parameters.

Please attach a single copy of the output from acpidump,
and the output from lspci -vv.

thanks,
-Len
