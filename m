From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 10/18] x86, acpi: Try to find if SRAT is overrided
 earlier.
Date: Fri, 02 Aug 2013 10:05:27 -0600
Message-ID: <1375459527.10300.77.camel@misato.fc.hp.com>
References: <1375340800-19332-1-git-send-email-tangchen@cn.fujitsu.com>
	  <1375340800-19332-11-git-send-email-tangchen@cn.fujitsu.com>
	 <1375406353.10300.73.camel@misato.fc.hp.com>
	 <51FB485A.9070801@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51FB485A.9070801@cn.fujitsu.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, tj@kernel.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2013-08-02 at 13:49 +0800, Tang Chen wrote:
> On 08/02/2013 09:19 AM, Toshi Kani wrote:
> ......
> >> +phys_addr_t __init early_acpi_override_srat(void)
> >> +{
> >> +	int i;
> >> +	u32 length;
> >> +	long offset;
> >> +	void *ramdisk_vaddr;
> >> +	struct acpi_table_header *table;
> >> +	struct cpio_data file;
> >> +	unsigned long map_step = NR_FIX_BTMAPS<<  PAGE_SHIFT;
> >> +	phys_addr_t ramdisk_image = get_ramdisk_image();
> >> +	char cpio_path[32] = "kernel/firmware/acpi/";
> >
> > Don't you need to check if ramdisk is present before parsing the table?
> > You may need something like:
> >
> >    if (!ramdisk_image || !get_ramdisk_size())
> >          return 0;
> 
> Yes, it is better to do such a check here. But is there a possibility that
> no ramdisk is present and we come to setup_arch() ?

Without a ramdisk, the boot procedure will likely fail in mounting the
root disk due to missing drivers.  But it should come to setup_arch()
without it.

Thanks,
-Toshi


> 
> ......
> >> +
> >> +	return ramdisk_image;
> >
> > Doesn't this function return a physical address regardless of SRAT if a
> > ramdisk is present?
> 
> Yes, and it is not good. I'll add the check above so that this won't happen.
> 
> Thanks.
> 


