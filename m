From: "malattia@linux.it" <malattia@linux.it>
Subject: Re: [patch 0/5] iASL patches in Debian
Date: Thu, 8 Jul 2010 22:41:38 +0900
Message-ID: <20100708134138.GC1909@kamineko.org>
References: <20100704044332.573836359@linux.it>
 <4911F71203A09E4D9981D27F9D830858A10EFE10@orsmsx503.amr.corp.intel.com>
 <20100707220736.GD5635@kamineko.org>
 <4911F71203A09E4D9981D27F9D830858A11648F6@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56443
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab0GHNlk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jul 2010 09:41:40 -0400
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D830858A11648F6@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Jul 07, 2010 at 04:41:11PM -0700, Moore, Robert wrote:
> Then be sure to disable the disassembler with an appropriate error
> message on these architectures.

Right, makes sense.
It may take a few more days before I get the time to get back to digging
into iasl code, I'll see if it's not too hard to support disassembling
before doing as you suggests.

> Note, we now have a data table compiler, you should look at that also.

sure, any pointer to a starting point? :)

Thanks!
-- 
mattia
:wq!
