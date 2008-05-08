From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.25 pci=noacpi
Date: Thu, 08 May 2008 13:50:39 +0200
Message-ID: <4822E90F.4080303@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183934.516655076@ldl.fc.hp.com> <4813B5AB.4060308@keyaccess.nl> <200804281507.38309.bjorn.helgaas@hp.com> <4816C605.4000601@gmail.com> <481E0D2D.1030608@keyaccess.nl> <4822A706.1040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:60172 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYEHLtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 07:49:32 -0400
In-Reply-To: <4822A706.1040700@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 08-05-08 09:08, Richard wrote:

> Rene Herman wrote:
>> On 29-04-08 08:53, Richard wrote:
>>
>>> Using an AMD Sempron notebook (HP Compaq 6715b) single processor 
>>> machine,  It shuts down during bootup when ACPI is fully enabled.  I 
>>> added pci=noacpi to the cmdline and it finally boots, but its 
>>> extremely slow...  (kdm times out with error saying it took too long 
>>> to load and disables graphical)
>>
>> Does booting with io_delay=0xed on the kernel command line fix it? If 
>> so, we need the output of

> Tried the io_delay=0xed.... doesnt fix it. machine shuts down :-P

Blast. Sounded somewhat plausible given the original trouble with that
io_delay thing. Don't know then, sorry.

Rene.


