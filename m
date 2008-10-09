From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPI: Add _PDC object evaluate for VIA.
Date: Wed, 08 Oct 2008 20:46:57 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810082037340.3041@localhost.localdomain>
References: <48DDF430.8060806@viatech.com.cn> <20080927160530.GA27124@elte.hu>
 <48DEEEA1.1010605@viatech.com.cn> <48EC18B0.4060704@viatech.com.cn>
 <7E82351C108FA840AB1866AC776AEC463775879E@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:52085 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYJIArM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 20:47:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172069.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8G00EDT4UD1KK1@vms172069.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 19:47:02 -0500 (CDT)
In-reply-to: <7E82351C108FA840AB1866AC776AEC463775879E@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: louisqi <louisqi@viatech.com.cn>, Ingo Molnar <mingo@elte.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



> Question: Where are these PDC bits defined for via CPUs? I mean the bits that we use in intel_pdc are
> defined in an Intel specific document. Just wondering whether the same bit definitions hold good for
> via or we should have a different set of defines?

ditto.
init_intel_pdc() uses Intel vendor specific bits documented in 
ftp://download.intel.com/technology/IAPC/acpi/downloads/30222305.pdf
and coded into include/acpi/pdc_intel.h

If VIA is going to have any different bit definitions, then
we should really create a pdc_via.h.  But if VIA is going to re-use
the bits defined by Intel in a compatible way for the
forseeable future, then probably all we need to do is add a
comment saying that the bits VIA is using have the exact
same meaning as they do for Intel.

thanks,
-Len

ps. I'm delighted to receive a patch from VIA.
Sometimes we run into failures in undocumented VIA chipsets,
perhaps you can help us when we run into those?
