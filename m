From: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [2.6.37] Debugging shutdown issues
Date: Tue, 11 Jan 2011 13:50:08 +0200
Message-ID: <201101111350.08448.ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:60725 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab1AKLzZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2011 06:55:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Hi,

I have many reports regarding shutdown hangs and reboots-instead-of-shu=
tdown for 2.6.37 but I
don't really know how to help them in debugging. All they see and say i=
s that the computer
is not powered off instead stays at terminal.

The reboots-instead-of-shutdown bug seems to hit some Sony Vaio and Del=
l notebooks. There are
similar bug reports and forum entries mentioning about the same problem=
 but none of them contains
valuable information.

Any hint/help/clue will be appreciated
Thanks,

---
Ozan =C3=87a=C4=9Flayan
TUBITAK/UEKAE - Pardus Linux
http://www.pardus.org.tr/eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
