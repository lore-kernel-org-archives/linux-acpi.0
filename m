From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Wed, 8 May 2013 23:22:37 +0200
Message-ID: <20130508212237.GI30955@pd.tnic>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35509 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab3EHVUf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 17:20:35 -0400
Content-Disposition: inline
In-Reply-To: <1367941214.4518.90.camel@oc3432500282.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Max Asbock <masbock@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

On Tue, May 07, 2013 at 08:40:14AM -0700, Max Asbock wrote:
> + * When Firmware First mode is specified in HEST for Corrected
> + * Machine Checks, these errors are expected to be reported by the
> + * firmware through a Generic Harware Event Source (GHES). In this
> + * case error reporting through CMCI should not be enabled so it
> + * won't interfere with the firmware.

Ok, hold on: by accident I fell over the code in ghes_init() which
blubbers about APEI FF too. Isn't that the same thing?

Because if yes, you won't need any of the HEST header parsing here. So
what's up?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
