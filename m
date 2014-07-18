From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] acpi-video: Fix backlight taking 2 steps on a brightness keypress
Date: Fri, 18 Jul 2014 14:32:50 +0200
Message-ID: <1405686771-15483-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762099AbaGRMdI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2014 08:33:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: linux-acpi@vger.kernel.org

Hi All,

Here is v2 of my cleaned up version of Linus' patch to fix this. New th=
is
version is that the module option is left as a boolean, and the keypres=
ses
handling simply always gets delayed 100 ms.

Bj=C3=B8rn, can you please re-test to make sure I've not accidentally b=
roken
anything ? Note this still applies on top of the revert.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
