From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ACPICA regression for empty ResourceTemplates
Date: Tue, 27 Jun 2017 01:19:31 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CED58AD@SHSMSX101.ccr.corp.intel.com>
References: <20170626083815.zxlohrjz64delbae@wunner.de>
 <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
 <20170626123853.GA14363@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15320 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbdF0BTg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jun 2017 21:19:36 -0400
In-Reply-To: <20170626123853.GA14363@wunner.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Ronald Tschalaer <ronald@innovation.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Lukas
> Wunner
> Sent: Monday, June 26, 2017 8:39 PM
> To: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Moore, Robert <robert.moore@intel.com>; Zheng, Lv <lv.zheng@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Ronald Tschalaer <ronald@innovation.ch>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>
> Subject: Re: ACPICA regression for empty ResourceTemplates
> 
> On Mon, Jun 26, 2017 at 01:49:03PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > Hi Robert,
> > >
> > > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> > > resource descriptor handling") is causing a regression when parsing
> > > an empty ResourceTemplate:
> >
> > This is a linux-next commit, right?
> 
> Yes.

Can it be fixed by using this logic:
if (AmlLength < sizeof (AML_RESOURCE_END_TAG) && AmlLength)
Instead of the logic introduced in commit a83019eb9f1f?
if (AmlLength < sizeof (AML_RESOURCE_END_TAG))

If so, could you please offer a fix for upstream?

Thanks and best regards
Lv

> 
> Lukas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
