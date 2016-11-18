From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm: vtpm_proxy: Do not access host's event log
Date: Fri, 18 Nov 2016 09:11:40 -0500
Message-ID: <abef96f0-97e3-22e6-c63b-4be5622b4fc2@linux.vnet.ibm.com>
References: <1479306245-14456-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <20161116153731.pmmnxiai7ouuj6qf@intel.com>
 <3a38ddc6-1758-ae82-3df3-9cc55906880d@linux.vnet.ibm.com>
 <65f392b6-5141-c726-dacb-a1649ea215de@linux.vnet.ibm.com>
 <20161116200759.GA19593@obsidianresearch.com>
 <ef1f954d-fc52-0522-01f7-b0e31ea14c59@linux.vnet.ibm.com>
 <20161117203743.odzdpwwynzlqyt5m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753483AbcKROLr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Nov 2016 09:11:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAIDwvDV035902
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2016 09:11:46 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26t2tuh670-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2016 09:11:46 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 18 Nov 2016 07:11:45 -0700
In-Reply-To: <20161117203743.odzdpwwynzlqyt5m@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, tpmdd-devel@lists.sourceforge.net, nayna@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org

On 11/17/2016 03:37 PM, Jarkko Sakkinen wrote:
> On Thu, Nov 17, 2016 at 07:35:05AM -0500, Stefan Berger wrote:
>> On 11/16/2016 03:07 PM, Jason Gunthorpe wrote:
>>> On Wed, Nov 16, 2016 at 12:07:23PM -0500, Stefan Berger wrote:
>>>> The culprit seems to be 'tpm: fix the missing .owner in
>>>> tpm_bios_measurements_ops'
>>> That is unlikely, it is probably the patch before which calls read_log
>>> unconditionally now. That suggests the crashing is a little random..
>> I ran the vtpm driver test suite (with -j32) a few times at that patch and
>> it didn't crash. It crashes severely with later patches applied. Here's the
>> current experimental patch that fixes these problems:
>>
>> iff --git a/drivers/char/tpm/tpm_acpi.c b/drivers/char/tpm/tpm_acpi.c
>> index 0cb43ef..a73295a 100644
>> --- a/drivers/char/tpm/tpm_acpi.c
>> +++ b/drivers/char/tpm/tpm_acpi.c
>> @@ -56,6 +56,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>>
>>       log = &chip->log;
>>
>> +    if (!chip->acpi_dev_handle)
>> +        return 0;
>> +
> If there is a problem in the TPM driver, this does not fix the
> problem. It will mask the problem. Maybe there's an ACPI regression
> in the rc tree?

Following the path from here :

http://lxr.free-electrons.com/source/drivers/acpi/acpica/tbxface.c#L282

acpi_get_table_with_size -> acpi_tb_validate_table -> acpi_tb_acquire_table

I see acpi_os_map_memory being called in acpi_tb_acquire_table but not 
the corresponding acpi_os_unmap_memory...

     Stefan


>
> This is a funky situation because those lines need to be there but
> I do not want them before it is root caused that it is not a TPM
> bug.
>
> /Jarkko
>

