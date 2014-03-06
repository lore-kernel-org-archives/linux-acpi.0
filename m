From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Thu, 6 Mar 2014 13:17:14 +0100
Message-ID: <20140306121714.GC24629@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic>
 <20140306084320.539ec76e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57271 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbaCFMRV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2014 07:17:21 -0500
Content-Disposition: inline
In-Reply-To: <20140306084320.539ec76e@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Thu, Mar 06, 2014 at 08:43:20AM -0300, Mauro Carvalho Chehab wrote:
> I would prefer to keep this out of arch/, because there are some parts
> of the ras infra that aren't x86 specific.

Those are?

> Going further, it also make sense to move the EDAC drivers into it.

Why?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
