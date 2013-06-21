From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 16:08:04 +0200
Message-ID: <20130621140804.GF22006@pd.tnic>
References: <20130620073943.GE32694@pd.tnic>
 <51C3531D.3000600@linux.vnet.ibm.com>
 <20130620192928.GD19877@pd.tnic>
 <51C36288.4050405@linux.vnet.ibm.com>
 <20130620205726.GA20863@pd.tnic>
 <51C37291.40303@linux.vnet.ibm.com>
 <20130621073419.GC22006@pd.tnic>
 <51C404EA.10906@linux.vnet.ibm.com>
 <20130621083608.GE22006@pd.tnic>
 <51C41D94.1030201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56668 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161446Ab3FUOIP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jun 2013 10:08:15 -0400
Content-Disposition: inline
In-Reply-To: <51C41D94.1030201@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Fri, Jun 21, 2013 at 03:02:04PM +0530, Naveen N. Rao wrote:
> As an example, consider a hypothetical single-core Intel processor
> with Hyperthreading. On init, let's say the first cpu ends up owning
> banks 1, 2, 3 and 4; and the second cpu ends up owning banks 1 and
> 2. This would mean that MC banks 1 and 2 are "hyperthread"-specific,
> while banks 3 and 4 are shared. Now, if we offline the first cpu, it
> disables CMCI on all 4 banks.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is what I find strange - having to disable CMCI, especially on a
shared bank, just to reenable it right back on the next core. But I
guess this is a constraint dictated by the hardware...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
