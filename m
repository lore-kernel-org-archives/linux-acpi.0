From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Missing ACPI documentation
Date: Mon, 4 Jul 2011 10:11:35 -0700
Message-ID: <20110704101135.967f73d6.rdunlap@xenotime.net>
References: <20110704175208.15a11789@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:35431 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758049Ab1GDRLi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2011 13:11:38 -0400
In-Reply-To: <20110704175208.15a11789@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org

On Mon, 4 Jul 2011 17:52:08 +0100 Alan Cox wrote:

> Documentation/kernel-parametes.txt
> 
> Says for acpi=
> 
> 			See also Documentation/power/pm.txt, pci=noacpi
> 
> but this file does not exist

maybe Documentation/pm/basic-pm-debugging.txt:

"""
It is also possible that the "devices" test will still fail after you have
unloaded all modules. In that case, you may want to look in your kernel
configuration for the drivers that can be compiled as modules (and test again
with these drivers compiled as modules).  You may also try to use some special
kernel command line options such as "noapic", "noacpi" or even "acpi=off".
"""

although that "noacpi" above should be "pci=noacpi" IMO.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
