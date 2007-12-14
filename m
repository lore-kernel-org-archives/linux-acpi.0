From: Cyber Source <peter@thecybersource.com>
Subject: Help please
Date: Fri, 14 Dec 2007 09:29:08 -0500
Message-ID: <47629334.50201@thecybersource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.thecybersource.com ([64.65.249.35]:57187 "EHLO
	ns1.thecybersource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbXLNOmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Dec 2007 09:42:00 -0500
Received: from [192.168.1.7] ([192.168.1.254])
	(authenticated bits=0)
	by ns1.thecybersource.com (8.13.1/8.13.1) with ESMTP id lBEET8BP029638
	for <linux-acpi@vger.kernel.org>; Fri, 14 Dec 2007 09:29:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
  To simplify my question, I'm going to include an excerpt from a post 
to our lug here. Would you possible have a work around for this problem? TIA

<snip>
Ok, gotta throw one out for some help.
 Long story short is, I have a laptop that I just purchased for a
client, has nvidia and runs perfect with Ubuntu Gutsy except for 1
little (kinda huge) problem.
 The bios that ships with most laptops lately , COMPLETELY SUCK  (I
hate phoenix). There is absolutely NOTHING in the bios to help control
acpi or apic. My problem is that I have NO SOUND unless I boot with the
kernel boot option of "acpi=off", then all works perfect except I have
no battery monitoring, which on a laptop is pretty huge, if this was a
desktop, it would be no biggie (not sure if it would affect ups
monitoring). I notice that I have ERR=1 from /proc/interrupts. I have
tried all sorts of combinations of boot options, including "noapic
nolapic pnpbios=off" and I forget the rest I've tried, nothing works
except for turning off acpi completely and then no battery monitor. I've
looked into apm but can't recompile the kernel because then all the
other "restricted" packages won't work with the custom kernel and that
option is basically a pain in the ass. I feel this is probably related
to the ERR=1 from interrupts but I can't seem to clear this, it only
gets worse with other boot options I've tried.
Does anyone know how to reroute irq's or make them behave better (yes
I've tried pci=routeirq)?
Has anyone else had this problem and found a solution?
Currently my work around is 2 grub boot stanza's, one is to have sound
which runs "acpi=off" and the other is to have no sound and everything
else works (battery monitor), without the "acpi=off" option.
Any help please? TIA
<snip>
