From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 0/6] thermal: improvements re. forced passive cooling
Date: Fri, 11 Sep 2009 08:08:55 +0200
Message-ID: <200909110808.57494.elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:64199 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920AbZIKGIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Sep 2009 02:08:55 -0400
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>

Hello Len,

Please consider this patch set [1] for 2.6.32.

All patches have now been acked by either Rui or Matthew, with the 
exception of:

1/6 thermal: sysfs-api.txt - reformat for improved readability
This is a trivial documentation patch.

4/6 thermal: add sanity check for the passive attribute
There was some discussion on this, but I feel that my version 2 of the 
patch is a reasonable compromise, in that it prevents obviously useless 
values (below 1C), but does not set an arbitrary lower limit. If you feel 
it needs more discussion, it could be dropped from the series for now.

If you'd like me to post the series again, then please let me know.

Thanks,
FJP

[1] http://www.spinics.net/lists/linux-acpi/msg24104.html
