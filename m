From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/9] ACPI, x86: Extended error log driver for x86 platform
Date: Mon, 21 Oct 2013 21:57:11 +0530
Message-ID: <526555DF.4010809@linux.vnet.ibm.com>
References: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com> <1382084624-10857-5-git-send-email-gong.chen@linux.intel.com> <52612BA4.2060906@linux.vnet.ibm.com> <20131020070615.GA30565@gchen.bj.intel.com> <20131020082148.GA3994@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:46852 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3JUQ1m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2013 12:27:42 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 22 Oct 2013 02:27:40 +1000
In-Reply-To: <20131020082148.GA3994@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, joe@perches.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/20/2013 01:51 PM, Borislav Petkov wrote:
> On Sun, Oct 20, 2013 at 03:06:15AM -0400, Chen Gong wrote:
>> Oh, yes it is. Furthermore, it reminds me where is the best place
>> to put cper.c from I write this patch series. CPER really doesn't
>> dpend on APEI even ACPI. Maybe lib/ ia an option. I can update this
>> patch and if it is OK, I can add another separate patch to change this
>> dependency. Make sense?
>
> Yeah, for some reason it is part of the UEFI spec but APEI uses it too.
>
> Well, I guess you can add it there as "default n" and have the rest of
> the code select it in Kconfig.

Yup, I think that would be a good idea to just separate out the CPER 
stuff from the APEI code, though I think your enhanced MCA logging code 
will need to depend on both CPER and ACPI since you use the ACPI 
structures as well.


Thanks,
Naveen

