From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ACPI: use ioremap_cache()
Date: Mon, 27 Dec 2010 19:35:27 -0800
Message-ID: <4D195AFF.9020106@zytor.com>
References: <20101214220932.GA1206@sgi.com>	 <alpine.LFD.2.00.1012141903210.25387@x980> <20101215024136.GB19601@sgi.com>	 <alpine.LFD.2.00.1012142302110.4878@x980> <20101215164635.GA27373@sgi.com>	 <alpine.LFD.2.00.1012151536510.21167@x980>	 <alpine.LFD.2.00.1012162149370.20940@x980>	 <alpine.LFD.2.00.1012170307080.20940@x980> <1293506460.10593.43.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293506460.10593.43.camel@sli10-conroe>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, Jack Steiner <steiner@sgi.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "tony.luck@gmail.com" <tony.luck@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gbeshers@sgi.com" <gbeshers@sgi.com>
List-Id: linux-acpi@vger.kernel.org

On 12/27/2010 07:21 PM, Shaohua Li wrote:
> RCRB is a memory mapped io. In ICH, it's chipset configuration
> registers. this range can't be cached.
> I thought we should add a check like
> if page is E820_RAM or E820_ACPI then
> 	cached_map
> else
> 	uncached_map
> we have page_is_ram() API which just checks E820_RAM, I thought we can
> add a new API to check E820_ACPI.

For x86, that is handled by the MTRRs; for ia64, I would assume
ioremap() handles that somehow, otherwise it wouldn't be able to handle
existing drivers with ioremap() in them.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
