From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] MAINTAINERS: Add Tony and Boris as ACPI/APEI reviewers
Date: Fri, 28 Jul 2017 09:35:51 +0200
Message-ID: <20170728073551.GB1889@nazgul.tnic>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic>
 <1893763.BLgt1zgLk5@aspire.rjw.lan>
 <1632667.Vgem7HtdXu@aspire.rjw.lan>
 <20170727055825.GA4611@nazgul.tnic>
 <CAJZ5v0jVSrsufoWyexb_MWS=ni0CDn7Oo1-oHOcaTxdYpfpQMg@mail.gmail.com>
 <20170727144922.GF28553@nazgul.tnic>
 <CAJZ5v0gQ5aYZw8NOpvmw-1zqfFg_k+nkTZxEocnT=hDk37VsGA@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F61317AEB@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751007AbdG1Hgi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jul 2017 03:36:38 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F61317AEB@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Loc Ho <lho@apm.com>, Mark Salter <msalter@redhat.com>, Tyler Baicar <tbaicar@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@apm.com" <patches@apm.com>

Since this piece of the ACPI pile is doing RAS, it is perhaps prudent if
we at least paid attention to it and the direction it takes. So add Tony
and me as reviewers.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488dfdbc9..985413fb5d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -310,6 +310,14 @@ F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*/*/*acpi*
 F:	tools/power/acpi/
 
+ACPI APEI
+M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	Len Brown <lenb@kernel.org>
+L:	linux-acpi@vger.kernel.org
+R:	Tony Luck <tony.luck@intel.com>
+R:	Borislav Petkov <bp@alien8.de>
+F:	drivers/acpi/apei/
+
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
 M:	Lv Zheng <lv.zheng@intel.com>
-- 
2.14.0.rc0

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
