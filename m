From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [bug] endless loop in arch/i386/kernel/mpparse.c
Date: Sun, 29 Sep 2002 23:35:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020929233532.H18377@parcelfarce.linux.theplanet.co.uk>
References: <Pine.BSF.4.44.0209292102340.427-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.44.0209292102340.427-100000-pDROZl1FiGxrJICXbmAK0A3q8rc3x57SrE5yTffgRl4@public.gmane.org>; from bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org on Sun, Sep 29, 2002 at 09:27:41PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Cc: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 29, 2002 at 09:27:41PM +0200, Bjoern A. Zeeb wrote:
>  void __init mp_config_ioapic_for_sci(int irq)
>  {
>         int ioapic;
>         int ioapic_pin;
> +       struct acpi_table_madt *madt;
> +       struct acpi_table_int_src_ovr *entry = NULL;
> +       void *madt_end;
> +       acpi_status status;
> +
> +       /*
> +        * Ensure that if there is an interrupt source override entry
> +        * for the ACPI SCI, we leave it as is. Unfortunately this involves
> +        * walking the MADT again.
> +        */
> +       status = acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,
> +               (acpi_table_header **) &madt);
> +       if (ACPI_SUCCESS(status)) {
> +               madt_end = madt + madt->header.length;
> +
> +               entry = (struct acpi_table_int_src_ovr *)
> +                ((unsigned long) madt + sizeof(struct acpi_table_madt));
> +
> +               while ((void *) entry < madt_end) {
> 			printk("[%s:%s:%d] madt_end=%p, entry=%p\n",
> 				__FILE__, __func__, __LINE__, madt_end, entry);
> +                       if (entry->header.type == ACPI_MADT_INT_SRC_OVR &&
> +                           acpi_fadt.sci_int == entry->global_irq)
> +                               return;
> +
> +                       entry = (struct acpi_table_int_src_ovr *)
> +                               ((unsigned long) entry + entry->header.length);
> +               }
> +       }
> 
>         ioapic = mp_find_ioapic(irq);

If entry->header.length is zero without entry being equal to madt_end,
this will loop for ever.  Maybe:

[...]
			if (entry->header.length <= 0)
				break;
			entry = (struct acpi_table_int_src_ovr *)
				((unsigned long) entry + entry->header.length);
		}

is the right solution?

> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070dc
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070e4
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070ec
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070f8
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d8807102
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
> [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c

You can see that entry->header.length must be 0 at this point.  Probably a
buggy MADT, but let's not _crash_ when the vendor provides a shit BIOS.

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
