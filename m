From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into
 tools Makefile.
Date: Wed, 15 Jan 2014 21:43:13 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948452C20CD@FMSMSX106.amr.corp.intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com>
 <cover.1389676901.git.lv.zheng@intel.com> <52D6BFA9.80609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44176 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbaAOVnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 16:43:22 -0500
In-Reply-To: <52D6BFA9.80609@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Is there any work going on to reconcile (or merge or ...) this
> version of acpidump with the version in upstream ACPICA?  The
> sources are very different yet they seem to me to provide more
> or less the same functionality.

Yes, that is exactly what is going on.
The acpidump in the kernel tree today is what we've been using for years.

The acpidump in the ACPICA tree its newly developed replacement.
When we cut over to the new, it will replace the old.

There is no big feature change here -- mostly the idea is
simply that more benefit from sharing the code maintained in the
upstream ACPICA source tree.

cheers,
-Len

