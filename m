From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI suspend: Fox compilation for ACPI_SLEEP unset and XEN_SAVE_RESTORE set
Date: Thu, 23 Oct 2008 21:46:43 +0200
Message-ID: <200810232146.44394.rjw@sisk.pl>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org> <b849075c0e08ea43400c1341c78eeca76ab08d8a.1224743917.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40698 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYJWTmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 15:42:25 -0400
In-Reply-To: <b849075c0e08ea43400c1341c78eeca76ab08d8a.1224743917.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>

On Thursday, 23 of October 2008, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> drivers/acpi/sleep/main.c:27: warning: =E2=80=98acpi_target_sleep_sta=
te=E2=80=99 defined but not used

Er, wrong.

This breaks compilation for ACPI_SLEEP=3Dn and XEN_SAVE_RESTORE=3Dy.

The patch below fixes the breakage.

> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/sleep/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index 7603788..26571ba 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -24,7 +24,6 @@
>  #include "sleep.h"
> =20
>  u8 sleep_states[ACPI_S_STATE_COUNT];
> -static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
> =20
>  static void acpi_sleep_tts_switch(u32 acpi_state)
>  {
> @@ -78,6 +77,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  }
> =20
>  #ifdef CONFIG_ACPI_SLEEP
> +static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
>  /*
>   * ACPI 1.0 wants us to execute _PTS before suspending devices, so w=
e allow the
>   * user to request that behavior by using the 'acpi_old_suspend_orde=
ring'

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>

ACPI suspend: Fox compilation for ACPI_SLEEP unset and XEN_SAVE_RESTORE=
 set

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/acpi/sleep/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -163,6 +163,8 @@ static void acpi_pm_end(void)
 	acpi_target_sleep_state =3D ACPI_STATE_S0;
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
+#else /* !CONFIG_ACPI_SLEEP */
+#define acpi_target_sleep_state	ACPI_STATE_S0
 #endif /* CONFIG_ACPI_SLEEP */
=20
 #ifdef CONFIG_SUSPEND
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
