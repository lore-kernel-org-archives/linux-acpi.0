From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 4/5] firmware: dmi: Add function to look up a handle and
 return DIMM size
Date: Sat, 10 Mar 2018 14:22:17 +0100
Message-ID: <20180310142217.0054dc35@endymion>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180222195811.27237-5-tony.luck@intel.com>
 <20180309112053.20605672@endymion>
 <20180309230357.iz7fx47qywx4ijnj@agluck-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180309230357.iz7fx47qywx4ijnj@agluck-desk>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael
 J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Tony,

On Fri, 9 Mar 2018 15:03:58 -0800, Luck, Tony wrote:
> I got side-tracked reading the standard with the ancient ways
> used to report size back in the day when kilobytes was a
> plausible unit. So I wrote code that covers all the crazy
> cases.  Persistant DIMMs have sizes measured in gigabytes.
> I should stop worrying about "0" vs. "fffffff" and just treat
> the old cases as errors and simplify the code to be:
> 
> 	u32 mbytes;
> 
> 	if (size == 0 || (size & 0x8000))
> 		mbytes = 0;
> 	if (size != 0x7fff)

"else" missing.

> 		mbytes = size;
> 	else
> 		mbytes = get_unaligned((u32 *)&d[0x1C]);
> 
> Then I can use 32-bit throughout this and patch 5.

Note that it is possible to store MB values (up to 16 MB) using kB as
the unit. The specification allows for it, and a few systems use that
option. For example [1], the DMI data of a Supermicro X8STi board looks
like:

Handle 0x0038, DMI type 17, 28 bytes
Memory Device
	(...)
	Size: 4096 kB

and it is encoded as 0x9000.

I understand you don't care about such "small" memory modules for
persistent DIMMs, however the API is not specific to these, and it
could be confusing for callers that modules between 1 MB and 16 MB are
sometimes reported as 0 and sometimes not. So I believe that your code
should handle this case.

> Thanks for the review.

You're welcome.

[1] Let's be honest, that was the only instance out of the 180 DMI dumps
I collected. So it's fairly rare. But it did happen.

-- 
Jean Delvare
SUSE L3 Support
