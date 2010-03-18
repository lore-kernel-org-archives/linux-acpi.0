From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH v2 3/4] hpet: clean up io mapping when hpet_alloc() fails
Date: Thu, 18 Mar 2010 12:25:39 -0700
Message-ID: <3055132f1003181225x797cb955oeed07c50b1652952@mail.gmail.com>
References: <20100318175852.15143.2124.stgit@bob.kio>
	 <20100318175940.15143.53027.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:23239 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0CRTZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2010 15:25:43 -0400
In-Reply-To: <20100318175940.15143.53027.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Acked-by: Venkatesh Pallipadi <venki@google.com>

On Thu, Mar 18, 2010 at 10:59 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
>
> When hpet_alloc() fails, we should iounmap() the timer so we don't le=
ak
> the mapping.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>
> =A0drivers/char/hpet.c | =A0 =A08 ++++++--
> =A01 files changed, 6 insertions(+), 2 deletions(-)
>
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index d132fef..8961985 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -904,7 +904,7 @@ static int hpet_pnp_add(struct pnp_dev *dev, cons=
t struct pnp_device_id *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct hpet_data data;
> =A0 =A0 =A0 =A0struct resource *mem, *irq;
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int i, ret;
>
> =A0 =A0 =A0 =A0memset(&data, 0, sizeof(data));
>
> @@ -924,7 +924,11 @@ static int hpet_pnp_add(struct pnp_dev *dev, con=
st struct pnp_device_id *dev_id)
> =A0 =A0 =A0 =A0data.hd_phys_address =3D mem->start;
> =A0 =A0 =A0 =A0data.hd_address =3D ioremap(mem->start, resource_size(=
mem));
>
> - =A0 =A0 =A0 return hpet_alloc(&data);
> + =A0 =A0 =A0 ret =3D hpet_alloc(&data);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(data.hd_address);
> +
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static void hpet_pnp_remove(struct pnp_dev *dev)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
