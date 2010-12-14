From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 0/3_v14] IPMI/ACPI: Install the ACPI IPMI opregion
Date: Tue, 14 Dec 2010 08:11:15 -0600
Message-ID: <4D077B03.5020102@acm.org>
References: <1291774218-6834-1-git-send-email-yakui.zhao@intel.com>
 <alpine.LFD.2.00.1012140020390.23573@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:50920 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0LNOL1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 09:11:27 -0500
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDF001HC8QTFOF0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 14 Dec 2010 08:11:22 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1012140020390.23573@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org

On 12/13/2010 11:21 PM, Len Brown wrote:
> Corey,
> Most of the code is in drivers/acpi, but that depends on the ipmi part.
> Shall I take all three patches in the acpi-test tree?
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>    
I was trying to figure out what to do with these, so yes, I think that 
pulling them into the acpi-test tree is good.  They won't get tested any 
other way, I don't think.

Thanks,

-corey
