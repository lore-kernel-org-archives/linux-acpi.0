From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH3/4] ACPI :  Add boot option of "idle=nomwait" to disable
 mwait for CPU C-states
Date: Thu, 26 Jun 2008 00:06:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806260003590.3279@localhost.localdomain>
References: <1213685035.19901.15.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.1.10.0806200235260.22284@localhost.localdomain>
 <alpine.LFD.1.10.0806200310160.22284@localhost.localdomain>
 <1214202030.25786.77.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:57351 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYFZEGY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 00:06:24 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K31006RUY2A2ZM3@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Jun 2008 23:06:11 -0500 (CDT)
In-reply-to: <1214202030.25786.77.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org



On Mon, 23 Jun 2008, Zhao Yakui wrote:

> On Fri, 2008-06-20 at 03:14 -0400, Len Brown wrote:
> > 
> > I notice on the T61 that this disables MWAIT for C2 and C3,
> > but not for C1.
> > 
> > While I know that the issue at hand is C2 and C3,
> > it seems misleading to boot with idle=nomwait
> > and see that MWAIT is used for C1.

> What you said is correct. The description is not appropriate.Maybe the
> following title will be appropriate.

>  >Add boot option of "idle=nomwait" to disable mwait for CPU C2/C3
> 
> The boot option of "idle=nomwait" will disable mwait for CPU C2/C3 and
> still use mwait for C1 if mwait is supported. 
> In fact we only hope to disable mwait for CPU C2/C3 on some broken
> system by adding this boot option.

How can I tell the system with 3 C-states to use all 3,
but not to use MWAIT for any of them?

idle=halt will not do, since it will delete C2 and C3 completely.
As I said, I think that "idle=nomwait" should do this.
If we have a parameter that disables MWAIT only for C2 and C3,
then it should not be called "idle=nomwait".

-Len


