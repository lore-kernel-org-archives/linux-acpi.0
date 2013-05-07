From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Tue, 7 May 2013 15:19:46 +0200
Message-ID: <20130507131946.GC7633@pd.tnic>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47366 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771Ab3EGNTl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 09:19:41 -0400
Content-Disposition: inline
In-Reply-To: <1367897566.4518.83.camel@oc3432500282.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Max Asbock <masbock@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

On Mon, May 06, 2013 at 08:32:46PM -0700, Max Asbock wrote:
> But this is glue code between MCE and APEI, therefore I thought a
> file named mce-apei.c would be a good place. If we put it into apei
> then we might have to export some of the MCE interfaces, whereas
> apei_hest_parse() is already exported.

Right, I don't want to expose any MCA internals to other subsystems
unless it is really necessary.

AFAICT, you need an ON and OFF switch for CMCI which is callable from
outside. So you can adapt/adjust the code in mce_intel.c to do so
without adding any other code.

Unless I'm missing something. But I don't think so, the high-level
sequence looks like this:

* MCA init
 -> CMCI init
* APEI init:
 -> if FF
    -> CMCI off

At a quick glance, simply doing:

	on_each_cpu(cmci_clear_func, NULL, 1);

should work. You'd need to define a proper cmci_clear_func prototype but
that should be trivial...

Pretty straight-forward, no?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
