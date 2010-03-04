From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 0/4] ipmi: remove SPMI and update core driver with
 dev_printk
Date: Thu, 04 Mar 2010 08:07:11 -0600
Message-ID: <4B8FBE8F.3030203@acm.org>
References: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:60459 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0CDOHT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 09:07:19 -0500
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYR00HEJGK027N5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 04 Mar 2010 08:07:12 -0600 (CST)
In-reply-to: <20100304033146.30205.68689.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Myron Stowe wrote:
> These patches remove the SPMI based IPMI device discovery mechanism and
> update the driver's core to use dev_printk() and its constructs.
>
> As part of this patch series I wanted to remove the 'PFX' argument from
> ipmi_of_probe()'s dev_printk constructs as I believe it produces redundant
> output but I do not have a PPC platform to test against.
>   
I like the dev_printk() stuff.  The order of discovery change is 
correct, too, I believe.  I don't have a PPC platform (with OF, anyway) 
with IPMI, so I can't test that, either.

> Ultimately, I would like to see if it is possible to also remove IPMI's
> SMBIOS based device discovery mechanism.
>   
Maybe in an ideal world, but I don't know where an ideal world is, so I 
have to live in the one I'm in.  There's plenty of systems that only 
document this in SMBIOS tables, there's plenty of systems with broken 
ACPI, etc.  So SMBIOS and SPMI are going to have to stay.


-corey
