From: Len Brown <lenb@kernel.org>
Subject: [PATCH 87/98] Fix state reporting in tc1100-wmi
Date: Sat, 28 Mar 2009 00:32:02 -0400
Message-ID: <1a8522f6537bc71153d2d19fdf238d4ff7fba17e.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38349 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbZC1Edr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7001GB8O93A9D@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:46 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?Krzysztof=20Kosi=C5=84ski?= <tweenk.pl@gmail.com>, Len Brown <len.brown@intel.com>

=46rom: Krzysztof Kosi=C5=84ski <tweenk.pl@gmail.com>

The tc1100-wmi driver should print the current states of wireless LAN a=
nd
jogdial brightness control when "cat /sys/devices/platform/tc1100-wmi/w=
ireless"
and "cat /sys/devices/platform/tc1100-wmi/jogdial" are executed, respec=
tively.
What actually happens is that both of those commands print 0 regardless=
 of the
hardware state. The cause is that wmi_query_block returns an ACPI_TYPE_=
INTEGER
rather than ACPI_TYPE_BUFFER as the driver assumes. Additionally, the d=
river
intends to return a jogdial state that is inverted with respect to the =
commands
required to set it (e.g. it intends to return 1 after the jogdial file =
was
written with 0).

This patch fixes both of those issues - the commands to query the
state now work, and should return the same state that was written.

http://bugzilla.kernel.org/show_bug.cgi?id=3D12286

Signed-off-by: Krzysztof Kosi=C5=84ski <tweenk.pl@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/tc1100-wmi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/t=
c1100-wmi.c
index b4a4aa9..4416600 100644
--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -94,9 +94,8 @@ static int get_state(u32 *out, u8 instance)
 		return -ENODEV;
=20
 	obj =3D (union acpi_object *) result.pointer;
-	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER &&
-		obj->buffer.length =3D=3D sizeof(u32)) {
-		tmp =3D *((u32 *) obj->buffer.pointer);
+	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
+		tmp =3D obj->integer.value;
 	} else {
 		tmp =3D 0;
 	}
@@ -109,7 +108,7 @@ static int get_state(u32 *out, u8 instance)
 		*out =3D (tmp =3D=3D 3) ? 1 : 0;
 		return 0;
 	case TC1100_INSTANCE_JOGDIAL:
-		*out =3D (tmp =3D=3D 1) ? 1 : 0;
+		*out =3D (tmp =3D=3D 1) ? 0 : 1;
 		return 0;
 	default:
 		return -ENODEV;
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
