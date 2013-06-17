From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware
 First mode is set in
Date: Mon, 17 Jun 2013 16:01:43 +0530
Message-ID: <51BEE58F.5050204@linux.vnet.ibm.com>
References: <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com> <20130614181721.11206.95341.stgit@localhost.localdomain> <20130615144830.GA13310@pd.tnic> <51BEB3F5.8070002@gmail.com> <20130617070650.GA7203@pd.tnic> <20130617081103.GA4197@naverao1-tp.in.ibm.com> <20130617082135.GB7203@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:39406 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab3FQKbv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2013 06:31:51 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Mon, 17 Jun 2013 20:24:46 +1000
In-Reply-To: <20130617082135.GB7203@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "ananth@in.ibm.com" <ananth@in.ibm.com>, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/17/2013 01:51 PM, Borislav Petkov wrote:
> On Mon, Jun 17, 2013 at 01:41:03PM +0530, Naveen N. Rao wrote:
>> Yes, we used to poll since we do not get notified via MCE/CMCI.
>> However, with firmware first set in CMC structure, the firmware is
>> now controlling all corrected error reporting for these banks. So, we
>> should not be looking at these MCA banks at all.
>
> Ok,
>
> then the bank polling disabling part should be generic code (i.e., not
> in mce_intel) since it is part of the APEI crap. The CMCI disabling
> should be Intel-specific only as AMD has a similar mechanism which we'll
> need to disable at some point too.

Ok, I'll move mce_disable_bank() to mce.c and re-structure the patch 
around that.

Thanks,
Naveen

