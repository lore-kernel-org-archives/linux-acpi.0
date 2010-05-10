From: Huang Ying <ying.huang@intel.com>
Subject: Re: linux-next: Tree for May 7 (apei)
Date: Mon, 10 May 2010 08:33:10 +0800
Message-ID: <1273451590.3344.52.camel@yhuang-dev.sh.intel.com>
References: <20100507155520.75026a8b.sfr@canb.auug.org.au>
	 <20100507085509.fb5682d4.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100507085509.fb5682d4.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2010-05-07 at 23:55 +0800, Randy Dunlap wrote:
> On Fri, 7 May 2010 15:55:20 +1000 Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > Changes since 20100506:
> 
> 
> drivers/acpi/apei/einj.c:127:error: implicit declaration of function 'ndelay'
> => needs to #include <linux/delay.h>
> 
> 
> 
> ghes.c:(.text+0x119e71): undefined reference to `apei_mce_report_mem_error'
> 
> CONFIG_X86_MCE is not enabled, so make never descends into the
> arch/x86/kernel/cpu/mcheck/ sub-directory to build mce-apei.o.
> 
> config attached.

Hi, Randy,

Thank you for your reporting. I will fix it as soon as possible.

Hi, Len,

Fixing them in a new fixing patch or providing a update version (v2) of
whole patch queue, which one do you prefer?

Best Regards,
Huang Ying
