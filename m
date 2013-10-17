From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Thu, 17 Oct 2013 21:35:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D33F77@ORSMSX106.amr.corp.intel.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com>
 <20131016104221.GC13608@pd.tnic> <20131016085558.19fe143a@samsung.com>
 <3908561D78D1C84285E8C5FCA982C28F31D31C65@ORSMSX106.amr.corp.intel.com>
 <20131017073443.675e97f2@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62021 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762379Ab3JQVfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 17:35:05 -0400
In-Reply-To: <20131017073443.675e97f2@samsung.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Borislav Petkov <bp@alien8.de>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>

> There's also a third case: mirrored memories.

Mirrors are currently something of a mess - we don't get any useful notification when one breaks.
We do need to fix this - and make sure reporting is properly integrated with everything else - I'm
just not sure how to do this.

-Tony
