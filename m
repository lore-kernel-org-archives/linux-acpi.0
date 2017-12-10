From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Sun, 10 Dec 2017 22:09:08 +0530
Message-ID: <20171210163908.GH18649@localhost>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0g8v3mwCZOCXHsy_0iA+0RzFFhBxfo4f_cEv5QVLEccsA@mail.gmail.com>
 <bad52be7-4ff8-4f06-4bd0-83e97701f495@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:6780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJQfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Dec 2017 11:35:25 -0500
Content-Disposition: inline
In-Reply-To: <bad52be7-4ff8-4f06-4bd0-83e97701f495@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 08, 2017 at 09:44:46AM -0500, Sinan Kaya wrote:
> On 12/8/2017 8:48 AM, Rafael J. Wysocki wrote:
> > The series is fine by me, by how do you want to route it?
> 
> Probably through the DMA engine route as it has pieces that didn't get any
> review from Vinod yet.
> 
> Vinod,
> 
> Do you have any preference?

Yeah sure sounds okay to me as DMA parts are dependent on these.
Rafael if you need an immutable tag to pull this, let me know.

Thanks
-- 
~Vinod
