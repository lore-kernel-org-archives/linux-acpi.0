From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH EDAC 07/13] edac: add support for raw error reports
Date: Fri, 15 Feb 2013 16:41:23 +0100
Message-ID: <20130215154123.GH14387@pd.tnic>
References: <cover.1360931635.git.mchehab@redhat.com>
 <e08f797b129a50b4e1b39e8c31bff82904aea65d.1360931635.git.mchehab@redhat.com>
 <20130215141330.GF14387@pd.tnic>
 <20130215132530.4f3b7dab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33551 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab3BOPle (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2013 10:41:34 -0500
Content-Disposition: inline
In-Reply-To: <20130215132530.4f3b7dab@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Linux Edac Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 15, 2013 at 01:25:30PM -0200, Mauro Carvalho Chehab wrote:
> Well, for sure using an structure will help to avoid missing a
> parameter or exchanging its order. The stack usage won't reduce,
> though, because the structure will keep using the stack.

If you allocate it on the stack of the caller, yes. If you kmalloc it,
no.

In any case, passing a pointer to struct edac_raw_error_desc only will
allow on x86_64 (and i386 AFAICT) to use only registers to pass callee
function arguments. Which is always a win. You probably need to stare at
compiler output to see what gcc actually does with -O2 optimizations.

> As I can't foresee the usage of this function call outside the core
> and by the GHES driver, I'm not sure what would be the better.

Having an error descriptor is always better, even if it were only for
clarity's and simplicity's sake.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
