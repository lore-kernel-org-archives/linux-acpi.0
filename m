From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 14:56:06 -0300
Message-ID: <20170724145606.3686ba39@vento.lan>
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
        <1500911226.2042.60.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50378
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753142AbdGXR4R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 13:56:17 -0400
In-Reply-To: <1500911226.2042.60.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Mon, 24 Jul 2017 15:56:27 +0000
"Kani, Toshimitsu" <toshi.kani@hpe.com> escreveu:

> On Mon, 2017-07-24 at 17:37 +0200, Borislav Petkov wrote:
> > On Mon, Jul 24, 2017 at 03:25:34PM +0000, Kani, Toshimitsu wrote:  
>  :
> >   
> > > We've been providing this model for many years now.  
> > 
> > Dude, relax, I'm only trying to point out to you that there are
> > customers who want to see *every* error and thus track how their
> > hardware behaves. And that for those customers it is probably worth
> > considering exposing that info and providing a switch to disable that
> > dumbing of the RAS functionality in the BIOS so that people can
> > decide for themselves. That's all.  
> 
> Yes, Mauro has already pointed this out.  As I replied to him, we do
> have a separate series of platforms that do not have built-in RAS, and
> report all errors.  Such customers can simply choose them.  They do not
> need to pay for built-in RAS.

That's probably too late for me as I received a new HP machine
we bought just last week, but for the next time I would need to
get a new hardware, what would be the non-RAS equivalent to
a ML 350 G9 tower-mounted machine with two Xeon v4 CPUs and iLO?

Regards,
Mauro

> 
> The model w/ built-in RAS provides warranty & full support.  As I said,
> it's a different model. 
> 
> Thanks,
> -Toshi



Thanks,
Mauro
