From: Gerfried Maier <moali@sbox.tugraz.at>
Subject: Re: CPU - Power state (Cx) usage count not working
Date: Wed, 01 Feb 2006 15:44:21 +0100
Message-ID: <43E0C945.7010007@sbox.tugraz.at>
References: <43D491A5.6010000@sbox.tugraz.at>	 <1138012807.2948.9.camel@spitfire>  <43D4C082.7060908@sbox.tugraz.at> <1138019639.30619.6.camel@littledragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:24424 "EHLO
	mailrelay1.tu-graz.ac.at") by vger.kernel.org with ESMTP
	id S1161065AbWBAOo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Feb 2006 09:44:26 -0500
Received: from [129.27.123.23] (emapc23.tu-graz.ac.at [129.27.123.23])
	by mailrelay1.tu-graz.ac.at (8.13.5/8.13.5) with ESMTP id k11EiOW5023914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 1 Feb 2006 15:44:24 +0100 (CET)
In-Reply-To: <1138019639.30619.6.camel@littledragon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Niko Ehrenfeuchter wrote:
> 
>> On my system all _3 counters_ C1, C2 and C3 always stay at [00000000]
>> and not only the C3 counter.
>
> ok, now that's much clearer...  can you revert to the old kernel that
> made use of the power states to check if it still works?

I figured out, that the preemptive-patch from
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/
is responsible for all the couters staying at [00000000]. With this
patch not applied 2.4.31 works as expected. So, this was my fault at
all. Sorry for bothering the list.

> as far as i can see, the latest acpi patch for 2.4 is really old
> (20040326), so i'd really recommend to try 2.6

I'm afraid that I can't use 2.6 because of annoyances with the nvidia
X11-drivers. So I'm stuck to 2.4.

moali

