From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: BUG: blank screen - unless keyboard/synaptic combo
Date: Fri, 22 May 2009 11:39:16 +0800
Message-ID: <1242963556.32574.59.camel@rzhang-dt>
References: <4A12FCB2.6090409@gmail.com>  <4A15DC88.5070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11390 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbZEVDil (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 23:38:41 -0400
In-Reply-To: <4A15DC88.5070005@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

is this a regression or it exists on all the kernel you've tried?
please remote login the box after resume, and get the output of
"xrandr --verbose".

thanks,
rui

On Fri, 2009-05-22 at 06:58 +0800, Niel Lambrechts wrote:
> Cc's added, attached lspci output.
> 
> On 05/19/2009 08:38 PM, Niel Lambrechts wrote:
> > I have a strange problem in that during a resume from hibernate my
> > text console (or X) remains blank - that is, until I simultaneously
> > press a keyboard key and touch the synaptic pad. It is not sufficient
> > to press just one or the other, it needs to be done simultaneously and
> > it resumes fine after doing this.
> 
> I have tried quite hard to overcome this issue. All of the following hibernation 
> tests I tried involved booting into a text console, without ever starting X. 
> With each test I still had a blank screen upon resume, and each time it was 
> fully recoverable by pressing any keyboard key/synaptic pad touch combo.
> 
> 1. Disabling a CPU core - NO CHANGE.
> Based on a "multi-processor concurrency" fix mentioned on the web (Ubuntu bug 
> #272307).
> 
> 2. Upgrade BIOS to latest level - NO CHANGE.
> BIOS 6FET70WW, released 04/17/2009.
> 
> 3. Switching to ATI Mobility Radeon HD 3650 graphics card. NO CHANGE.
> My Lenovo W500 has "switchable graphics" BIOS option, and I tried this test with 
> both the integrated or the above-mentioned card without difference.
> _This result seems quite interesting to me, as if it could be some type of bus 
> related freeze where the keyboard/synaptic combo plays a role._
> 
> 4. Disabling BIOS Options - NO CHANGE.
> Enabling/disabling security chip features + TXT features.
> Disabling fingerprint reader.
> Disabling memory security feature.
> 
> 5. Kernel options - NO CHANGE.
> ACPI debugging - I enabled CONFIG_ACPI_DEBUG, but did not see any messages 
> generated when I pressed a keyboard key + synaptic mousepad combo that recovers 
> the console.
> FIRMWARE_EDID - still testing this.
> 
> Any suggestions on anything else I could try would be most welcome...!
> 
> Thanks,
> Niel
> 

