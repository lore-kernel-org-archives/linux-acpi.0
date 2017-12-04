From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 2/4] firmware: dmi: Add function to look up a handle
 and return DIMM size
Date: Mon, 4 Dec 2017 22:38:14 +0100
Message-ID: <20171204213813.rm32qqeqchx37c5x@pd.tnic>
References: <cover.1512070562.git.tony.luck@intel.com>
 <2fae02861e5c446c0cdd30ba3e00fad55db97807.1512070562.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:35104 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdLDViU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Dec 2017 16:38:20 -0500
Content-Disposition: inline
In-Reply-To: <2fae02861e5c446c0cdd30ba3e00fad55db97807.1512070562.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

On Thu, Nov 30, 2017 at 12:40:40PM -0800, Tony Luck wrote:
> When we first scan the SMBIOS table, save the size of the DIMM.
> 
> Provide a function for other code (EDAC driver) to look up the size
> of a DIMM from its SMBIOS handle.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/firmware/dmi_scan.c | 29 +++++++++++++++++++++++++++++
>  include/linux/dmi.h         |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 783041964439..946e86fb1ec6 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -37,6 +37,7 @@ static char dmi_ids_string[128] __initdata;
>  static struct dmi_memdev_info {
>  	const char *device;
>  	const char *bank;
> +	u64 size;
>  	u16 handle;
>  } *dmi_memdev;
>  static int dmi_memdev_nr;
> @@ -395,6 +396,8 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>  {
>  	const char *d = (const char *)dm;
>  	static int nr;
> +	u64 bytes;
> +	u16 size;
>  
>  	if (dm->type != DMI_ENTRY_MEM_DEVICE || dm->length < 0x12)
>  		return;
> @@ -405,6 +408,18 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>  	dmi_memdev[nr].handle = get_unaligned(&dm->handle);
>  	dmi_memdev[nr].device = dmi_string(dm, d[0x10]);
>  	dmi_memdev[nr].bank = dmi_string(dm, d[0x11]);

<---- newline here.

> +	size = get_unaligned((u16 *)&d[0xC]);
> +	if (size == 0)
> +		bytes = 0;
> +	else if (size == 0xffff)
> +		bytes = ~0ul;
> +	else if (size & 0x8000)
> +		bytes = (u64)(size & 0x7fff) << 10;
> +	else if (size != 0x7fff)
> +		bytes = (u64)size << 20;
> +	else
> +		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;

<---- newline here.

> +	dmi_memdev[nr].size = bytes;
>  	nr++;
>  }
>  
> @@ -1073,3 +1088,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(dmi_memdev_name);
> +
> +u64 dmi_memdev_size(u16 handle)
> +{
> +	int n;
> +
> +	if (dmi_memdev) {
> +		for (n = 0; n < dmi_memdev_nr; n++) {
> +			if (handle == dmi_memdev[n].handle)
> +				return dmi_memdev[n].size;
> +		}
> +	}
> +	return ~0ul;
> +}

So dmi_memdev_name() also loops over dmi_memdev and returns bank and
device. This new function returns size.

If code is going to be calling those one after the other, you could do a

	dmi_memdev_desc(u16 handle, struct memdev_desc *desc)

which fills up a descriptor with all fields a caller would need in one
go so that you don't have to iterate multiple times. Looking at struct
dmi_memdev_info, there are no more fields so maybe this is probably
silly though or you can simply return struct dmi_memdev_info directly...

Meh.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
