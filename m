From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] Expose OSI version
Date: Tue, 02 Jul 2013 21:56:45 +0800
Message-ID: <51D2DC1D.60101@intel.com>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com> <1371508629.523.3.camel@x230> <10189900.qsvQBSpnvI@vostro.rjw.lan> <2211483.MscZsfrrDc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23072 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3GBN4Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jul 2013 09:56:16 -0400
In-Reply-To: <2211483.MscZsfrrDc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "lenb@kernel.org" <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>

This is a re-spin of patch 2/3:
ACPICA: Add interface for getting latest OS version requested via _OSI
to address the comments suggested by Bob and Rafael.

To be exact, the patchset does:
1 Expose acpi_gbl_osi_data through include/acpi/acpixf.h and move all
  OSI definitions to include/acpi/actypes.h in patch 1;
2 Add a wrapper function acpi_osi_version in osl.c to return
  acpi_gbl_osi_data in patch 2.

Matthew,
I suppose you might be busy so I've done the re-spin for you,
please let me know if you think something wrong, thanks.

Aaron Lu (2):
  ACPICA: expose OSI version
  ACPI / OSL: add a wrapper function to return OSI version

 drivers/acpi/acpica/aclocal.h | 13 -------------
 drivers/acpi/osl.c            |  6 ++++++
 include/acpi/acpixf.h         |  1 +
 include/acpi/actypes.h        | 15 +++++++++++++++
 include/linux/acpi.h          |  6 ++++++
 5 files changed, 28 insertions(+), 13 deletions(-)

-- 
1.8.3.2.10.g43d11f4
