From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 4/5] firmware: dmi: Add function to look up a handle and
 return DIMM size
Date: Tue, 13 Mar 2018 10:43:27 +0100
Message-ID: <20180313104327.7a56046a@endymion>
References: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
 <20180312182430.10335-1-tony.luck@intel.com>
 <20180312182430.10335-5-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180312182430.10335-5-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 12 Mar 2018 11:24:29 -0700, Tony Luck wrote:
> When we first scan the SMBIOS table, save the size of the DIMM.
> 
> Provide a function for other code (EDAC driver) to look up the size
> of a DIMM from its SMBIOS handle.
> 
> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/firmware/dmi_scan.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/dmi.h         |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index e763e1484331..35c6c74c9304 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -32,6 +32,7 @@ static char dmi_ids_string[128] __initdata;
>  static struct dmi_memdev_info {
>  	const char *device;
>  	const char *bank;
> +	u64 size;		/* bytes */
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
> +		bytes = ~0ull;
> +	else if (size & 0x8000)
> +		bytes = (u64)(size & 0x7fff) << 10;
> +	else if (size != 0x7fff)
> +		bytes = (u64)size << 20;
> +	else
> +		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
> +
> +	dmi_memdev[nr].size = bytes;
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
> +	return ~0ull;
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
>  static inline const struct dmi_system_id *
>  	dmi_first_match(const struct dmi_system_id *list) { return NULL; }
>  

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support
