From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Tue, 27 Jun 2017 11:24:25 +0200
Message-ID: <20170627092425.GB5776@wunner.de>
References: <20170626083815.zxlohrjz64delbae@wunner.de>
 <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
 <20170626123853.GA14363@wunner.de>
 <1AE640813FDE7649BE1B193DEA596E886CED58AD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:40525 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdF0JY1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2017 05:24:27 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED58AD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Ronald Tschalaer <ronald@innovation.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jun 27, 2017 at 01:19:31AM +0000, Zheng, Lv wrote:
> > On Mon, Jun 26, 2017 at 01:49:03PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > Hi Robert,
> > > >
> > > > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> > > > resource descriptor handling") is causing a regression when parsing
> > > > an empty ResourceTemplate:
> 
> Can it be fixed by using this logic:
> if (AmlLength < sizeof (AML_RESOURCE_END_TAG) && AmlLength)
> Instead of the logic introduced in commit a83019eb9f1f?
> if (AmlLength < sizeof (AML_RESOURCE_END_TAG))

Unfortunately not, AmlLength is not 0 but 2 in this case
(= sizeof(struct aml_resource_end_tag)).


> If so, could you please offer a fix for upstream?

I'd suggest just reverting the commit, a buffer containing
a lone end tag seems to be legal according to the spec, so
returning an error seems wrong.

Thanks,

Lukas
