From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 04/20] x86, ACPI: Increase override tables number limit
Date: Thu, 4 Apr 2013 11:03:30 -0700
Message-ID: <CAE9FiQXJjALfmRSZH_H4qAJrCV0+jQOTEk=fUHn_3+eLZ6XQfA@mail.gmail.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
	<1362897887-30808-5-git-send-email-yinghai@kernel.org>
	<20130404175017.GS9425@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130404175017.GS9425@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 4, 2013 at 10:50 AM, Tejun Heo <tj@kernel.org> wrote:
> On Sat, Mar 09, 2013 at 10:44:31PM -0800, Yinghai Lu wrote:

>> @@ -648,14 +647,14 @@ void __init acpi_initrd_override(void *data, size_t size)
>>       memblock_reserve(acpi_tables_addr, acpi_tables_addr + all_tables_size);
>>       arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
>>
>> -     p = early_ioremap(acpi_tables_addr, all_tables_size);
>> -
>
> It'd be nice to have a brief comment here explaining why we're mapping
> each table separately.

ok, will copy lines from changelog to comment.

Thanks

Yinghai
