From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [Part1 PATCH v5 07/22] x86, ACPI: Store override acpi tables phys
 addr in cpio files info array
Date: Mon, 17 Jun 2013 16:40:34 -0700
Message-ID: <CAE9FiQX9OtxdOLrsMB4zcYL7=B=MnKPNu5+fwfYhf_T2L24XOw@mail.gmail.com>
References: <1371128589-8953-1-git-send-email-tangchen@cn.fujitsu.com>
	<1371128589-8953-8-git-send-email-tangchen@cn.fujitsu.com>
	<20130617233827.GP32663@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130617233827.GP32663@mtj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, Prarit Bhargava <prarit@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2013 at 4:38 PM, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Jun 13, 2013 at 09:02:54PM +0800, Tang Chen wrote:
>> -static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
>> +struct file_pos {
>> +     phys_addr_t data;
>> +     phys_addr_t size;
>> +};
>
> Isn't file_pos too generic as name?  Would acpi_initrd_file_pos too
> long?  Maybe just struct acpi_initrd_file?

ok, will change to acpi_initrd_file.

Thanks

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
