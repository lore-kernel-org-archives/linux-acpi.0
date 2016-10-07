From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [tip:x86/apic] x86/acpi: Introduce persistent storage for cpuid
 <-> apicid mapping
Date: Fri, 7 Oct 2016 12:35:36 +0800
Message-ID: <e53a9807-2beb-0878-87dc-cc6f93b7c911@cn.fujitsu.com>
References: <1472114120-3281-4-git-send-email-douly.fnst@cn.fujitsu.com>
 <tip-8f54969dc8d6704632b42cbb5e47730cd75cc713@git.kernel.org>
 <CAE9FiQVQx6FRXT-RdR7Crz4dg5LeUWHcUSy1KacjR+JgU_vGJg@mail.gmail.com>
 <alpine.DEB.2.20.1610041258410.7712@nanos>
 <CAE9FiQWigWvrZ8JzNDKtZ9FWARh2m0kGoF+VOZdwAdY9vnU3_w@mail.gmail.com>
 <4608f474-c49e-550b-90e2-c5f4c25e00f5@cn.fujitsu.com>
 <CAE9FiQVEvoK=TvYyhU6iiLh5FiX3pXXyy53tr2F7BEnRxGk7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:64847 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750974AbcJGEgL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 00:36:11 -0400
In-Reply-To: <CAE9FiQVEvoK=TvYyhU6iiLh5FiX3pXXyy53tr2F7BEnRxGk7HA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, robert.moore@intel.com, linux-acpi@vger.kernel.org

Hi Yinghai

At 10/07/2016 05:20 AM, Yinghai Lu wrote:
> On Thu, Oct 6, 2016 at 1:06 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> I seem to remember that in x2APIC Spec the x2APIC ID may be at 255 or
>> greater.
>
> Good to know. Maybe later when one package have more cores like 30 cores etc.
>
>> If we do that judgment, it may be affect x2APIC's work in some other places.
>>
>> I saw the MADT, the main reason may be that we define 0xff to acpi_id
>> in LAPIC mode.
>> As you said, it was like:
>> [   42.107902] ACPI: LAPIC (acpi_id[0xff] lapic_id[0xff] disabled)
>> [   42.120125] ACPI: LAPIC (acpi_id[0xff] lapic_id[0xff] disabled)
>> [   42.132361] ACPI: LAPIC (acpi_id[0xff] lapic_id[0xff] disabled)
>> ...
>>
>> How about doing the acpi_id check when we parse it in
>> acpi_parse_lapic().
>>
>> 8<----------------
>>
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -233,6 +233,11 @@ acpi_parse_lapic(struct acpi_subtable_header * header,
>> const unsigned long end)
>>
>>         acpi_table_print_madt_entry(header);
>>
>> +       if (processor->id >= 255) {
>> +               ++disabled_cpus;
>> +               return -EINVAL;
>> +       }
>> +
>>         /*
>>          * We need to register disabled CPU as well to permit
>>          * counting disabled CPUs. This allows us to size
>
> Yes, that should work. but should do the same thing for x2apic
>
> in acpi_parse_x2apic should have
>
>> +       if (processor->local_apic_id == -1) {
>> +               ++disabled_cpus;
>> +               return -EINVAL;
>> +       }
>
> that is the reason why i want to extend acpi_register_lapic()
> to take extra disabled_id (one is 0xff and another is 0xffffffff)
> so could save some lines.
>

Yes, I understood.
But I think adding an extra disabled_id is not a good way for
validating the apic_id. If the disabled_id is not just one id(-1 or
255), may be two or more, even be a range. what should we do for
extending our code?

Firstly, I am not sure that the "-1" could appear in the MADT, even if
the ACPI tables is unreasonable.

Seondly, I guess if we need the check, there are some reserved methods
in the kernel, such as "default_apic_id_valid", "x2apic_apic_id_valid"
and so on. we should extend all of them and use them for check.


CC'ed: Rafael and Lv

May I ask a question?

Is it possible that the "-1/oxffffffff" could appear in the MADT which 
is one of the ACPI tables?


> Thanks
>
> Yinghai
>
>


