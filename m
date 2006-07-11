From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1, kacpid_notify/7105
Date: Tue, 11 Jul 2006 15:36:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F3153D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9016 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751143AbWGKTgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2006 15:36:36 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


>I think the patch I posted on Friday will solve this issue:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=115230920629981&w=2
>
>It is included in 2.6.18-rc1-mm1.

FYI, this is included in 2.6.18-rc1-git4
