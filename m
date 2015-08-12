From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/3] Honor ACPI _CCA attribute setting
Date: Wed, 12 Aug 2015 16:51:28 -0500
Message-ID: <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:62290 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751611AbbHLVwJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Aug 2015 17:52:09 -0400
In-Reply-To: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, linux@prisktech.co.nz, suravee.suthikulpanit@amd.com, rafael.j.wysocki@intel.com, Catalin.Marinas@arm.com, Jeremy Linton <jeremy.linton@arm.com>

ACPI configurations can now mark devices as noncoherent,
support that choice.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/acpi_bus.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061ca..7ecb8e4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -399,7 +399,7 @@ static inline bool acpi_check_dma(struct acpi_device *a=
dev, bool *coherent)
 =09 * case 1. Do not support and disable DMA.
 =09 * case 2. Support but rely on arch-specific cache maintenance for
 =09 *         non-coherence DMA operations.
-=09 * Currently, we implement case 1 above.
+=09 * Currently, we implement case 2 above.
 =09 *
 =09 * For the case when _CCA is missing (i.e. cca_seen=3D0) and
 =09 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
@@ -407,7 +407,8 @@ static inline bool acpi_check_dma(struct acpi_device *a=
dev, bool *coherent)
 =09 *
 =09 * See acpi_init_coherency() for more info.
 =09 */
-=09if (adev->flags.coherent_dma) {
+=09if (adev->flags.coherent_dma ||
+=09    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
 =09=09ret =3D true;
 =09=09if (coherent)
 =09=09=09*coherent =3D adev->flags.coherent_dma;
--=20
2.4.3


