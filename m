From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 10:40:01 -0300
Message-ID: <20170721104001.3cd2b884@vento.lan>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>
        <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>
        <1500481869.2042.29.camel@hpe.com>
        <20170720043344.GC14367@nazgul.tnic>
        <1500579646.2042.37.camel@hpe.com>
        <20170721133441.GB5036@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:41840
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751065AbdGUNkM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 09:40:12 -0400
In-Reply-To: <20170721133441.GB5036@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Fri, 21 Jul 2017 15:34:41 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jul 20, 2017 at 07:50:03PM +0000, Kani, Toshimitsu wrote:
> > GHES / firmware-first still requires OS recovery actions when an error
> > cannot be corrected by the platform.  They are handled by ghes_proc(),
> > and ghes_edac remains its error-reporting wrapper. 

What happens when the error can be corrected? Does it still report it to
userspace, or just silently hide the error?

If I remember well about a past discussion with some vendor, I was told
that the firmware can hide some errors from being reported. Is it
still the case?


Thanks,
Mauro
