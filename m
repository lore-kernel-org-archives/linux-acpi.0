From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PNPACPI: Simplify disabled resource registration
Date: Tue, 13 Sep 2011 10:25:20 -0600
Message-ID: <CAErSpo55KB7Gwc26=zm0kJozsjQcdtG+PQFYFd4v1V8mT7gEoA@mail.gmail.com>
References: <20110822005902.GA30602@gallifrey> <4DF117B8.8080408@gmx.net> <4DF11908.2030509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:22851 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab1IMQZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2011 12:25:43 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p8DGPggL019691
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 09:25:42 -0700
Received: from yib12 (yib12.prod.google.com [10.243.65.76])
	by wpaz24.hot.corp.google.com with ESMTP id p8DGNW6j026986
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 09:25:41 -0700
Received: by yib12 with SMTP id 12so438363yib.29
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 09:25:40 -0700 (PDT)
In-Reply-To: <4DF11908.2030509@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jun 9, 2011 at 1:03 PM, Witold Szczeponik
<Witold.Szczeponik@gmx.net> wrote:
> The attached patch simplifies 29df8d8f8702f0f53c1375015f09f04bc8d023c=
1. =A0As
> the "pnp_xxx" structs are not designed to cope with IORESOURCE_DISABL=
ED, and
> hence no code can test for this value, setting this value is actually=
 a "no op"
> and can be skipped altogether. =A0It is sufficient to remove the chec=
ks for
> "empty" resources and continue processing.
>
>
> Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I think keeping all the resources is the right thing because we need
them for _SRS templates, as you mentioned.

Len normally takes PNP patches through his ACPI tree.

>
>
> diff -u linux/drivers/pnp/pnpacpi/rsparser.c linux/drivers/pnp/pnpacp=
i/rsparser.c
> --- linux/drivers/pnp/pnpacpi/rsparser.c
> +++ linux/drivers/pnp/pnpacpi/rsparser.c
> @@ -509,15 +509,12 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct acpi_resource_dma *p)
> =A0{
> =A0 =A0 =A0 =A0int i;
> - =A0 =A0 =A0 unsigned char map =3D 0, flags =3D 0;
> -
> - =A0 =A0 =A0 if (p->channel_count =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> + =A0 =A0 =A0 unsigned char map =3D 0, flags;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < p->channel_count; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map |=3D 1 << p->channels[i];
>
> - =A0 =A0 =A0 flags |=3D dma_flags(dev, p->type, p->bus_master, p->tr=
ansfer);
> + =A0 =A0 =A0 flags =3D dma_flags(dev, p->type, p->bus_master, p->tra=
nsfer);
> =A0 =A0 =A0 =A0pnp_register_dma_resource(dev, option_flags, map, flag=
s);
> =A0}
>
> @@ -527,17 +524,14 @@
> =A0{
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0pnp_irq_mask_t map;
> - =A0 =A0 =A0 unsigned char flags =3D 0;
> -
> - =A0 =A0 =A0 if (p->interrupt_count =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> + =A0 =A0 =A0 unsigned char flags;
>
> =A0 =A0 =A0 =A0bitmap_zero(map.bits, PNP_IRQ_NR);
> =A0 =A0 =A0 =A0for (i =3D 0; i < p->interrupt_count; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->interrupts[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(p->interrupt=
s[i], map.bits);
>
> - =A0 =A0 =A0 flags |=3D irq_flags(p->triggering, p->polarity, p->sha=
rable);
> + =A0 =A0 =A0 flags =3D irq_flags(p->triggering, p->polarity, p->shar=
able);
> =A0 =A0 =A0 =A0pnp_register_irq_resource(dev, option_flags, &map, fla=
gs);
> =A0}
>
> @@ -547,10 +541,7 @@
> =A0{
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0pnp_irq_mask_t map;
> - =A0 =A0 =A0 unsigned char flags =3D 0;
> -
> - =A0 =A0 =A0 if (p->interrupt_count =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> + =A0 =A0 =A0 unsigned char flags;
>
> =A0 =A0 =A0 =A0bitmap_zero(map.bits, PNP_IRQ_NR);
> =A0 =A0 =A0 =A0for (i =3D 0; i < p->interrupt_count; i++) {
> @@ -564,7 +555,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 flags |=3D irq_flags(p->triggering, p->polarity, p->sha=
rable);
> + =A0 =A0 =A0 flags =3D irq_flags(p->triggering, p->polarity, p->shar=
able);
> =A0 =A0 =A0 =A0pnp_register_irq_resource(dev, option_flags, &map, fla=
gs);
> =A0}
>
> @@ -574,11 +565,8 @@
> =A0{
> =A0 =A0 =A0 =A0unsigned char flags =3D 0;
>
> - =A0 =A0 =A0 if (io->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (io->io_decode =3D=3D ACPI_DECODE_16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_IO_16BIT_ADDR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_IO_16BIT_ADDR;
> =A0 =A0 =A0 =A0pnp_register_port_resource(dev, option_flags, io->mini=
mum, io->maximum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
o->alignment, io->address_length, flags);
> =A0}
> @@ -587,13 +575,8 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned int option_flags,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct acpi_resource_fixed_io *io)
> =A0{
> - =A0 =A0 =A0 unsigned char flags =3D 0;
> -
> - =A0 =A0 =A0 if (io->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0pnp_register_port_resource(dev, option_flags, io->addr=
ess, io->address,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0, io->address_length, flags | IORESOURCE_IO_FIXED);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0, io->address_length, IORESOURCE_IO_FIXED);
> =A0}
>
> =A0static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
> @@ -602,11 +585,8 @@
> =A0{
> =A0 =A0 =A0 =A0unsigned char flags =3D 0;
>
> - =A0 =A0 =A0 if (p->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (p->write_protect =3D=3D ACPI_READ_WRITE_MEMORY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM_WRITEABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_MEM_WRITEABLE;
> =A0 =A0 =A0 =A0pnp_register_mem_resource(dev, option_flags, p->minimu=
m, p->maximum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p-=
>alignment, p->address_length, flags);
> =A0}
> @@ -617,11 +597,8 @@
> =A0{
> =A0 =A0 =A0 =A0unsigned char flags =3D 0;
>
> - =A0 =A0 =A0 if (p->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (p->write_protect =3D=3D ACPI_READ_WRITE_MEMORY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM_WRITEABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_MEM_WRITEABLE;
> =A0 =A0 =A0 =A0pnp_register_mem_resource(dev, option_flags, p->minimu=
m, p->maximum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p-=
>alignment, p->address_length, flags);
> =A0}
> @@ -632,11 +609,8 @@
> =A0{
> =A0 =A0 =A0 =A0unsigned char flags =3D 0;
>
> - =A0 =A0 =A0 if (p->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (p->write_protect =3D=3D ACPI_READ_WRITE_MEMORY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_MEM_WRITEABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_MEM_WRITEABLE;
> =A0 =A0 =A0 =A0pnp_register_mem_resource(dev, option_flags, p->addres=
s, p->address,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00,=
 p->address_length, flags);
> =A0}
> @@ -656,19 +630,16 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (p->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (p->resource_type =3D=3D ACPI_MEMORY_RANGE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->info.mem.write_protect =3D=3D A=
CPI_READ_WRITE_MEMORY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_M=
EM_WRITEABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_ME=
M_WRITEABLE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pnp_register_mem_resource(dev, option_=
flags, p->minimum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0p->minimum, 0, p->address_length,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0flags);
> =A0 =A0 =A0 =A0} else if (p->resource_type =3D=3D ACPI_IO_RANGE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pnp_register_port_resource(dev, option=
_flags, p->minimum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 p->minimum, 0, p->address_length,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0flags | IORESOURCE_IO_FIXED);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IORESOURCE_IO_FIXED);
> =A0}
>
> =A0static __init void pnpacpi_parse_ext_address_option(struct pnp_dev=
 *dev,
> @@ -678,19 +649,16 @@
> =A0 =A0 =A0 =A0struct acpi_resource_extended_address64 *p =3D &r->dat=
a.ext_address64;
> =A0 =A0 =A0 =A0unsigned char flags =3D 0;
>
> - =A0 =A0 =A0 if (p->address_length =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_DISABLED;
> -
> =A0 =A0 =A0 =A0if (p->resource_type =3D=3D ACPI_MEMORY_RANGE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->info.mem.write_protect =3D=3D A=
CPI_READ_WRITE_MEMORY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IORESOURCE_M=
EM_WRITEABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D IORESOURCE_ME=
M_WRITEABLE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pnp_register_mem_resource(dev, option_=
flags, p->minimum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0p->minimum, 0, p->address_length,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0flags);
> =A0 =A0 =A0 =A0} else if (p->resource_type =3D=3D ACPI_IO_RANGE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pnp_register_port_resource(dev, option=
_flags, p->minimum,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 p->minimum, 0, p->address_length,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0flags | IORESOURCE_IO_FIXED);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IORESOURCE_IO_FIXED);
> =A0}
>
> =A0struct acpipnp_parse_option_s {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
