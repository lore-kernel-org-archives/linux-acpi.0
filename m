From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ACPI processor: Fix a typo error in commit 99b725084
Date: Fri, 03 Aug 2012 11:43:50 +0530
Message-ID: <501B6C1E.3060503@linux.vnet.ibm.com>
References: <1343709883-16801-1-git-send-email-feng.tang@intel.com> <501B51F1.7090503@kernel.org>	<501B67F4.3030308@linux.vnet.ibm.com> <20120803140343.0f15eebd@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:43732 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2HCGOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Aug 2012 02:14:08 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 3 Aug 2012 16:13:44 +1000
In-Reply-To: <20120803140343.0f15eebd@feng-i7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Thomas Renninger <trenn@suse.de>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, stable@vger.kernel.org

On 08/03/2012 11:33 AM, Feng Tang wrote:
> On Fri, 3 Aug 2012 11:26:04 +0530
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> 
>> On 08/03/2012 09:52 AM, Len Brown wrote:
>>> Applied.
>>>
>>> thanks for the refresh.
>>>
>>
>> This patch needs to be CC'ed to stable also right?
> 
> Yes, I've sent the patch directly to stable 3 days ago. thanks
> for the note.
> 

Hmm? Patches are not accepted into the stable tree until the patch
goes upstream, IIUC. And to make a patch automatically go to -stable
once it hits mainline, you need to add Cc: stable@vger.kernel.org
among the Signed-off-by sequence in the patch.

Otherwise, we can explicitly mail the patch to stable, -after- the
corresponding patch hits mainline.. In fact, we will also have to quote
the mainline commit id in that.

See Documentation/stable_kernel_rules.txt for details.

Regards,
Srivatsa S. Bhat

