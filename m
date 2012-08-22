From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 1/2] ACPI: Use ACPICA native way to decode the PLD
 buffer
Date: Wed, 22 Aug 2012 15:16:18 +0800
Message-ID: <20120822151618.1625d9c7@feng-i7>
References: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
	<503484C2.8070106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36243 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2HVHVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Aug 2012 03:21:48 -0400
In-Reply-To: <503484C2.8070106@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, mjg@redhat.com, gregkh@linuxfoundation.org, Bob Moore <robert.moore@intel.com>

Hi Tianyu,


On Wed, 22 Aug 2012 15:05:38 +0800
Lan Tianyu <tianyu.lan@intel.com> wrote:

> On 2012=E5=B9=B408=E6=9C=8822=E6=97=A5 14:24, Feng Tang wrote:
> > This patch is on top of the ACPICA 20120816 release, which implemen=
ted
> > a native way to decode PLD buffer, so use it instead of leting uppe=
r
> > level users do the decoding.
> >=20
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > ---
> >  drivers/acpi/utils.c    |   11 +++++++----
> >  include/acpi/acpi_bus.h |   31 +------------------------------
> >  2 files changed, 8 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 3e87c9c..e697bf2 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -384,7 +384,7 @@ acpi_evaluate_reference(acpi_handle handle,
> >  EXPORT_SYMBOL(acpi_evaluate_reference);
> > =20
> >  acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_=
pld *pld)
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_=
pld_info **pld)
> Sorry. I have not found the definition of struct acpi_pld_info or is
> there something I have missed?

The definition is in the ACPICA 20120816 patch sets I just posted to li=
nux-acpi list.
Let me copy it here

+
+/*
+ * Note: C bitfields are not used for this reason:
+ *
+ * "Bitfields are great and easy to read, but unfortunately the C lang=
uage
+ * does not specify the layout of bitfields in memory, which means the=
y are
+ * essentially useless for dealing with packed data in on-disk formats=
 or
+ * binary wire protocols." (Or ACPI tables and buffers.) "If you ask m=
e,
+ * this decision was a design error in C. Ritchie could have picked an=
 order
+ * and stuck with it." Norman Ramsey.
+ * See http://stackoverflow.com/a/1053662/41661
+ */
+
+/*
+ * Formatted _PLD return value. The minimum size is a package containi=
ng
+ * one buffer.
+ * Revision 1: Buffer is 16 bytes (128 bits)
+ * Revision 2: Buffer is 20 bytes (160 bits)
+ *
+ * Note: This structure is returned from the acpi_decode_pld_buffer
+ * interface.
+ */
+struct acpi_pld_info {
+	u8 revision;
+	u8 ignore_color;
+	u32 color;
+	u16 width;
+	u16 height;
+	u8 user_visible;
+	u8 dock;
+	u8 lid;
+	u8 panel;
+	u8 vertical_position;
+	u8 horizontal_position;
+	u8 shape;
+	u8 group_orientation;
+	u8 group_token;
+	u8 group_position;
+	u8 bay;
+	u8 ejectable;
+	u8 ospm_eject_required;
+	u8 cabinet_number;
+	u8 card_cage_number;
+	u8 reference;
+	u8 rotation;
+	u8 order;
+	u8 reserved;
+	u16 vertical_offset;
+	u16 horizontal_offset;
+};
+
+/*
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
