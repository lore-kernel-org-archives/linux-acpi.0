From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PNPACPI breaks my asus k6-2 parallel port
Date: Wed, 08 Dec 2004 10:23:39 +0800
Message-ID: <1102472619.2876.8.camel@sli10-desk.sh.intel.com>
References: <200412080217.LAA15383@axe-inc.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412080217.LAA15383-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takanori Watanabe <takawata-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-12-08 at 10:17, Takanori Watanabe wrote:
> >Could you please clarify it? Linux did check _STA, and only assigned
> >dependent resources (that is one set of resources) from _PRS to a
> >device.
> >In Wilcox's case, LPT (PNP0400) has resources of 0x378, irq 7. PNPACPI
> >can only assign 0x278, irq 5 to ECP (PNP0401) the resources are listed
> >in ECP's _PRS. ECP possibly isn't a parport (Dunno why it said a parport
> >detected), it can use DMA per the _PRS.
> 
> In many case, single Parallel port is appeared as multiple device,
> like ECP port, simple parport,etc ...  in ACPI name space 
> with only one of them activated. And if you try to wake up all resources,
> only the last activated one will make available, I think.
Thanks Watanabe-san. Wilcox's case possibly is like what you said. If
so, the fix isn't straightforward. PNP layer always automatically
actives disabled devices. Possibly the BIOS (_STA) should tell us the
device is absent.

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
