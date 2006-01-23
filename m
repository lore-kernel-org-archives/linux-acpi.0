From: Niko Ehrenfeuchter <ehrenfeu@informatik.uni-freiburg.de>
Subject: Re: CPU - Power state (Cx) usage count not working
Date: Mon, 23 Jan 2006 13:33:59 +0100
Message-ID: <1138019639.30619.6.camel@littledragon>
References: <43D491A5.6010000@sbox.tugraz.at>
	 <1138012807.2948.9.camel@spitfire>  <43D4C082.7060908@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:41944 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751351AbWAWMeE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 07:34:04 -0500
Received: from lsfks16.ruf.uni-freiburg.de ([132.230.4.96])
	by atlas.informatik.uni-freiburg.de with esmtpsa (SSLv3:RC4-MD5:128)
	(Exim 4.60)
	(envelope-from <ehrenfeu@informatik.uni-freiburg.de>)
	id 1F10tX-0004O1-AL
	for linux-acpi@vger.kernel.org; Mon, 23 Jan 2006 13:34:03 +0100
In-Reply-To: <43D4C082.7060908@sbox.tugraz.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, 2006-01-23 at 12:39 +0100, Gerfried Maier wrote:
> Hi Niko!
> 
> Thanks for your quick reply.

[...]

> > the counter normally shows the de facto usage, so I assume your system
> > never uses C3 in the above situation. Unloading the usb-modules on a 2.4
> > kernel _might_ help, but it also might not suffice. 
> 
> The above example was not a capture from my system (which i
> unfortunately do not have available by now) but the example given in the
> wiki-entry you referred below.

:)

> On my system all _3 counters_ C1, C2 and C3 always stay at [00000000]
> and not only the C3 counter.

ok, now that's much clearer...  can you revert to the old kernel that
made use of the power states to check if it still works?

as far as i can see, the latest acpi patch for 2.4 is really old
(20040326), so i'd really recommend to try 2.6

regards,
niko

