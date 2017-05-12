From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2 2/2] ACPI / APEI: No remaining users of struct
 acpi_bert_region
Date: Fri, 12 May 2017 15:32:51 -0700
Message-ID: <20170512223250.cyvdbmc7tnseumdz@intel.com>
References: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
 <cover.1494624795.git.tony.luck@intel.com>
 <e5482112927d6b31aba43b88f1faba6c9fd96ab3.1494624795.git.tony.luck@intel.com>
 <747341231.C4QRqWBle1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40605 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbdELWcw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 18:32:52 -0400
Content-Disposition: inline
In-Reply-To: <747341231.C4QRqWBle1@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Fri, May 12, 2017 at 11:46:31PM +0200, Rafael J. Wysocki wrote:
> Well, again, this is an ACPICA header and by changing it in the kernel alone
> we make it out of sync with the upstream, which may be a problem for the
> maintainers thereof when they port changes from the upstream ACPICA to the
> kernel.
> 
> So, (a) do we have to change it and (b) can that be routed through the
> upstream?

a) No ... we don't have to

b) Yes. What is the process / mailing list to make an ACPICA change?

-Tony
