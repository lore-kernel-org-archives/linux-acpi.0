From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] resend, early ACPI init
Date: Tue, 15 Feb 2005 14:56:54 -0700
Message-ID: <1108504614.7373.92.camel@tdi>
References: <1108497779.7373.24.camel@tdi>
	 <1108500423.2096.285.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108500423.2096.285.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-02-15 at 15:47 -0500, Len Brown wrote:
> Rather than add a CONFIG option to enable/disable ACPI extra early,
> could it be possible to simply enable ACPI earlier and leave it enabled
> on all platforms?
> 
> I'm really not excited about yet another CONFIG option -- we need fewer,
> not more.  And if earlier init is necessary on one machine, we may find
> over time that we need it on others too.

   Yes, an early, one-time init would certainly make more sense than
doing the whole thing twice.  I wasn't sure if anyone would be
interested in generically hooking ACPI in that early and deeply.

> Indeed, in 2.6 we moved most of the init earlier into acpi_early_init(),
> but that wasn't as early as this, and didn't include the object_init,
> which apparently is what you're looking for.

   Yep, for my current usage, I just need to look through namespace for
a specific _HID value.

> I'm also nervous about enabling/disabling ACPI mode and then enabling it
> again -- this could risk unforseen firmware interactions.

   I'm nervous about that too.  In fact, my current usage is limited to
only running on an ia64 box with a specific ACPI static table OEM ID.
If it isn't an obvious dead-end, I'll look into a generic interface that
could be brought up early and stay up.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
