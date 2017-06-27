From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Tue, 27 Jun 2017 11:59:17 -0700
Message-ID: <20170627185917.GA14927@innovation.ch>
References: <20170626083815.zxlohrjz64delbae@wunner.de>
 <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
 <20170626123853.GA14363@wunner.de>
 <1AE640813FDE7649BE1B193DEA596E886CED58AD@SHSMSX101.ccr.corp.intel.com>
 <20170627092425.GB5776@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chill.innovation.ch ([216.218.245.220]:60680 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbdF0TFZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2017 15:05:25 -0400
Content-Disposition: inline
In-Reply-To: <20170627092425.GB5776@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


On Tue, Jun 27, 2017 at 11:24:25AM +0200, Lukas Wunner wrote:
> On Tue, Jun 27, 2017 at 01:19:31AM +0000, Zheng, Lv wrote:
> > > On Mon, Jun 26, 2017 at 01:49:03PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > Hi Robert,
> > > > >
> > > > > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> > > > > resource descriptor handling") is causing a regression when parsing
> > > > > an empty ResourceTemplate:
> > 
> > Can it be fixed by using this logic:
> > if (AmlLength < sizeof (AML_RESOURCE_END_TAG) && AmlLength)
> > Instead of the logic introduced in commit a83019eb9f1f?
> > if (AmlLength < sizeof (AML_RESOURCE_END_TAG))
> 
> Unfortunately not, AmlLength is not 0 but 2 in this case
> (= sizeof(struct aml_resource_end_tag)).

Actually, that will work here (the use of '<' ensures that). But it's
unclear whether this is semantically the correct thing, in particular
because a83019eb9f1f widened the cases where NO_RESOURCE_END_TAG is
returned, but the above suggestion narrows them. Unfortunately commit
a83019eb9f1f is quite vague about why it reverted back to '<='.


  Cheers,

  Ronald

