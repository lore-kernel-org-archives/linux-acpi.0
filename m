From: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] Enable EHCI-platform driver for use with ACPI
Date: Wed, 12 Aug 2015 16:51:27 -0500
Message-ID: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch set enables the USB on the ARM Juno development platform
when using an ACPI kernel. This patch is in two primary parts. First
It tweaks the code in acpi_check_dma() to support the recently added
CCA attribute which describes a device which is not cache coherent.

It then adds an error message if the device cannot be configured with
the current DMA settings, finally it adds the ACPI PNP id to the
acpi_match_table entry.

Jeremy Linton (3):
  Honor ACPI _CCA attribute setting
  Display a DMA error message
  Add ACPI bindings for the EHCI platform driver.

 drivers/usb/host/ehci-platform.c | 13 ++++++++++++-
 include/acpi/acpi_bus.h          |  5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

--=20
2.4.3


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
