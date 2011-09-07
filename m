From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] RE: [PATCH 5/7] xen/acpi: Domain0 acpi parser
 related platform hypercall
Date: Wed, 7 Sep 2011 15:06:59 -0400
Message-ID: <20110907190659.GH7074@dumpdata.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
 <1314815484-4668-6-git-send-email-konrad.wilk@oracle.com>
 <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F665@ORSMSX101.amr.corp.intel.com>
 <4E67A9E7.2020802@goop.org>
 <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F40F0B@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:61410 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab1IGTL3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2011 15:11:29 -0400
Content-Disposition: inline
In-Reply-To: <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F40F0B@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "Yu, Ke" <ke.yu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "keir@xen.org" <keir@xen.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "Wei, Gang" <gang.wei@intel.com>

> > >> +#define XENPF_enter_acpi_sleep    51
> > >> +struct xenpf_enter_acpi_sleep {
> > >> +	/* IN variables */
> > >> +	uint16_t pm1a_cnt_val;      /* PM1a control value. */
> > >> +	uint16_t pm1b_cnt_val;      /* PM1b control value. */
> > > These are uint32_t in native Linux--why truncate in the API and not at use?
> > 
> > Does ACPI define them as 32 or 16 bit?
> 
> The spec indicates that the length is variable and could be up to 32 bits (AFAICT).  And Linux uses 32b, which your other patch is truncating for this call.

Yikes! Well, looks like we need to fix the Xen ABI too. Lets get that fixed
and also address all the other comments (thanks for looking at it) you pointed
out.
