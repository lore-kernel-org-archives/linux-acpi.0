From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: fix types when decoding ACPI
	resources [resend]
Date: Thu, 04 Aug 2005 08:51:52 +0800
Message-ID: <1123116712.2929.8.camel@linux-hp.sh.intel.com>
References: <200508020955.54844.bjorn.helgaas@hp.com>
	 <1123030861.2937.4.camel@linux-hp.sh.intel.com>
	 <200508030920.13450.bjorn.helgaas@hp.com>  <42F1343B.70707@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F1343B.70707-GANU6spQydw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-08-03 at 23:16 +0200, matthieu castet wrote:
> 
> There are drivers/acpi/motherboard.c that done some stuff already handle 
> by pnp/system.c.
Yes, it should be disabled if pnpacpi is enabled. The only concern is
motherboard.c also request some ACPI resources, which might not declaim
in ACPI motherboard device, but it's completely BIOS dependent. We might
could try remove it at -mm tree to see if it breaks any system later.

> 
> PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
> will be removed to register again the pnp device in acpi layer. Do you 
> plan to add more check and for example add only device that have a CRS 
> in pnp layer ?
For detecting PNP device? it's worthy trying.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
