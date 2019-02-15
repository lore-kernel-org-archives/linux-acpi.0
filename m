From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
Date: Fri, 15 Feb 2019 10:28:56 +0100
Message-ID: <CAJZ5v0g0mVP_mzpTbHzGYavdbL8UbaXbYsqgEftOMnBEE22Xvg@mail.gmail.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAJZ5v0j03Dj7XSbTNcu7Ew2SekdpTw2hrWT_L+5ZcdRUep7ppw@mail.gmail.com>
 <86a1eddc-01aa-f32a-9bef-c18c7649149b@huawei.com> <2813657.1l3PCoQO4Z@aspire.rjw.lan>
 <8baf1617-6037-2645-bc8a-a6dcf8f7f53b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8baf1617-6037-2645-bc8a-a6dcf8f7f53b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, gcherianv@gmail.com, Prashanth Prakash <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 15, 2019 at 2:25 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
>
>
> On 2019/2/15 7:15, Rafael J. Wysocki wrote:
> > On Thursday, February 14, 2019 2:58:21 PM CET Xiongfeng Wang wrote:
> >>
> >> On 2019/2/14 18:58, Rafael J. Wysocki wrote:
> >>> On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
> >>> <wangxiongfeng2@huawei.com> wrote:
> >>>>
> >>>> Hisilicon chips do not support delivered performance counter register
> >>>> and reference performance counter register. But the platform can
> >>>> calculate the real performance using its own method. This patch provide
> >>>> a workaround for this problem, and other platforms can also use this
> >>>> workaround framework. We reuse the desired performance register to
> >>>> store the real performance calculated by the platform. After the
> >>>> platform finished the frequency adjust, it gets the real performance and
> >>>> writes it into desired performance register. OS can use it to calculate
> >>>> the real frequency.
> >>>>
> >>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >>>> ---
> >>>>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 70 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >>>> index fd25c21c..da96fec 100644
> >>>> --- a/drivers/cpufreq/cppc_cpufreq.c
> >>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >>>> @@ -33,6 +33,16 @@
> >>>>  /* Offest in the DMI processor structure for the max frequency */
> >>>>  #define DMI_PROCESSOR_MAX_SPEED  0x14
> >>>>
> >>>> +struct cppc_workaround_info {
> >>>> +       char oem_id[ACPI_OEM_ID_SIZE +1];
> >>>> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> >>>> +       u32 oem_revision;
> >>>> +       unsigned int (*get_rate)(unsigned int cpu);
> >>>> +};
> >>>> +
> >>>> +/* CPPC workaround for get_rate callback */
> >>>> +unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
> >>>> +
> >>>
> >>> First off, please don't split the workaround material into two parts.
> >>> IOW, the other new function added below can go here just fine IMO.
> >>>
> >>>>  /*
> >>>>   * These structs contain information parsed from per CPU
> >>>>   * ACPI _CPC structures.
> >>>> @@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >>>>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> >>>>         int ret;
> >>>>
> >>>> +       if (cppc_wa_get_rate)
> >>>> +               return cppc_wa_get_rate(cpunum);
> >>>
> >>> Second, what is the value of using the function pointer above?
> >>>
> >>> All we need for now is a flag to indicate whether or not to call
> >>> hisi_cppc_cpufreq_get_rate() here and return its return value.
> >>
> >> How about adding a pointer of 'struct cppc_workaround_info' to indicate whether we have
> >> found a matches workaround ?
> >> If I use a flag, I will need another variable to indicate which item of the workaround array 'wa_info'
> >> to use.
> >
> > And why do you need to distinguish one of them from the other?
> >
>
> I was thinking about future extension. Different platform may have different implementation
> of 'get_rate' in the future.

That's right, but whoever adds this in the future may change the
driver accordingly.  They will have to make changes to it anyway.
