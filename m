From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 10:22:49 -0400
Message-ID: <20170816102249.0c0d8d12@gandalf.local.home>
References: <1502734083.2042.143.camel@hpe.com>
        <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
        <1502736750.2042.145.camel@hpe.com>
        <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
        <1502741290.2042.147.camel@hpe.com>
        <20170814203942.6t3mrq3hc324blab@pd.tnic>
        <1502810766.2042.149.camel@hpe.com>
        <20170815154815.wy3dqwb4yi3feahg@intel.com>
        <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
        <20170816095901.33b0d4c2@gandalf.local.home>
        <20170816140350.o573iksqgkj4m5xu@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdHPOWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 10:22:52 -0400
In-Reply-To: <20170816140350.o573iksqgkj4m5xu@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Kani, Toshimitsu" <toshi.kani@hpe.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, 16 Aug 2017 16:03:50 +0200
Borislav Petkov <bp@alien8.de> wrote:

> > What's the likelihood of two calls to ghes_edac_register being done
> > simultaneously?  Because two calls at the same time will get past this.  
> 
> Well, that thing gets called per GHES platform device and last time I
> checked they do get probed back-to-back but I'll check that again.

Maybe keep that original mutex just in case.

-- Steve

