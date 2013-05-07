From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Tue, 7 May 2013 23:55:13 +0200
Message-ID: <20130507215513.GG7633@pd.tnic>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
 <20130506232537.GF22041@pd.tnic>
 <1367897566.4518.83.camel@oc3432500282.ibm.com>
 <20130507131946.GC7633@pd.tnic>
 <1367941214.4518.90.camel@oc3432500282.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F1F3FF565@fmsmsx152.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33153 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3EGVyC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 17:54:02 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F1F3FF565@fmsmsx152.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "naveen.n.rao@in.ibm.com" <naveen.n.rao@in.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>

On Tue, May 07, 2013 at 09:34:28PM +0000, Luck, Tony wrote:
> What happens when you succeed and turn off CMCI?  Will Linux
> still poll the machine check banks looking for corrected errors?

Of course - there's the mce_timer. Which begs the question: is FF going
to take over *all* correctable MCEs or only a subset?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
