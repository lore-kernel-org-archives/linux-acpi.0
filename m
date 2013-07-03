From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4] mce: acpi/apei: Add a sysctl to control page offlining
 on firmware report
Date: Wed, 03 Jul 2013 21:16:26 +0530
Message-ID: <51D44752.3000303@linux.vnet.ibm.com>
References: <20130701153728.6197.14022.stgit@localhost.localdomain> <20130702125137.7388.97225.stgit@localhost.localdomain> <20130703144641.GC13951@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:33818 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab3GCPqq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2013 11:46:46 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Wed, 3 Jul 2013 21:10:14 +0530
In-Reply-To: <20130703144641.GC13951@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 07/03/2013 08:16 PM, Borislav Petkov wrote:
> On Tue, Jul 02, 2013 at 06:24:00PM +0530, Naveen N. Rao wrote:
>> I am adding another patch here to disable page offlining in case the firmware
>> starts acting up.
>>
>> Thanks,
>> Naveen
>>
>> --
>>
>> Add a sysctl memory_failure_soft_offline to control what is done on receipt of
>> firmware ghes notification for a corrected error. By default, kernel tries
>> to soft-offline the page immediately. If set to 0, no action is taken.
>
> What is the rationale for that? Are we adding it just in case, as a
> chicken bit or do you have a specific case?
>
> If the second, we'd love to hear about it in the commit message. :)

Nope, this is a just-in-case thing. I think you or Tony asked to have 
this in a previous discussion so that we're covered if firmware starts 
acting up. Other than that, I'm ok if this is left out.


Thanks,
Naveen

