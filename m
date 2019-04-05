From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference
 on pointer 'target'
Date: Fri, 5 Apr 2019 09:38:00 -0600
Message-ID: <20190405153759.GB25081@localhost.localdomain>
References: <20190405141215.2079-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Busch, Keith" <keith.busch@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 05, 2019 at 07:12:15AM -0700, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'target' is not initialized and is only assigned when the
> ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
> check on target that leads to an uninitialized pointer read and
> dereference when assigning target->processor_pxm when target contains a
> non-null garbage value.  Fix this by initializing targer to null.
> 
> Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
> Addresses-Coverity: ("Uninitialized pointer read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I would have sworn this was fixed as it's in my tree already, but the
submitted patch sure enough doesn't have it.

I've double checked to see if there are any other discrepencies, and
there are no other differences after this.

Thanks for the fix!

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  					      const unsigned long end)
>  {
>  	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
>  		pr_notice("HMAT: Unexpected address range header length: %d\n",
> -- 
