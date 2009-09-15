From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH] ACPI: make ACPI button funcs no-ops if not built in
Date: Tue, 15 Sep 2009 16:57:24 -0700
Message-ID: <20090915165724.4e4a1229@jbarnes-g45>
References: <1252621686-27307-1-git-send-email-jbarnes@virtuousgeek.org>
	<1252621686-27307-2-git-send-email-jbarnes@virtuousgeek.org>
	<1252630922.3609.200.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-23.bluehost.com ([69.89.21.18]:52523 "HELO
	outbound-mail-23.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751530AbZIPAEF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Sep 2009 20:04:05 -0400
In-Reply-To: <1252630922.3609.200.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org, eric@anholt.net

On Fri, 11 Sep 2009 09:02:02 +0800
ykzhao <yakui.zhao@intel.com> wrote:
> > +#ifndef ACPI_BUTTON_H
> > +#define ACPI_BUTTON_H
> It will be better that the function prototype is defined in the
> following:
>=20
> #if (defined(CONFIG_ACPI_BUTTON) ||
> defined(CONFIG_ACPI_BUTTON_MODULE)) extern =EF=BB=BFint
> acpi_lid_notifier_register(struct notifier_block *nb); extern int
> acpi_lid_notifier_unregister(struct notifier_block *nb); extern int
> acpi_lid_open(void); #else
> static inline int acpi_lid_notifier_register( ...)  { return 0;}
> static inline int acpi_lid_notifier_unregister(struct notifier_block
> *nb) { return 0; }
> static inline int acpi_lid_open(void) { return 1; }
> #endif

Here you go.

--=20
Jesse Barnes, Intel Open Source Technology Center

Yakui pointed out that we don't properly no-op the ACPI button routines
if the button driver isn't built in.  This will cause problems if ACPI
is disabled, so provide stub functions in that case.

Reported-by: ykzhao <yakui.zhao@intel.com>
Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

diff --git a/include/acpi/button.h b/include/acpi/button.h
index bb643a7..97eea0e 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -3,8 +3,23 @@
=20
 #include <linux/notifier.h>
=20
+#if defined(CONFIG_ACPI_BUTTON) || defined(CONFIG_ACPI_BUTTON_MODULE)
 extern int acpi_lid_notifier_register(struct notifier_block *nb);
 extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
 extern int acpi_lid_open(void);
+#else
+static inline int acpi_lid_notifier_register(struct notifier_block *nb=
)
+{
+	return 0;
+}
+static inline int acpi_lid_notifier_unregister(struct notifier_block *=
nb)
+{
+	return 0;
+}
+static inline int acpi_lid_open(void)
+{
+	return 1;
+}
+#endif /* defined(CONFIG_ACPI_BUTTON) || defined(CONFIG_ACPI_BUTTON_MO=
DULE) */
=20
 #endif /* ACPI_BUTTON_H */
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
