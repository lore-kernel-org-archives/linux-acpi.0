From: Dimitri Van Landuyt <dimitri.vanlanduyt@gmail.com>
Subject: MSI S420 (based on MS-141214 barebone)
Date: Fri, 06 Oct 2006 13:24:36 +0200
Message-ID: <eg5edj$m49$1@sea.gmane.org>
Reply-To: dimitri.vanlanduyt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:63377 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750803AbWJFLfd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Oct 2006 07:35:33 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GVnyn-0008OE-Vh
	for linux-acpi@vger.kernel.org; Fri, 06 Oct 2006 13:35:02 +0200
Received: from kulnet-vpn-nat-2.kuleuven.net ([134.58.253.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2006 13:35:01 +0200
Received: from dimitri.vanlanduyt by kulnet-vpn-nat-2.kuleuven.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 06 Oct 2006 13:35:01 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear acpi list,

I bought me a brand new laptop, MSI S420 based on the MS-141214 
barebone): http://www.msicomputer.com/NB/product_spec.asp?model=MS-141214.

Of course, and too bad, not everything is supported in terms of acpi and 
  I am eager to look into this problem. I will enumerate on my issues 
and  observations here, hoping some willing ear would lend a helping hand.

I am running ubuntu edgy beta now which runs the 2.6.17-10 kernel and I 
have seen the same issues in ubuntu dapper which has a 2.6.15 kernel.

1. When booting the machine in a default configuration, it hangs (kernel 
does not respond to any sysrq key combinations) after the following lines:

using HPET for base-timer
using HPET for gettimeofday
Detected 2000.186 MHz processor
Using hpet for high-res timesource.

Playing with some kernel parameters, I notice the following behaviour: 
no effects with pci=noacpi, acpi=force,noapic, nohpet, ...
What does work is: acpi=off but then I have no acpi at all, another 
option I discovered is hpet=disable, which enables some of the acpi 
functionalities.

2. with the hpet=disable parameter, I can see battery state, but 
remainng time is calculated incorrectly (always giving the same amount 
of minutes), plugging in and out the adapter is recognized however. 
Reading temperature does not work as he always gives the constant heat 
of 75 degrees. Cpu frequency scaling does not work.

3. output of dmesg | grep ACPI and dmesg are in attachment.

4. While booting the kernel, but apparently before putting things in the 
kernel log, some messages appear (three), among which something about a 
BIOS bug. They flash away too fast for me to write them down, so a way 
of capturing these is appreciated.

5. Would fixing the DSDT (of which I read some stuff here and there) be 
helpful in my case? Is it dangerous? Is there someone to walk me through it?

6. My BIOS is v1.01 and is definitely the current version as it is a 
very new laptop in general.

Any help is greatly appreciated!

Dimitri Van Landuyt


