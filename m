From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/2] x86/ras/mce_amd_inj: Preset MCE injection struct
Date: Mon, 24 Apr 2017 13:37:18 +0200
Message-ID: <20170424113718.hhycno5my6fbjebv@pd.tnic>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
 <1492804517.2738.25.camel@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
 <CAPcyv4jAkCE2QBuxfxxmZfQZLCVOGLrLXqDu5TyGCVA+xJMEVg@mail.gmail.com>
 <20170421202741.GA16423@intel.com>
 <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168575AbdDXLhV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Apr 2017 07:37:21 -0400
Content-Disposition: inline
In-Reply-To: <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

From: Borislav Petkov <bp@suse.de>
Date: Mon, 24 Apr 2017 13:19:34 +0200
Subject: [PATCH 2/2] x86/ras/mce_amd_inj: Preset MCE injection struct

Populate the MCE injection struct before doing initial injection so that
values which don't change already have proper values.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ras/mce_amd_inj.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/ras/mce_amd_inj.c b/arch/x86/ras/mce_amd_inj.c
index 8730c2882fff..e3b5d7e7e9ee 100644
--- a/arch/x86/ras/mce_amd_inj.c
+++ b/arch/x86/ras/mce_amd_inj.c
@@ -463,6 +463,8 @@ static int __init init_mce_inject(void)
 			goto err_dfs_add;
 	}
 
+	mce_setup(&i_mce);
+
 	return 0;
 
 err_dfs_add:
-- 
2.11.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
