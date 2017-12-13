From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Wed, 13 Dec 2017 08:49:20 +0530
Message-ID: <20171213031920.GE18649@localhost>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <20171212053845.GB18649@localhost>
 <CAJZ5v0ijQFO_PuwhBRrKovo4EW9Dck9fiT38wiCw6P5hHUjNuw@mail.gmail.com>
 <0ed35958-22c9-50e5-3b6a-732821de6d20@codeaurora.org>
 <9de34cfa-361e-38bf-0c06-ecff0fc26a5c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:27232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdLMDPg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Dec 2017 22:15:36 -0500
Content-Disposition: inline
In-Reply-To: <9de34cfa-361e-38bf-0c06-ecff0fc26a5c@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 12, 2017 at 07:44:27PM -0500, Sinan Kaya wrote:
> On 12/12/2017 7:09 PM, Sinan Kaya wrote:
> > On 12/12/2017 7:36 AM, Rafael J. Wysocki wrote:
> >> On Tue, Dec 12, 2017 at 6:38 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> >>> On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
> >>>> Introduce new ACPI and OF device ids for thw HW along with the helper
> >>>> functions.
> >>>>
> >>>> Changes from v6:
> >>>> * add const to the device callback parameter in fwnode.
> >>>> * reorganize the callbacks in the code
> >>>> * rename get_match_data() as device_get_match_data()
> >>>> * place pointer checks into acpi_get_match_data()
> >>>
> >>> This fails for me at 3rd patch. I am on -rc1 is there a dependency?
> >>
> >> There shouldn't be any.
> >>
> >> According to git, all changes to the files touched by the [3/7] are in
> >> -rc1 already.
> >>
> > 
> > Let me know if you were able to resolve the conflict. I can rebase against
> > a development tree if you can point me to there.
> > 
> 
> Apparently, my patches were based of 4.14 kernel. 
> 
> I just rebased to 4.15-rc1.
> 
> I can post a new version. Let me know.

Sure that should help

-- 
~Vinod
