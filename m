From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference on
 pointer 'target'
Date: Tue, 9 Apr 2019 09:51:38 +0200
Message-ID: <CAJZ5v0gxx_4nRS6R8ACfKG7C-eRMh+hXa7WkNYoMzqOTA2WqJQ@mail.gmail.com>
References: <20190405141215.2079-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405141215.2079-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 5, 2019 at 4:12 PM Colin King <colin.king@canonical.com> wrote:
>
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Greg, since the patch fixed by this one is in your tree, can you apply
this too, please?

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..b275016ff648 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>                                               const unsigned long end)
>  {
>         struct acpi_hmat_proximity_domain *p = (void *)header;
> -       struct memory_target *target;
> +       struct memory_target *target = NULL;
>
>         if (p->header.length != sizeof(*p)) {
>                 pr_notice("HMAT: Unexpected address range header length: %d\n",
> --
> 2.20.1
>
