From: Miguel =?utf-8?q?Bot=C3=B3n?= <mboton.lkml@gmail.com>
Subject: [PATCH] acpi: remove duplicated warning message
Date: Sat, 1 Dec 2007 16:42:51 +0100
Message-ID: <200712011642.52165.mboton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753495AbXLAPnI@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Remove duplicated warning message in acpi_power_transition()

This warning message is printed by acpi_bus_set_power() so we don't
need to print it again.

Signed-off-by: Miguel Bot=C3=B3n <mboton@gmail.com>

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index af1769a..b4af974 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -458,11 +458,9 @@ int acpi_power_transition(struct acpi_device *devi=
ce, int state)
 	}
=20
      end:
-	if (result) {
+	if (result)=20
 		device->power.state =3D ACPI_STATE_UNKNOWN;
-		printk(KERN_WARNING PREFIX "Transitioning device [%s] to D%d\n",
-			      device->pnp.bus_id, state);
-	} else {
+	else {
 	/* We shouldn't change the state till all above operations succeed */
 		device->power.state =3D state;
 	}


--=20
	Miguel Bot=C3=B3n
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
