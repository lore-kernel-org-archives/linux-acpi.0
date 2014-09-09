From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 0/2] Reverting ACPI / battery: fix wrong value of capacity_now reported when fully charged
Date: Tue,  9 Sep 2014 10:45:16 +0200
Message-ID: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:43809 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756126AbaIIIq4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 04:46:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mariusz Ceier <mceier+kernel@gmail.com>, Josef Gajdusek <atx@atx.name>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>

This firmware workaround has unwanted side effects causing wrong
capacity reports from previously working firmwares.  It should
be reerted and redone in a non-intrusive manner.

I see that one of the bugs it added alread has been fixed.  But
the fix still leaves the original workaround design flaw in place,
and I therefore propose reverting both patches.  I've marked both
patches for stable, because the fix was marked for stable.  Those
should ideally cancel each others out and only the revert of the
initial buggy patch should really go to stable.

Thanks.

Bj=C3=B8rn Mork (2):
  Revert "ACPI / battery: Fix warning message in
    acpi_battery_get_state()"
  Revert "ACPI / battery: fix wrong value of capacity_now reported when
    fully charged"

 drivers/acpi/battery.c | 14 --------------
 1 file changed, 14 deletions(-)

--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
