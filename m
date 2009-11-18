From: Rocky Craig <rocky.craig@hp.com>
Subject: Re: [Openipmi-developer] IPMI device discovery [was Re: [PATCH ]
 IPMI: Locate the IPMI system interface in ACPI namespace]
Date: Wed, 18 Nov 2009 14:53:38 -0700
Message-ID: <4B046CE2.90200@hp.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>	<200911180945.45570.bjorn.helgaas@hp.com> <4B045BD9.8070906@hp.com> <200911181419.27238.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:8041 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbZKRVvs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 16:51:48 -0500
In-Reply-To: <200911181419.27238.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, ykzhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

Bjorn Helgaas emitted:

> I disagree that this requirement was lost....

Sorry, my words did not convey my intended meaning, which was that
"conformance" or "coherence" was lost, with SPMI also being listed
in ACPI general namespace.

You actually stated this with greater clarity:

> There may be firmware that has an SPMI but neglects to put the device
> in the namespace.

That may be the case on some legacy servers.

Rocky
