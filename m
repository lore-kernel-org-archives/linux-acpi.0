Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C461F151C;
	Fri, 13 Mar 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407056; cv=none; b=UblKaFm2jqq956stEJ01IiB4Hl9ctJ6tmJHuoU4d6O9ldibEdCUXnDMFNFUfkr3WYQnX4ExyLL5ldZRTHip4Zwxv5sxQzwUw2jbK2LfiGWhjr1oBG4e1Z2a+UtCRegFGqRcIHhlpNc+inlklkP7i3NznIEEqA4MO8i/K7I8XcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407056; c=relaxed/simple;
	bh=c9J3HT2/8QuaJhSUGByPNlpOdRCdUnaEc3qxTuozTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7af4IeHQ0JzQYZgzQBxC0FegeFxOrq3193TKTid8C1FuKTazj8s08Cd+J/hcXAqAq++BkN4iUyU2b1xEbQU569ophCa5HfrVo3NfEKpzt3FDtIn9OAFDCrcMvWwL5Dk6Mwz1gDZ0EH92NHrvvUCTndenAB24nKxUeTqhflaY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEOkn5Y6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEOkn5Y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98645C19421;
	Fri, 13 Mar 2026 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407056;
	bh=c9J3HT2/8QuaJhSUGByPNlpOdRCdUnaEc3qxTuozTFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEOkn5Y643C66PAX3kZOhRcr+bqvjqBEF/sF9zAOY1+EdOTjhC9btCHOtReUnZ8RD
	 GM6QuZ2nwfR/lttr7fCKjdVfSDq2LwZAohFGMsVxNtziiDWHxO+fzbwtTBpzinoUkz
	 lQRV+RSr/KZfUUMs23z7oS7CaeZyZTvRCkTaIuT7TYFZbw3fLH3FBQY6TGJW3dwYpx
	 2wQ/fhTAODN04+MJboWcjQ4T2GIseEY2V72pNZV0jNxQNC03edPvewFXwRMWb70Pmi
	 lifo/MrzaTlv/DiuiYJIxEjKcJPJoJcG8nFxmDBU3bBVdQdJacj0jUxH2sm1RaWw+l
	 tFlKPxW9Poc2A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 8/8] ACPI: AC: Define ACPI_AC_CLASS in one place
Date: Fri, 13 Mar 2026 14:03:46 +0100
Message-ID: <6163384.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_AC_CLASS symbol is defined in several places in the same way
which is rather unfortunate.

Instead, define it in one common header file (acpi_bus.h) so that it is
accessible to all of its users.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
=2D--

v1 -> v2:
   * Rephrase the second paragraph in the changelog (Ilpo)
   * Add R-by from Ilpo

=2D--
 drivers/acpi/ac.c                         |    1 -
 drivers/acpi/sbs.c                        |    1 -
 drivers/gpu/drm/amd/include/amd_acpi.h    |    2 --
 drivers/gpu/drm/radeon/radeon_acpi.c      |    2 --
 drivers/platform/x86/hp/hp-wmi.c          |    2 --
 drivers/platform/x86/lenovo/wmi-capdata.c |    1 -
 include/acpi/acpi_bus.h                   |    2 ++
 7 files changed, 2 insertions(+), 9 deletions(-)

=2D-- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -21,7 +21,6 @@
 #include <linux/acpi.h>
 #include <acpi/battery.h>
=20
=2D#define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_AC_FILE_STATE		"state"
 #define ACPI_AC_NOTIFY_STATUS		0x80
 #define ACPI_AC_STATUS_OFFLINE		0x00
=2D-- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -26,7 +26,6 @@
=20
 #include "sbshc.h"
=20
=2D#define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_BATTERY_DIR_NAME		"BAT%i"
 #define ACPI_AC_DIR_NAME		"AC0"
=2D-- a/drivers/gpu/drm/amd/include/amd_acpi.h
+++ b/drivers/gpu/drm/amd/include/amd_acpi.h
@@ -26,8 +26,6 @@
=20
 #include <linux/types.h>
=20
=2D#define ACPI_AC_CLASS           "ac_adapter"
=2D
 struct atif_verify_interface {
 	u16 size;		/* structure size in bytes (includes size field) */
 	u16 version;		/* version */
=2D-- a/drivers/gpu/drm/radeon/radeon_acpi.c
+++ b/drivers/gpu/drm/radeon/radeon_acpi.c
@@ -44,8 +44,6 @@ bool radeon_atpx_dgpu_req_power_for_disp
 static inline bool radeon_atpx_dgpu_req_power_for_displays(void) { return =
false; }
 #endif
=20
=2D#define ACPI_AC_CLASS           "ac_adapter"
=2D
 struct atif_verify_interface {
 	u16 size;		/* structure size in bytes (includes size field) */
 	u16 version;		/* version */
=2D-- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -58,8 +58,6 @@ enum hp_ec_offsets {
 #define HP_POWER_LIMIT_DEFAULT	 0x00
 #define HP_POWER_LIMIT_NO_CHANGE 0xFF
=20
=2D#define ACPI_AC_CLASS "ac_adapter"
=2D
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when z=
ero insize is required
=20
 enum hp_thermal_profile_omen_v0 {
=2D-- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -53,7 +53,6 @@
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE0181=
54"
 #define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB21"
=20
=2D#define ACPI_AC_CLASS "ac_adapter"
 #define ACPI_AC_NOTIFY_STATUS 0x80
=20
 #define LWMI_FEATURE_ID_FAN_TEST 0x05
=2D-- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -613,6 +613,8 @@ struct acpi_bus_event {
 	u32 data;
 };
=20
+#define ACPI_AC_CLASS	"ac_adapter"
+
 extern struct kobject *acpi_kobj;
 extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, i=
nt);
 void acpi_bus_private_data_handler(acpi_handle, void *);



