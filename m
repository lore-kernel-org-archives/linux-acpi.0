From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI / APEI: No remaining users of struct acpi_bert_region
Date: Sat, 13 May 2017 00:52:17 +0200
Message-ID: <3291819.ypSHrjQjkn@aspire.rjw.lan>
References: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic> <747341231.C4QRqWBle1@aspire.rjw.lan> <20170512223250.cyvdbmc7tnseumdz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53253 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750796AbdELW6u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 18:58:50 -0400
In-Reply-To: <20170512223250.cyvdbmc7tnseumdz@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Friday, May 12, 2017 03:32:51 PM Luck, Tony wrote:
> On Fri, May 12, 2017 at 11:46:31PM +0200, Rafael J. Wysocki wrote:
> > Well, again, this is an ACPICA header and by changing it in the kernel alone
> > we make it out of sync with the upstream, which may be a problem for the
> > maintainers thereof when they port changes from the upstream ACPICA to the
> > kernel.
> > 
> > So, (a) do we have to change it and (b) can that be routed through the
> > upstream?
> 
> a) No ... we don't have to

OK

> b) Yes. What is the process / mailing list to make an ACPICA change?

The relevant information is there in MAINTAINERS.

The process is to post changes to the devel mailing list, as per MAINTAINERS,
but it should be sufficient to CC the ACPICA maintainers, which I did, and talk
to them. :-)

Thanks,
Rafael

