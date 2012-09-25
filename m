From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PNP: Add a release method to system resource driver
Date: Tue, 25 Sep 2012 10:27:18 -0600
Message-ID: <CAErSpo5NgmguZTT7dQwj+7JZoTHVm5t+ubh1zHtPVTH5XGKkcQ@mail.gmail.com>
References: <1348579544-1573-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348579544-1573-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: abelay@mit.edu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 25, 2012 at 7:25 AM, Matthew Garrett <mjg@redhat.com> wrote:
> This could conceivably be hotpluggable, and we may want to displace it
> from devices under certain circustances, so add a release method to hand

s/circustances/circumstances/

> back the resources.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I've never directly applied PNP patches; I've always sent them through
Len's ACPI tree (cc'd), so let me know if you want me to do more than
ack this.

> ---
>  drivers/pnp/system.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
> index 49c1720..b0a50f2 100644
> --- a/drivers/pnp/system.c
> +++ b/drivers/pnp/system.c
> @@ -52,7 +52,17 @@ static void reserve_range(struct pnp_dev *dev, struct resource *r, int port)
>                  res ? "has been" : "could not be");
>  }
>
> -static void reserve_resources_of_dev(struct pnp_dev *dev)
> +static void free_range(struct pnp_dev *dev, struct resource *r, int port)
> +{
> +       resource_size_t start = r->start, end = r->end;
> +
> +       if (port)
> +               release_region(start, end - start + 1);
> +       else
> +               release_mem_region(start, end - start + 1);
> +}
> +
> +static void handle_resources_of_dev(struct pnp_dev *dev, bool free)
>  {
>         struct resource *res;
>         int i;
> @@ -75,29 +85,41 @@ static void reserve_resources_of_dev(struct pnp_dev *dev)
>                 if (res->end < res->start)
>                         continue;       /* invalid */
>
> -               reserve_range(dev, res, 1);
> +               if (free)
> +                       free_range(dev, res, 1);
> +               else
> +                       reserve_range(dev, res, 1);
>         }
>
>         for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++) {
>                 if (res->flags & IORESOURCE_DISABLED)
>                         continue;
>
> -               reserve_range(dev, res, 0);
> +               if (free)
> +                       free_range(dev, res, 0);
> +               else
> +                       reserve_range(dev, res, 0);
>         }
>  }
>
>  static int system_pnp_probe(struct pnp_dev *dev,
>                             const struct pnp_device_id *dev_id)
>  {
> -       reserve_resources_of_dev(dev);
> +       handle_resources_of_dev(dev, false);
>         return 0;
>  }
>
> +static void system_pnp_remove(struct pnp_dev *dev)
> +{
> +       handle_resources_of_dev(dev, true);
> +}
> +
>  static struct pnp_driver system_pnp_driver = {
>         .name     = "system",
>         .id_table = pnp_dev_table,
>         .flags    = PNP_DRIVER_RES_DO_NOT_CHANGE,
>         .probe    = system_pnp_probe,
> +       .remove   = system_pnp_remove,
>  };
>
>  static int __init pnp_system_init(void)
> --
> 1.7.11.4
>
