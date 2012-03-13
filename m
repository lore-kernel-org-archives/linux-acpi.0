From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 02/37] PNPACPI: Fix device ref leaking in acpi_pnp_match
Date: Mon, 12 Mar 2012 20:40:53 -0600
Message-ID: <CAErSpo5jCx5MdMOWgNQ+KVbn-6XDJSVvoO35J2DnpSMJyU-a4Q@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331362837-10740-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, Len Brown <lenb@kernel.org>, Adam Belay <abelay@mit.edu>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> During testing pci root bus removal, found some root bus bridge is no=
t freed.
>
> If booting with pnpacpi=3Doff, those hostbridge could be freed withou=
t problem.
>
> It turns out that some devices reference are not released during acpi=
_pnp_match.
>
> That match should not hold one device ref during every calling.
>
> Add put_device calling before returning.

Changelog doesn't fit in 80 columns when using "git log".  I mentioned
this before; please try it yourself.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@kernel.org
> Cc: Len Brown <lenb@kernel.org>
> Cc: Adam Belay <abelay@mit.edu>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/pnp/pnpacpi/core.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index b00c176..d21e8f5 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -321,9 +321,14 @@ static int __init acpi_pnp_match(struct device *=
dev, void *_pnp)
> =A0{
> =A0 =A0 =A0 =A0struct acpi_device *acpi =3D to_acpi_device(dev);
> =A0 =A0 =A0 =A0struct pnp_dev *pnp =3D _pnp;
> + =A0 =A0 =A0 struct device *physical_device;
> +
> + =A0 =A0 =A0 physical_device =3D acpi_get_physical_device(acpi->hand=
le);
> + =A0 =A0 =A0 if (physical_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_device(physical_device);
>
> =A0 =A0 =A0 =A0/* true means it matched */
> - =A0 =A0 =A0 return !acpi_get_physical_device(acpi->handle)
> + =A0 =A0 =A0 return !physical_device
> =A0 =A0 =A0 =A0 =A0 =A0&& compare_pnp_id(pnp->id, acpi_device_hid(acp=
i));
> =A0}
>
> --
> 1.7.7
>
