From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RESEND PATCH V2] ACPI, APEI: Add validation check before GHES
 error is recorded
Date: Fri, 20 Apr 2012 23:13:40 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F170E703B@ORSMSX104.amr.corp.intel.com>
References: <1334913860-24651-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34321 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab2DTXNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Apr 2012 19:13:41 -0400
In-Reply-To: <1334913860-24651-1-git-send-email-gong.chen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

arch/x86/kernel/cpu/mcheck/mce-apei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This patch seems to be in cross-over territory between ACPI and MCE

... I just applied it to the RAS tree.

-Tony
