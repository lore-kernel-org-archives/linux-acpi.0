From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
Date: Wed, 4 Jan 2006 23:48:04 -0500
Message-ID: <200601042348.05216.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On my D875PBZ i386 box running the latest ACPI patch, PNPACPI is bombing
out with these:

pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
<repeat for a total of 13 devices>.
pnp: PnP ACPI: found 0 devices

instead of
pnp: PnP ACPI: found 13 devices

These are coming from pnpacpi_allocated_resource(),
which except for the type 7's, seems to get exactly
the same sequence of resource types as the successful
stock 2.6.15 build.

Anybody else seeting this?
Not immediately clear why I see it here and didn't see them on my primary test box.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
