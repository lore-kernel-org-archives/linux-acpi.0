From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 13:04:13 -0300
Message-ID: <20170724130402.0f05c0ba@vento.lan>
References: <1500650732.2042.45.camel@hpe.com>
        <20170721124401.5f94aba9@vento.lan>
        <1500654661.2042.49.camel@hpe.com>
        <20170721140131.40079805@vento.lan>
        <20170721172344.GA11316@nazgul.tnic>
        <1500661773.2042.53.camel@hpe.com>
        <20170722062853.GA2050@nazgul.tnic>
        <1500907209.2042.55.camel@hpe.com>
        <20170724150432.GA31295@nazgul.tnic>
        <1500909372.2042.58.camel@hpe.com>
        <20170724153716.GA17708@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50001
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752336AbdGXQEW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 12:04:22 -0400
In-Reply-To: <20170724153716.GA17708@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Mon, 24 Jul 2017 17:37:16 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> > Customers do not see error counts.  I do not think it's bogus.

> > I am just trying to enable OS error reporting with ghes_edac.  
> 
> I know, you don't have to state the obvious constantly.

The problem I see is that, currently, on users that have EDAC
already enabled, the users gets the errors directly from the
hardware.

If the Kernel force those users to use ghes_edac by default,
they they won't see the error counts anymore, but, instead,
hardware reports that the memories need to be replaced.

Well, if such users are handling thresholds themselves, they
won't see those errors anymore, as the errors will be masked.

That's a regression.

So, the right solution would be to keep hardware first, but
providing a modprobe parameter to let them switch to software
first.

Thanks,
Mauro
