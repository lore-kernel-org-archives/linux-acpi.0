From: Ron Rechenmacher <ron@fnal.gov>
Subject: Re: suspend/resume memory corruption on Dell Latitude D830
Date: Wed, 16 Apr 2008 10:16:06 -0500
Message-ID: <48061836.2050705@fnal.gov>
References: <4803DD86.9060105@fnal.gov> <4804269C.4050507@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgw2.fnal.gov ([131.225.111.12]:45142 "EHLO mailgw2.fnal.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757652AbYDPPVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 11:21:13 -0400
Received: from mailav2.fnal.gov (mailav2.fnal.gov [131.225.111.20])
 by mailgw2.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with SMTP id <0JZF003HDBD18T@mailgw2.fnal.gov> for linux-acpi@vger.kernel.org;
 Wed, 16 Apr 2008 10:15:55 -0500 (CDT)
Received: from mailgw1.fnal.gov ([131.225.111.11])
 by mailav2.fnal.gov (SAVSMTP 3.1.7.47) with SMTP id M2008041610155417046 for
 <linux-acpi@vger.kernel.org>; Wed, 16 Apr 2008 10:15:54 -0500
Received: from conversion-daemon.mailgw1.fnal.gov by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 id <0JZF00C01BMKFF@mailgw1.fnal.gov> (original mail from ron@fnal.gov)
 for linux-acpi@vger.kernel.org; Wed, 16 Apr 2008 10:15:55 -0500 (CDT)
Received: from [131.225.94.222] (d-r19381.dhcp.fnal.gov [131.225.94.222])
 by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with ESMTPSA id <0JZF00M78BQI92@mailgw1.fnal.gov> for
 linux-acpi@vger.kernel.org; Wed, 16 Apr 2008 10:15:54 -0500 (CDT)
In-reply-to: <4804269C.4050507@fnal.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ron Rechenmacher <ron@fnal.gov>

I've made a significant partial/temporary fix.
I was able to use the memmap= kernel cmdline options to apparently keep 
the kernel from using the memory that the suspend/resume process is 
erroneously writing to:
  kernel /vmlinuz-2.6.24.3-trc ro root=LABEL=/3 memmap=exactmap 
memmap=636K@0 memmap=4K$636K memmap=3046M@1M memmap=1682K$3668334K 
memmap=64M$3094M memmap=64K$4076M memmap=16K$4174944K 
memmap=448K$4174976K memmap=24K$4175488K memmap=64K$4078M 
memmap=2M$4094M memmap=511M@4097M x12345678

This results in the following output from the kernel:
...
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000dfe5b800 (usable)
  BIOS-e820: 00000000dfe5b800 - 00000000e0000000 (reserved)
  BIOS-e820: 00000000f4000000 - 00000000f8000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fed18000 - 00000000fed1c000 (reserved)
  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
  BIOS-e820: 00000000feda0000 - 00000000feda6000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100002000 - 0000000120000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 917083) 1 entries of 256 used
Entering add_active_range(0, 1048578, 1179648) 2 entries of 256 used
end_pfn_map = 1179648
user-defined physical RAM map:
  user: 0000000000000000 - 000000000009f000 (usable)
  user: 000000000009f000 - 00000000000a0000 (reserved)
  user: 0000000000100000 - 00000000be700000 (usable)
  user: 00000000dfe5b800 - 00000000e0000000 (reserved)
  user: 00000000c1600000 - 00000000c5600000 (reserved)
  user: 00000000fec00000 - 00000000fec10000 (reserved)
  user: 00000000fed18000 - 00000000fed1c000 (reserved)
  user: 00000000fed20000 - 00000000fed90000 (reserved)
  user: 00000000feda0000 - 00000000feda6000 (reserved)
  user: 00000000fee00000 - 00000000fee10000 (reserved)
  user: 00000000ffe00000 - 0000000100000000 (reserved)
  user: 0000000100100000 - 0000000120000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 780032) 1 entries of 256 used
Entering add_active_range(0, 1048832, 1179648) 2 entries of 256 used
end_pfn_map = 1179648
...

With this, I loose near 500MB but my tests pass -- I do not see any 
memory corruption after the resume. I could get a lot of the 500MB back 
if I did not max out the kernel cmdline.
Apparently the problem area is just after be700000.

My 8 month battle seems to have turned into a linux/linux-acpi success 
story. Thanks for the kernel cmdline options. I wonder if Vista could do 
this?

Thanks,
Ron

Ron Rechenmacher wrote:
> More information on is at
>     http://fnapcf.fnal.gov/~ron/dell_susp_3.5G_2blocks.txt
> and http://fnapcf.fnal.gov/~ron/dell_susp_3.5G_2blocks.dmesg.txt
> 
> Is there a way to determine which acpi mapping/allocation is not being 
> honored or is missing and/or using some memmap= kernel param
> to get the kernel to stay away from the memory being changed during 
> suspend/resume? (any other kernel param that might be useful?)
> 
> Thanks,
> Ron
> 
