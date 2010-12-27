From: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI: use ioremap_cache()
Date: Mon, 27 Dec 2010 11:42:18 -0800
Message-ID: <AANLkTin7WmYo47JvCMSjExkZ8o2rPajB3fOxU80-UdE1@mail.gmail.com>
References: <20101214220932.GA1206@sgi.com>
	<alpine.LFD.2.00.1012141903210.25387@x980>
	<20101215024136.GB19601@sgi.com>
	<alpine.LFD.2.00.1012142302110.4878@x980>
	<20101215164635.GA27373@sgi.com>
	<alpine.LFD.2.00.1012151536510.21167@x980>
	<alpine.LFD.2.00.1012162149370.20940@x980>
	<alpine.LFD.2.00.1012170307080.20940@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1012170307080.20940@x980>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jack Steiner <steiner@sgi.com>, hpa@zytor.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 17, 2010 at 12:08 AM, Len Brown <lenb@kernel.org> wrote:
> No change on ia64.

Apart from breaking the build :-(

> +++ b/arch/ia64/include/asm/io.h
   ...
> +static inline void __iomem * ioremap_cache (unsigned long phys_addr,=
 unsigned long size)
> +{
> + =A0 =A0 =A0 return ioremap(unsigned long phys_addr, unsigned long s=
ize);
> +}

Cut & paste issue? ... the compiler would be a lot happier
without the "unsigned long"s in the call to ioremap().

-Tony
