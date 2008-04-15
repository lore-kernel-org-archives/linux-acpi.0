From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 03:09:25 -0400
Message-ID: <200804150309.25361.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40562 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYDOHJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 03:09:44 -0400
In-Reply-To: <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

=46rom: Len Brown <len.brown@intel.com>

drivers/acpi/dispatcher/dsobject.c:499: warning: format =E2=80=98%X=E2=80=
=99 expects type =E2=80=98unsigned int=E2=80=99, but argument 4 has typ=
e =E2=80=98acpi_native_uint=E2=80=99
drivers/acpi/dispatcher/dsobject.c:507: warning: format =E2=80=98%X=E2=80=
=99 expects type =E2=80=98unsigned int=E2=80=99, but argument 7 has typ=
e =E2=80=98acpi_native_uint=E2=80=99

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatch=
er/dsobject.c
index 5184278..bdef2f0 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -373,7 +373,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk=
_state *walk_state,
 	union acpi_parse_object *parent;
 	union acpi_operand_object *obj_desc =3D NULL;
 	acpi_status status =3D AE_OK;
-	acpi_native_uint i;
+	u32 i;
 	u16 index;
 	u16 reference_count;
=20
--=20
1.5.5.49.gf43e2

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
