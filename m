From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable
	power state limit
Date: 05 Nov 2004 18:11:33 -0500
Message-ID: <1099696293.13834.1639.camel@d845pe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com>
	 <200410112335.19159.jos.delbar@ugent.be>
	 <1099683907.13837.1353.camel@d845pe>
	 <20041105225438.GA8262@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041105225438.GA8262-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-11-05 at 17:54, Dominik Brodowski wrote:

> That sounds to be quite racy. Multiple callers will get confused.
> You probably need a
> 

comitted design defect;-)

Yeah, James mentioned this too and suggested he send in a pci_dev
from the ipw2100 driver.  But I didn't think this workaround
justified the complexity.

After all, 99% of the time it will be not used.
the other 99% of 1% the time it is used, it will be used
only at module load/init time.

but if you're excited about enhancing it,
please go ahead.  I do want to lock down the driver API
ASAP, however, since james needs to release his driver.

> Other than that, the current "limit" interface to processor.c seems to
> be
> pretty much useless as P-States aren't really handled.

right, this doesn't have anything to do with p-states.
if we need that too, fine, but we need an api we
can use for c-states locked now.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
