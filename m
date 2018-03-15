From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH] ACPI / processor: Get accurate possible CPU count
Date: Thu, 15 Mar 2018 11:00:39 +0800
Message-ID: <95c1590a-1645-ce0e-dea3-d8927bc97704@cn.fujitsu.com>
References: <20180314102847.30459-1-douly.fnst@cn.fujitsu.com>
 <CAHp75VfGPgbD8gBdvchBn5U8gH93zoHB9ja3KucUuxVNq+_MLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfGPgbD8gBdvchBn5U8gH93zoHB9ja3KucUuxVNq+_MLg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, ming.lei@redhat.com
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

At 03/15/2018 01:24 AM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 12:28 PM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
>> +static void __init acpi_update_possible_map(void)
>> +{
>> +       unsigned int cpu, nr = 0;
>> +
> 
>> +       if (nr_cpu_ids <= nr_unique_ids)
>> +               return;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               if (nr >= nr_unique_ids)
>> +                       set_cpu_possible(cpu, false);
>> +               nr++;
>> +       }
> 
> IIUC this can be optimized to:
> 

Yes, I agree, It's smarter and clearer. Will use it.

Thanks,
	dou

> if (nr_unique_ids >= nr_cpu_ids)
>      return;
> 
> /* Don't yet figure out if it's superfluous */
> if (nr_unique_ids >= cpumask_last(cpu_possible_mask))
>      return;
> 
> for_each_cpu_wrap(cpu, cpu_possible_mask, nr_unique_ids)
>      set_cpu_possible(cpu, false);
> 



>> +       nr_cpu_ids = nr_unique_ids;
>> +       pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
>> +}
> 
