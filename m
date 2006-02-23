From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: S3 of SATA harddisk under AHCI mode
Date: Wed, 22 Feb 2006 23:02:07 -0800
Message-ID: <20060222230207.5f969da8.rdunlap@xenotime.net>
References: <D3B54144DF35174EB303DB66C35BAA7F01D511F6@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:18379 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750878AbWBWHBD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2006 02:01:03 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 22 Feb 2006 23:01:03 -0800
In-Reply-To: <D3B54144DF35174EB303DB66C35BAA7F01D511F6@bjsmsx402.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jiang, Brendan" <brendan.jiang@intel.com>
Cc: len.brown@intel.com, shaohua.li@intel.com, linux-acpi@vger.kernel.org, intel-linux-acpi@linux.intel.com

On Thu, 23 Feb 2006 14:49:38 +0800 Jiang, Brendan wrote:

> Hi Len/Shaohua,
> 
> I'm working on enable S3 for SATA hard disk under AHCI mode on Napa CRB.

Good.  It needs some help.  :)

> Would you please give me a quick update about current supporting statue
> for this issue?
> 
> Here's my testing configurations:
> HW platform: Napa CRB
> BIOS:        0.60
> SATA config: AHCI enabled, RAID disabled
>              (under IDE mode, S3 works well with vbetool post)

Good to hear that.

> OS: Redflag 5.0
> Kernel: 2.6.14, 2.6.16-rc3
> Observations:
> 1) suspend OK
> 2) on resume
> 	keyboard capital and numlock works.
> 	No video.
> 	No message on serial console.
> 	No LAN.
> 	Type in "find /", hard disk LED has no response.
> 	Type in "reboot", no response.

Yes, that's similar to what I see.  For video, I usually get
flashing green rectangles and serial console contains "garbage"
output (like baud rate etc. are not initialized).

> 3) it seems SATA hard disk lost after resume.
> 
> Also I found a patch developed by Randy Dunlap
> <randy_d_dunlap@linux.intel.com>
> On http://lkml.org/lkml/2006/1/14/15
> (strange, why don't we discuss this first? :-)

Maybe because I didn't know until 5 minutes ago that you are
working on it?  so in what regard are you working on it?
Engineering/development, verification/test, or other?

> I patched it onto 2.6.16-rc3 but didn't help.
> 
> Any comments from anybody will be highly appreciated. Thank you very
> much!
> 
> Best regards,
> Brendan


---
~Randy
