From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 16:02:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121553470.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6F76365@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:17297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932443AbWGLXCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 19:02:22 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F76365@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>



On Wed, 12 Jul 2006, Brown, Len wrote:
>
> >Likely related to bugzilla-5534
> 
> b8d35192c55fb055792ff0641408eaaec7c88988

Well, that one certainly looks likely.

Any reason to not just revert it? The fundamental problems that it 
introduces are obviously much worse than the fix.

		Linus 
