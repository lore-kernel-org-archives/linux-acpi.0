From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 0/7] ACPI video: cleanups and fixes for the recent
	buggy _BQC/_BCL/_BCM BIOSes
Date: Thu, 12 Mar 2009 16:56:56 +0800
Message-ID: <1236848216.2807.69.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38689 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZCLIz7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 04:55:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

=EF=BB=BFHi, all,

here is the patch set I made recently, including some cleanups and fixe=
s
for the Thinkpad/Asus laptops with buggy _BQC/_BCL/_BCM implementation.

The first two patches checks if ACPI video driver fails to set/get the
current brightness level, which is not done before.

patch 3/4/5/6 are used to fix four different problems.

1. the brightness levels when machine is on AC/Battery are not exported
   by _BCL.
2. The supported brightness levels are reversed in the _BCL method.
3. Index values are used in _BQC/_BCL/_BCM method.
4. _BCQ method is implemented instead of _BQC

patch 7 add a warning message when _BQC is not implemented.

Any comments are welcome.

thanks,
rui
  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
