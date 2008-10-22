From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] Hibernate: Handle ACPI NVS memory as required by the spec
Date: Wed, 22 Oct 2008 22:49:20 +0200
Message-ID: <200810222249.20629.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33976 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbYJVUut (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 16:50:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@elte.hu>

Hi,

I have recently tried to rebase the Zhang Rui's patches making the Linux
hibernation code handle the ACPI NVS memory as required by the spec, but
I found that they didn't work on x86_64 boxes where the NVS region was located
behind the last usable PFN.  Also, I decided to put the memory management part
into the hibernation core rather than into drivers/acpi/sleep/main.c .

As a result, I have obtained the following patch series.  Please review and if
it looks good, please queue in the 'suspend' branch as .29 material.

Thanks,
Rafael

