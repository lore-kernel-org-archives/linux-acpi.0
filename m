From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH]: x86: use acpi flags for apic mapping
Date: Thu, 03 Jun 2010 13:59:58 -0700
Message-ID: <4C0817CE.6050006@oracle.com>
References: <20100602192418.2706.35192.sendpatchset@prarit.bos.redhat.com> <20100602194956.GB5264@lenovo> <4C06D91F.2060105@redhat.com> <20100603172126.GA5502@lenovo> <4C07EF69.6050301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C07EF69.6050301@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mjg@redhat.com, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 06/03/2010 11:07 AM, Prarit Bhargava wrote:
> 
> 
> On 06/03/2010 01:21 PM, Cyrill Gorcunov wrote:
>> On Wed, Jun 02, 2010 at 06:20:15PM -0400, Prarit Bhargava wrote:
>>   
>>>     
>>>>> +#ifdef CONFIG_ACPI
>>>>> +enum apic_acpi_map_status apic_is_acpi_clustered_box(void)
>>>>> +{
>>>>>         
>>>> It's a bit strange that function is "is" prefixed and returns not true or false
>>>> but enum, perhaps we may name it apic_acpi_dst_model() or something like
>>>> that?
>>>>
>>>>       
>>> Sure, np -- new patch.
>>>
>>> P.
>>>     
>> Hi Prarit,
>>
>> just have reviewed it again and got some questions:
>>
>>   
>>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
>>> index 1fa03e0..6b63f95 100644
>>> --- a/arch/x86/include/asm/apic.h
>>> +++ b/arch/x86/include/asm/apic.h
>>> @@ -252,6 +252,14 @@ static inline int apic_is_clustered_box(void)
>>>  }
>>>  #endif
>>>  
>>> +enum apic_acpi_map_status {
>>> +	APIC_ACPI_BOTH,
>>> +	APIC_ACPI_CLUSTER,
>>> +	APIC_ACPI_PHYSICAL,
>>> +	APIC_ACPI_NONE
>>> +};
>>> +extern enum apic_acpi_map_status apic_acpi_dst_model(void);
>>> +
>>>  extern u8 setup_APIC_eilvt_mce(u8 vector, u8 msg_type, u8 mask);
>>>  extern u8 setup_APIC_eilvt_ibs(u8 vector, u8 msg_type, u8 mask);
>>>  
>>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>>> index e5a4a1e..e94a189 100644
>>> --- a/arch/x86/kernel/apic/apic.c
>>> +++ b/arch/x86/kernel/apic/apic.c
>>> @@ -2189,6 +2189,30 @@ static const __cpuinitconst struct dmi_system_id multi_dmi_table[] = {
>>>  	{}
>>>  };
>>>  
>>> +#ifdef CONFIG_ACPI
>>> +enum apic_acpi_map_status apic_acpi_dst_model(void)
>>> +{
>>> +	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID) {
>>> +		if (acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL &&
>>> +		    acpi_gbl_FADT.flags & ACPI_FADT_APIC_CLUSTER) {
>>> +			/*
>>> +			 * The rest of the code assumes physical flat
>>> +			 * in this case.
>>> +			 */
>>> +			return APIC_ACPI_BOTH;
>>> +		}
>>>     
>> Havin both flags set in ACPI FADT make me worry -- I suspect this means
>> acpi is screwed (this is ok, who doubt :) but the problem is HOW should
>> we treat TSC instability in such case? The current code assumes (tsc.c)
>>   
> 
> In the case of BOTH the code will assume physical_flat everywhere --
> therefore tsc is is stable.   Since the number of cluster systems is low
> it is unlikely that BOTH & cluster actually occur.   I suppose I could
> add (yet another) boot parameter to force cluster/flat/phys_flat if one
> doesn't already exist.... but I think that the likelihood of anyone
> hitting BOTH & wanting cluster is 0.
> 
>> that cluster mode has TSC unstable and if we had both bits set which
>> tsc mode we should choose? I suspect we have to assume that TSC unstable
>> then.

It seems we don't need this patch.

so all system should support phys apic mode, but system with less 8 cpus is supposed to support cluster mode for better performance.

current kernel will try to use cluster mode if nr_cpus is less than 8.

some system have problem like IBM and NCR only support phys apic mode even cpus < 8 ...

Thanks

Yinghai
