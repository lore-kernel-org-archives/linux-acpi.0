From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16-rc1-mm1 (**** SET: Misaligned resource pointer: ...)
Date: Fri, 20 Jan 2006 01:08:08 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF4@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:50336 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422686AbWATGI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 01:08:27 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Coady <gcoady@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>


>**** SET: Misaligned resource pointer: efe72c22 Type 07 Len 0

Grant,
Thanks for sending the DSDT.

Bob dug into this and concluded that this
new warning is from excess paranoia and can be ignored.
It will be gone in the next revision of the ACPI patch.

thanks,
-Len
