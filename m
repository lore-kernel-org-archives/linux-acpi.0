From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH 1/3] hpet: convert to PNP driver
Date: Wed, 17 Mar 2010 15:18:27 -0700
Message-ID: <3055132f1003171518o46c4712bk5089a7bab8574019@mail.gmail.com>
References: <20100317173329.31124.69795.stgit@bob.kio>
	 <20100317173500.31124.53755.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:7011 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0CQWSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2010 18:18:33 -0400
In-Reply-To: <20100317173500.31124.53755.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org

On Wed, Mar 17, 2010 at 10:35 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
>
> PNPACPI already parses _CRS, and does a more complete job than we did=
 here,
> so let's just take advantage of that.
>

Patch looks good.
One comment is that we now have a dependency on CONFIG_PNP. That
probably needs to be added in drivers/char/Kconfig. But, that also
means we may fail for users who do not have PNP in their config today.
May be just select PNP when HPET is selected?

> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>
> =A0drivers/char/hpet.c | =A0103 +++++++++++++------------------------=
--------------
> =A01 files changed, 27 insertions(+), 76 deletions(-)
>
>
>
> - =A0 =A0 =A0 if (!data.hd_address || !data.hd_nirqs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: no address or irqs in _CRS\=
n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 data.hd_address =3D ioremap(mem->start, resource_size(m=
em));
>
> =A0 =A0 =A0 =A0return hpet_alloc(&data);
> =A0}

Not a problem with this patch. But, don't we have a problem of rogue
ioremap when hpet_alloc() fails here?

Thanks,
Venki
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
