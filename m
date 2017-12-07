From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH V6 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Thu, 7 Dec 2017 14:41:17 +0200
Message-ID: <20171207124116.76st5qalao6vbvwf@valkosipuli.retiisi.org.uk>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gq-Xv1V90GEcfxdnrADQn2Gern=LBnsbSzmrU9M0+FEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:57796 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753263AbdLGMlT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2017 07:41:19 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gq-Xv1V90GEcfxdnrADQn2Gern=LBnsbSzmrU9M0+FEQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 05, 2017 at 11:05:52PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 5, 2017 at 6:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> > Introduce new ACPI and OF device ids for thw HW along with the helper
> > functions.
> >
> > Changes from v5:
> > * use struct device as a calling parameter to get_match_data() callback
> > so that we can reuse the existing OF API.
> > * revert the change on acpi_get_match_data() to V4.
> >
> > Sinan Kaya (7):
> >   Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
> >   ACPI / bus: Introduce acpi_get_match_data() function
> >   device property: Introduce a common API to fetch device match data
> >   OF: properties: Implement get_match_data() callback
> >   ACPI: properties: Implement get_match_data() callback
> >   dmaengine: qcom_hidma: Add support for the new revision
> >   dmaengine: qcom_hidma: Add identity register support
> 
> Sakari, can you please have a look at this series?
> 
> I'm particularly interested in your opinion on patches [2-3/7] and [5/7].

Reviewed. Thanks for the heads up!

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
