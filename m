From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH v2 2/4] hpet: pass physical address, not entire hpet_data,
	to hpet_is_known()
Date: Thu, 18 Mar 2010 12:25:12 -0700
Message-ID: <3055132f1003181225g72009919he645c3cce9986c58@mail.gmail.com>
References: <20100318175852.15143.2124.stgit@bob.kio>
	 <20100318175935.15143.96345.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:23127 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0CRTZS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2010 15:25:18 -0400
In-Reply-To: <20100318175935.15143.96345.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Acked-by: Venkatesh Pallipadi <venki@google.com>

On Thu, Mar 18, 2010 at 10:59 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
>
> No functional change; hpet_is_known() only needs the physical address=
,
> so supplying that instead of the whole struct hpet_data makes the cal=
lers
> a little simpler.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Acked-by: Clemens Ladisch <clemens@ladisch.de>
> ---
>
> =A0drivers/char/hpet.c | =A0 14 +++++---------
> =A01 files changed, 5 insertions(+), 9 deletions(-)
>
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 5cb05ed..d132fef 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -662,12 +662,12 @@ static const struct file_operations hpet_fops =3D=
 {
> =A0 =A0 =A0 =A0.mmap =3D hpet_mmap,
> =A0};
>
> -static int hpet_is_known(struct hpet_data *hdp)
> +static int hpet_is_known(unsigned long phys_address)
> =A0{
> =A0 =A0 =A0 =A0struct hpets *hpetp;
>
> =A0 =A0 =A0 =A0for (hpetp =3D hpets; hpetp; hpetp =3D hpetp->hp_next)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hpetp->hp_hpet_phys =3D=3D hdp->hd_=
phys_address)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hpetp->hp_hpet_phys =3D=3D phys_add=
ress)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
>
> =A0 =A0 =A0 =A0return 0;
> @@ -788,7 +788,7 @@ int hpet_alloc(struct hpet_data *hdp)
> =A0 =A0 =A0 =A0 * If platform dependent code has allocated the hpet t=
hat
> =A0 =A0 =A0 =A0 * ACPI has also reported, then we catch it here.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (hpet_is_known(hdp)) {
> + =A0 =A0 =A0 if (hpet_is_known(hdp->hd_phys_address)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_DEBUG "%s: duplicate HPET =
ignored\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -909,12 +909,7 @@ static int hpet_pnp_add(struct pnp_dev *dev, con=
st struct pnp_device_id *dev_id)
> =A0 =A0 =A0 =A0memset(&data, 0, sizeof(data));
>
> =A0 =A0 =A0 =A0mem =3D pnp_get_resource(dev, IORESOURCE_MEM, 0);
> - =A0 =A0 =A0 if (!mem)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 data.hd_phys_address =3D mem->start;
> -
> - =A0 =A0 =A0 if (hpet_is_known(&data))
> + =A0 =A0 =A0 if (!mem || hpet_is_known(mem->start))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> =A0 =A0 =A0 =A0i =3D 0;
> @@ -926,6 +921,7 @@ static int hpet_pnp_add(struct pnp_dev *dev, cons=
t struct pnp_device_id *dev_id)
> =A0 =A0 =A0 =A0if (!data.hd_nirqs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> + =A0 =A0 =A0 data.hd_phys_address =3D mem->start;
> =A0 =A0 =A0 =A0data.hd_address =3D ioremap(mem->start, resource_size(=
mem));
>
> =A0 =A0 =A0 =A0return hpet_alloc(&data);
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
