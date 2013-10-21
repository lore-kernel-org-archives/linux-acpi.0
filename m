From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 8/9] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Mon, 21 Oct 2013 21:52:43 +0530
Message-ID: <526554D3.9050902@linux.vnet.ibm.com>
References: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com> <1382084624-10857-9-git-send-email-gong.chen@linux.intel.com> <52612311.2000303@linux.vnet.ibm.com> <20131019112658.GB16597@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:50272 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3JUQX0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2013 12:23:26 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 22 Oct 2013 02:23:24 +1000
In-Reply-To: <20131019112658.GB16597@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, joe@perches.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On 10/19/2013 04:56 PM, Chen Gong wrote:
> On Fri, Oct 18, 2013 at 05:31:21PM +0530, Naveen N. Rao wrote:
>> Date: Fri, 18 Oct 2013 17:31:21 +0530
>> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>> To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com,
>>   bp@alien8.de, joe@perches.com, m.chehab@samsung.com
>> CC: arozansk@redhat.com, linux-acpi@vger.kernel.org,
>>   linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 8/9] ACPI, APEI, CPER: Cleanup CPER memory error
>>   output format
>> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101
>>   Thunderbird/24.0
>>
> [...]
>>>
>>> @@ -358,17 +349,21 @@ void cper_estatus_print(const char *pfx,
>>>   	struct acpi_generic_data *gdata;
>>>   	unsigned int data_len, gedata_len;
>>>   	int sec_no = 0;
>>> +	char newpfx[64];
>>>   	__u16 severity;
>>>
>>> -	printk("%s""Generic Hardware Error Status\n", pfx);
>>>   	severity = estatus->error_severity;
>>> -	printk("%s""severity: %d, %s\n", pfx, severity,
>>> -	       cper_severity_str(severity));
>>> +	if (severity != CPER_SEV_FATAL)
>>
>> Shouldn't this just be (severity == CPER_SEV_CORRECTED)?
>>
>> Thanks,
>> Naveen
>>
> IMO, only fatal error can't be handlered gracefully in current
> kernel plus H/W. Once it can be recovered by H/W and OS, we
> can call it recovered.
>

Sure, but we don't recover in all scenarios. So, calling it corrected 
seems incorrect to me.



- Naveen

