From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v2 04/18] acpi: Introduce acpi_invalid_table() to check
 if a table is invalid.
Date: Fri, 02 Aug 2013 09:34:13 +0800
Message-ID: <51FB0C95.8040207@cn.fujitsu.com>
References: <1375340800-19332-1-git-send-email-tangchen@cn.fujitsu.com>  <1375340800-19332-5-git-send-email-tangchen@cn.fujitsu.com> <1375396019.10300.32.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1375396019.10300.32.camel@misato.fc.hp.com>
Sender: linux-doc-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, tj@kernel.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/02/2013 06:26 AM, Toshi Kani wrote:
......
>> +int __init acpi_invalid_table(struct cpio_data *file,
>> +			      const char *path, const char *signature)
>
> Since this function verifies a given acpi table in initrd (not that the
> table is invalid), I'd suggest to rename it something like
> acpi_verify_initrd().  Otherwise, it looks good to me.
>

Hi Toshi-san,

Thanks, will change the name.

Thanks.

> Acked-by: Toshi Kani<toshi.kani@hp.com>
>

