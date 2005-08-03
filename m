From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
Date: Wed, 03 Aug 2005 09:01:01 +0800
Message-ID: <1123030861.2937.4.camel@linux-hp.sh.intel.com>
References: <200508020955.54844.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508020955.54844.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-08-02 at 09:55 -0600, Bjorn Helgaas wrote:
> Any objections to the patch below?  I posted it last Wednesday,
> but haven't heard anything.  Once we have this fix, 8250_pnp
> should have sufficient functionality that we can get rid of
> 8250_acpi.
> 
> 
> 
> Use types that match the ACPI resource structures.  Previously
> the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> which corrupts the value.
> 
> This is one of the things that prevents 8250_pnp from working
> on HP ia64 boxes.  After 8250_pnp works, we will be able to
> remove 8250_acpi.c.
We might always use 'unsigned long'. Did you have plan to remove other
legacy acpi drivers?

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
