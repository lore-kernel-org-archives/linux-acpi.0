From: Dave Lambley <linux@davel.me.uk>
Subject: [PATCH v2] Lenovo Yoga 300 battery support
Date: Wed,  2 Nov 2016 18:37:26 +0000
Message-ID: <1478111847-14653-1-git-send-email-linux@davel.me.uk>
References: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.the-lambleys.org.uk ([212.47.234.164]:46826 "EHLO
        smtp.the-lambleys.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756572AbcKBSqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2016 14:46:03 -0400
In-Reply-To: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Lambley <linux@davel.me.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

This patch allows Linux to detect the battery in the Lenovo Yoga 300
laptop. It does this by tolerating a bug in the firmware which breaks the
_BIX method but not _BIF. Without this patch, the battery is not presented
to userland.

On a system with non-buggy firmware, the behaviour should be unchanged.

With the patch, something like this gets logged,

[ 3004.858993] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x000000010) is beyond end of object (length 0xD) (20160831/exoparg2-427)
[ 3004.859015] ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.H_EC.BAT1._BIX] (Node ffff955bbb0b32d0), AE_AML_PACKAGE_LIMIT (20160831/psparse-543)
[ 3004.859038] ACPI Exception: AE_AML_PACKAGE_LIMIT, Evaluating _BIX (20160831/battery-493)
[ 3004.873413] [Firmware Bug]: The _BIX method is broken, using _BIF.

v1 -> v2
	- Log when falling back to _BIF method.
	- Rebased against v4.9-rc2.

Signed-off-by: Dave Lambley <linux@davel.me.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>

Dave Lambley (1):
  If _BIX fails, retry with _BIF.

 drivers/acpi/battery.c | 72 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 24 deletions(-)

-- 
2.7.4

