From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] HPET: stop soliciting hpet=force users on ICH4M
Date: Fri, 24 Apr 2009 08:43:09 +0200
Message-ID: <20090424064309.GB21739@elte.hu>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain> <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain> <alpine.LFD.2.00.0904231918510.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57969 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbZDXGnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2009 02:43:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904231918510.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> The HPET in the ICH4M is not documented in the data sheet
> because it was not officially validated.
> 
> While it is fine for hackers to continue to use "hpet=force"
> to enable the hardware that they have, it is not prudent to
> solicit additional "hpet=force" users on this hardware.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Applied, thanks Len!

	Ingo
