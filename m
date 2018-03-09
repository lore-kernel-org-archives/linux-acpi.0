From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] firmware: dmi: Add function to look up a handle and
 return DIMM size
Date: Fri, 9 Mar 2018 15:03:58 -0800
Message-ID: <20180309230357.iz7fx47qywx4ijnj@agluck-desk>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180222195811.27237-5-tony.luck@intel.com>
 <20180309112053.20605672@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180309112053.20605672@endymion>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 09, 2018 at 11:20:53AM +0100, Jean Delvare wrote:
> > +	else if (size & 0x8000)
> > +		bytes = (u64)(size & 0x7fff) << 10;
> > +	else if (size != 0x7fff)
> > +		bytes = (u64)size << 20;
> > +	else
> > +		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
> > +
> > +	dmi_memdev[nr].size = bytes;
> 
> I'm curious, do you really need to know the amount of memory to the
> byte? The SMBIOS specification itself does not support granularity
> under 1 kB. I would be very surprised if any machine running Linux
> today has memory modules under 1 MB. If storing in MB you wouldn't need
> a u64...

I got side-tracked reading the standard with the ancient ways
used to report size back in the day when kilobytes was a
plausible unit. So I wrote code that covers all the crazy
cases.  Persistant DIMMs have sizes measured in gigabytes.
I should stop worrying about "0" vs. "fffffff" and just treat
the old cases as errors and simplify the code to be:

	u32 mbytes;

	if (size == 0 || (size & 0x8000))
		mbytes = 0;
	if (size != 0x7fff)
		mbytes = size;
	else
		mbytes = get_unaligned((u32 *)&d[0x1C]);

Then I can use 32-bit throughout this and patch 5.

Thanks for the review.

-Tony
