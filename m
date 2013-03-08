From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 11/14] x86, acpi, numa: split SLIT handling out
Date: Thu, 7 Mar 2013 23:18:14 -0800
Message-ID: <CAE9FiQVO0aDrUKE_EV+A+aksqeukn6JMQqbfbKyw8JMV=DpaVw@mail.gmail.com>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
	<1362718720-27048-12-git-send-email-yinghai@kernel.org>
	<20130308064640.GL14556@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130308064640.GL14556@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 7, 2013 at 10:46 PM, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Mar 07, 2013 at 08:58:37PM -0800, Yinghai Lu wrote:
>> +void __init acpi_numa_init_only_slit(void)
>> +{
>> +     /* SLIT: System Locality Information Table */
>> +     acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>> +}
>> +
>> +static int __init __acpi_numa_init(bool with_slit)
>>  {
>>       int cnt = 0;
>
> Hmmm.... how about just having the following two functions
>
>         acpi_numa_init_srat();
>         acpi_numa_init_slit();

ok.


> and update both x86 and ia64 to use the two functions?

ia64 like to call in this seqence
acpi_numa_init()
parse srat
parse slit
then
acpi_numa_arch_fixup()

in this arch_fixup, it will try to fill dummy distance_matrix.

so would to keep acpi_numa_init ...
