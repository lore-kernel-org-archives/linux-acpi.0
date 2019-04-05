From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference on
 pointer 'target'
Date: Fri, 5 Apr 2019 21:36:04 +0530
Message-ID: <3cfa8f02-7fef-72ec-03c3-1acdcc8f0f89@codeaurora.org>
References: <20190405141215.2079-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On 4/5/2019 7:42 PM, Colin King wrote:
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
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/acpi/hmat/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>   					      const unsigned long end)
>   {
>   	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>   
>   	if (p->header.length != sizeof(*p)) {
>   		pr_notice("HMAT: Unexpected address range header length: %d\n",
