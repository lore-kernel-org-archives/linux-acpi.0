From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 29/37] PCI, ACPI: Add acpi_pci_root_rescan()
Date: Mon, 12 Mar 2012 21:33:05 -0600
Message-ID: <CAErSpo6ow9Lt3p0=Q4dau3AB=+YDMGo-dG0hSqFERPKnzPWXnw@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-30-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57232 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab2CMDd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2012 23:33:26 -0400
Received: by lbbgm6 with SMTP id gm6so39324lbb.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Mar 2012 20:33:25 -0700 (PDT)
In-Reply-To: <1331362837-10740-30-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> It will rescan all acpi pci root if related pci root bus get removed =
before.

I think this is a bad idea.  The ACPI core already walks the entire
ACPI namespace, finding devices and binding drivers to them.

Walking the whole thing again looking for "hotplug" things we can do
is just a hack.  Maybe you want it for debugging, but I don't want it
in Linux.

> Signed-off-by: Yinghai <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/pci_root_hp.c | =A0 17 +++++++++++++++++
> =A0include/linux/pci-acpi.h =A0 | =A0 =A07 +++++++
> =A02 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
> index b453181..ca73d51 100644
> --- a/drivers/acpi/pci_root_hp.c
> +++ b/drivers/acpi/pci_root_hp.c
> @@ -268,3 +268,20 @@ static int __init acpi_pci_root_hp_init(void)
> =A0}
>
> =A0subsys_initcall(acpi_pci_root_hp_init);
> +
> +static acpi_status
> +rescan_root_bridge(acpi_handle handle, u32 lvl, void *context, void =
**rv)
> +{
> + =A0 =A0 =A0 if (!acpi_is_root_bridge(handle))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;
> +
> + =A0 =A0 =A0 handle_root_bridge_insertion(handle);
> +
> + =A0 =A0 =A0 return AE_OK;
> +}
> +
> +void acpi_pci_root_rescan(void)
> +{
> + =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_UINT32_MAX, rescan_root_bridge, NU=
LL, NULL, NULL);
> +}
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 4462350..ac93634 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -35,6 +35,13 @@ static inline acpi_handle acpi_pci_get_bridge_hand=
le(struct pci_bus *pbus)
> =A0 =A0 =A0 =A0return acpi_get_pci_rootbridge_handle(pci_domain_nr(pb=
us),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0pbus->number);
> =A0}
> +
> +void acpi_pci_root_rescan(void);
> +
> +#else
> +
> +static inline void acpi_pci_root_rescan(void) { }
> +
> =A0#endif
>
> =A0#ifdef CONFIG_ACPI_APEI
> --
> 1.7.7
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
