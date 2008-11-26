From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/8] acpi: restructure includes into public/private
Date: Wed, 26 Nov 2008 10:52:34 +0800
Message-ID: <1227667954.7702.85.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53880 "EHLO mga02.intel.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752696AbYKZC54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 21:57:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

"include/acpi/acpi.h" now includes only the "public" acpica headers.
All other acpica headers are "private" and should not be included by ac=
pica users.
=46uture plans are to move all private headers to a new subdirectory.

You can not build these patches now, =EF=BB=BFbut send out for review.

Thanks,
Lin Ming


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
