From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [patch 11/12] new sony_acpi driver
Date: Wed, 2 Mar 2005 21:53:24 +0100
Message-ID: <20050302205324.GA5486@deep-space-9.dsnet>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <1109790760.2097.587.camel@d845pe>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109790760.2097.587.camel@d845pe>
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
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 02, 2005 at 02:12:40PM -0500, Len Brown wrote:

> I'd like to keep this driver out-of-tree
> until we prove that we can't enhance the
> generic code to handle this hardware
> without the addition of a new driver.

I have no problem keeping it out of the tree, it has been this was
for quite a long time now. Anyway the distro maintainers are starting
to put it into their kernels so it won't be a problem for endusers
any longer. BTW, it was those distro maintainers who asked me to
resubmit the driver lately...

But still, I don't see why there is no place for a sony acpi somewhere
where there are already drivers for ibm, toshiba and asus laptops.

I attached to the bugzilla entry the DSDTs for two Vaio laptops, which
should hopefuly prove that those laptops do not support the standard
ACPI way to access the video. Did you look at them ?

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
