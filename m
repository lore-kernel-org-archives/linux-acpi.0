From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 19:31:53 +0200
Message-ID: <20170816173153.gl4gx2bo7pvfjha7@pd.tnic>
References: <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
 <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
 <20170815154815.wy3dqwb4yi3feahg@intel.com>
 <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
 <20170816095901.33b0d4c2@gandalf.local.home>
 <20170816140350.o573iksqgkj4m5xu@pd.tnic>
 <20170816102249.0c0d8d12@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbdHPRcC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 13:32:02 -0400
Content-Disposition: inline
In-Reply-To: <20170816102249.0c0d8d12@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Aug 16, 2017 at 10:22:49AM -0400, Steven Rostedt wrote:
> Maybe keep that original mutex just in case.

Let's do the elegant thing:

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d4089c2980ef..386e04a7bda0 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -28,6 +28,7 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
 
+static atomic_t ghes_init = ATOMIC_INIT(0);
 static struct ghes_edac_pvt *ghes_pvt;
 
 /*
@@ -426,7 +427,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
 	 */
-	if (ghes_pvt)
+	if (atomic_inc_return(&ghes_init) > 1)
 		return 0;
 
 	/* Get the number of DIMMs */

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
