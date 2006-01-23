From: Gerfried Maier <moali@sbox.tugraz.at>
Subject: Re: CPU - Power state (Cx) usage count not working
Date: Mon, 23 Jan 2006 12:39:46 +0100
Message-ID: <43D4C082.7060908@sbox.tugraz.at>
References: <43D491A5.6010000@sbox.tugraz.at> <1138012807.2948.9.camel@spitfire>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:902 "EHLO
	mailrelay2.tu-graz.ac.at") by vger.kernel.org with ESMTP
	id S1751094AbWAWLju (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 06:39:50 -0500
Received: from [129.27.123.23] (emapc23.tu-graz.ac.at [129.27.123.23])
	by mailrelay2.tu-graz.ac.at (8.13.5/8.13.5) with ESMTP id k0NBdlth002571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 12:39:48 +0100 (CET)
In-Reply-To: <1138012807.2948.9.camel@spitfire>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Niko!

Thanks for your quick reply.

Niko Ehrenfeuchter wrote:
> [...]
>>active state:            C2
>>default state:           C1
>>bus master activity:     00004f00
>>states:
>>    C1:                  promotion[C2] demotion[--] latency[000]
>>usage[00033670]
>>   *C2:                  promotion[C3] demotion[C1] latency[084]
>>usage[00357060]
>>    C3:                  promotion[--] demotion[C2] latency[120]
>>usage[00000000]
>> [...]


> the counter normally shows the de facto usage, so I assume your system
> never uses C3 in the above situation. Unloading the usb-modules on a 2.4
> kernel _might_ help, but it also might not suffice. 

The above example was not a capture from my system (which i
unfortunately do not have available by now) but the example given in the
wiki-entry you referred below.

On my system all _3 counters_ C1, C2 and C3 always stay at [00000000]
and not only the C3 counter.

Having read my original posting again, I'm afraid that this ambiguity
was caused by me with my unclear formulation of the OP. Sorry for this.

> [...]
> 
> http://acpi.sourceforge.net/wiki/index.php/WhyMyCxPowerStateIsNotUsed

moali
