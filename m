From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/5] acpi, nfit: Add function to look up nvdimm device
 and provide SMBIOS handle
Date: Wed, 28 Feb 2018 10:36:21 -0700
Message-ID: <20180228173621.GA12883@linux.intel.com>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180222195811.27237-4-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180222195811.27237-4-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 22, 2018 at 11:58:09AM -0800, Tony Luck wrote:
> EDAC driver needs to look up attributes of NVDIMMs provided in SMBIOS.
> 
> Provide a function that looks up an acpi_nfit_memory_map from a device
> handle (node/socket/mc/channel/dimm) and returns the SMBIOS handle.
> Also pass back the "flags" so we can see if the NVDIMM is OK.
> 
> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
<>
> diff --git a/include/acpi/nfit.h b/include/acpi/nfit.h
> new file mode 100644
> index 000000000000..6ccc6eacd855
> --- /dev/null
> +++ b/include/acpi/nfit.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright(c) 2017 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */

Just a quick nit - I think we're supposed to use SPDX license identifiers for
new files?
