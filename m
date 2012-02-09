From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Fix logic for removing mappings in 'acpi_unmap'
Date: Thu, 9 Feb 2012 08:42:59 -0800
Message-ID: <CAErSpo47+kHmS6477Bne84rPiy+sHGjgtK3mpk6VJc+hM4hhbg@mail.gmail.com>
References: <20120209163641.26858.59399.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120209163641.26858.59399.stgit@amt.stowe>
Sender: linux-kernel-owner@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com, tony.luck@intel.com, trenn@suse.de, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 9, 2012 at 8:36 AM, Myron Stowe <myron.stowe@redhat.com> wr=
ote:
> From: Myron Stowe <mstowe@redhat.com>
>
> Make sure the removal of mappings uses the same logic that put the
> mappings in place.
>
> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
> ---
>
> =A0drivers/acpi/osl.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 412a1e0..5aef087 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -347,7 +347,7 @@ static void acpi_unmap(acpi_physical_address pg_o=
ff, void __iomem *vaddr)
> =A0 =A0 =A0 =A0unsigned long pfn;
>
> =A0 =A0 =A0 =A0pfn =3D pg_off >> PAGE_SHIFT;
> - =A0 =A0 =A0 if (page_is_ram(pfn))
> + =A0 =A0 =A0 if (should_use_kmap(pfn))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kunmap(pfn_to_page(pfn));
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(vaddr);
>

Whatever happened to the question of why we have arch-specific
ioremap() behavior?  It's good to make map/unmap symmetric, but it'd
be better to get rid of the ioremap/kmap hack.

Bjorn
