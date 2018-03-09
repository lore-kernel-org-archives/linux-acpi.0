From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 4/5] firmware: dmi: Add function to look up a handle and
 return DIMM size
Date: Fri, 9 Mar 2018 11:20:53 +0100
Message-ID: <20180309112053.20605672@endymion>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180222195811.27237-5-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180222195811.27237-5-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael
 J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Tony,

On Thu, 22 Feb 2018 11:58:10 -0800, Tony Luck wrote:
> When we first scan the SMBIOS table, save the size of the DIMM.
> 
> Provide a function for other code (EDAC driver) to look up the size
> of a DIMM from its SMBIOS handle.

On the principle I'm OK with the idea. My comments on the
implementation details are inline below.

> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/firmware/dmi_scan.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/dmi.h         |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index e763e1484331..9947f1f6ef7b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -32,6 +32,7 @@ static char dmi_ids_string[128] __initdata;
>  static struct dmi_memdev_info {
>  	const char *device;
>  	const char *bank;
> +	u64 size;

A comment stating in which unit the size is stored would be appreciated.

>  	u16 handle;
>  } *dmi_memdev;
>  static int dmi_memdev_nr;
> @@ -386,6 +387,8 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>  {
>  	const char *d = (const char *)dm;
>  	static int nr;
> +	u64 bytes;
> +	u16 size;
>  
>  	if (dm->type != DMI_ENTRY_MEM_DEVICE || dm->length < 0x12)
>  		return;
> @@ -396,6 +399,20 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>  	dmi_memdev[nr].handle = get_unaligned(&dm->handle);
>  	dmi_memdev[nr].device = dmi_string(dm, d[0x10]);
>  	dmi_memdev[nr].bank = dmi_string(dm, d[0x11]);
> +
> +	size = get_unaligned((u16 *)&d[0xC]);
> +	if (size == 0)
> +		bytes = 0;
> +	else if (size == 0xffff)
> +		bytes = ~0ul;

Should this not be ~0ull? On 32-bit systems ~0ul would be 0xffffffff not
0xffffffffffffffff.

Also it would be nice to document somewhere that 0 means memory module
not installed and all fs means size is unknown.

> +	else if (size & 0x8000)
> +		bytes = (u64)(size & 0x7fff) << 10;
> +	else if (size != 0x7fff)
> +		bytes = (u64)size << 20;
> +	else
> +		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
> +
> +	dmi_memdev[nr].size = bytes;

I'm curious, do you really need to know the amount of memory to the
byte? The SMBIOS specification itself does not support granularity
under 1 kB. I would be very surprised if any machine running Linux
today has memory modules under 1 MB. If storing in MB you wouldn't need
a u64...

>  	nr++;
>  }
>  
> @@ -1065,3 +1082,17 @@ void dmi_memdev_name(u16 handle, const char **bank, const char **device)
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

~0ull?

> +}
> +EXPORT_SYMBOL_GPL(dmi_memdev_size);
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index 46e151172d95..7f5929123b69 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -113,6 +113,7 @@ extern int dmi_walk(void (*decode)(const struct dmi_header *, void *),
>  	void *private_data);
>  extern bool dmi_match(enum dmi_field f, const char *str);
>  extern void dmi_memdev_name(u16 handle, const char **bank, const char **device);
> +extern u64 dmi_memdev_size(u16 handle);
>  
>  #else
>  
> @@ -142,6 +143,7 @@ static inline bool dmi_match(enum dmi_field f, const char *str)
>  	{ return false; }
>  static inline void dmi_memdev_name(u16 handle, const char **bank,
>  		const char **device) { }
> +static inline u64 dmi_memdev_size(u16 handle) { return ~0ul; }

~0ull?

>  static inline const struct dmi_system_id *
>  	dmi_first_match(const struct dmi_system_id *list) { return NULL; }
>  

-- 
Jean Delvare
SUSE L3 Support
