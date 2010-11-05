From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] X86: Cleanup idle= internal variables by getting rid of idle_halt idle_nomwait
Date: Fri, 5 Nov 2010 11:24:49 +0100
Message-ID: <201011051124.49973.trenn@suse.de>
References: <201011021441.09258.trenn@suse.de> <alpine.LFD.2.00.1011030150560.3378@localhost.localdomain> <201011031706.15248.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40987 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab0KEKYv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Nov 2010 06:24:51 -0400
In-Reply-To: <201011031706.15248.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Len,

On Wednesday 03 November 2010 17:06:14 Thomas Renninger wrote:
> On Wednesday 03 November 2010 07:33:54 Len Brown wrote:
...
> > That function and all these idle workaround flags
> > need to be re-whacked.
> Whatabout this (compile tested (on x86_64/ia64)).
> Adding lkml as this affects x86 core code.
as this mostly affects intel_idle and acpi processor driver,
can you apply this one to your acpi test branch if you are
ok with it.

Thanks,

     Thomas
