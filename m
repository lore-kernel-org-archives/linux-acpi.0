From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 03/12] Panasonic ACPI driver
Date: 02 Mar 2005 13:44:45 -0500
Message-ID: <1109789085.2102.564.camel@d845pe>
References: <200502230953.j1N9rDYM020696@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rDYM020696-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, thoenig-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have no plans to add this driver to the kernel tree,
as I expect a generic solution in 2.6.12 which would just
require us to turn around and delete this.

-Len

On Wed, 2005-02-23 at 04:52, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Timo Hoenig <thoenig-l3A5Bk7waGM@public.gmane.org>
> 
> This is another ACPI driver for several Panasonic notebooks.  The
> driver
> provides support for hotkeys and enables access to other hardware like
> reading/setting the LCD brightness.
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/Kconfig    |   16
>  25-akpm/drivers/acpi/Makefile   |    1
>  25-akpm/drivers/acpi/pcc_acpi.c |  937
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 954 insertions(+)
> 
> diff -puN drivers/acpi/Kconfig~panasonic-acpi-driver
> drivers/acpi/Kconfig
> --- 25/drivers/acpi/Kconfig~panasonic-acpi-driver       2005-02-23
> 01:47:59.000000000 -0800




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
