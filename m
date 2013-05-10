From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: RE: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode
 is set in HEST for corrected machine checks
Date: Fri, 10 May 2013 10:59:04 -0700
Message-ID: <1368208744.4518.182.camel@oc3432500282.ibm.com>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
	 <20130506232537.GF22041@pd.tnic>
	 <1367897566.4518.83.camel@oc3432500282.ibm.com>
	 <20130507131946.GC7633@pd.tnic>
	 <1367941214.4518.90.camel@oc3432500282.ibm.com>
	 <20130508212237.GI30955@pd.tnic>
	 <3908561D78D1C84285E8C5FCA982C28F2DA47E5E@ORSMSX101.amr.corp.intel.com>
	 <20130508221501.GK30955@pd.tnic>
	 <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com>
Reply-To: masbock@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52550 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab3EJSAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 May 2013 14:00:04 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Fri, 10 May 2013 12:00:02 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 74DED3E40026
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2013 11:58:52 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4AHx6hB127122
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2013 11:59:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4AHx5bW017847
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2013 11:59:06 -0600
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "naveen.n.rao@in.ibm.com" <naveen.n.rao@in.ibm.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>

I'll try to summarize the situation:

We proposed two iterations of a patch that would parse HEST for a
Corrected Machine Check entry and cause CMCI to be disabled if the
Firmware First flag was found to be on in that entry.
Several shortcomings of this approach were subsequently pointed out:
a) Disabling CMCI doesn't go far enough. If the firmware wants to
control corrected machine checks then we shouldn't even be polling the
MCi_STATUS registers. Therefore we need to disable CMCI and disable
polling if FF is set.

b) The firmware may take over only a subset of the possible corrected
machine check events. If we turn off CMCI (and polling) for all banks we
may miss out on some types of errors. Therefore we should not
indiscriminately disable CMCI on all banks.

The question arose whether the APEI spec allows to specify individual
machine check banks which fall under FF control. The answer appears to
be 'possibly'. The Corrected Machine Check (CMC) structure defined in
the APEI spec allows for a list of Machine Check Bank structures which
could be used to designate a set of banks falling under FF control.
However, the spec is silent on how the list of Machine Check Bank
structures in the CMC structure is be used. 

Further steps in this endeavor may depend on the interpretation of the
CMC structure in APEI an whether we can specify individual machine check
banks that fall under FF control.

- Max

