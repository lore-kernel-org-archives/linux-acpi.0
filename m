From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: unmet direct dependencies (ACPI && EXPERIMENTAL)
Date: Tue, 28 Dec 2010 15:53:16 +0100
Message-ID: <201012281553.16922.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:44767 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752188Ab0L1OxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Dec 2010 09:53:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

a "make randconfig 1>/dev/null" gave today :

warning: (ACPI_HOTPLUG_CPU && ACPI && ACPI_PROCESSOR && HOTPLUG_CPU) se=
lects=20
ACPI_CONTAINER which has unmet direct dependencies (ACPI && EXPERIMENTA=
L)

for the current git kernel sources.
Is this an already known issue ?

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
