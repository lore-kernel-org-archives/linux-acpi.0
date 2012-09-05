From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi : remove power from acpi_processor_cx structure
Date: Wed, 5 Sep 2012 15:41:58 +0200
Message-ID: <201209051541.58909.rjw@sisk.pl>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <50410811.70500@linaro.org> <201209010754.58999.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37763 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab2IENfk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Sep 2012 09:35:40 -0400
In-Reply-To: <201209010754.58999.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Saturday, September 01, 2012, Rafael J. Wysocki wrote:
> On Friday, August 31, 2012, Daniel Lezcano wrote:
> > On 07/24/2012 11:06 PM, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Jul 24, 2012 at 11:12:29PM +0200, Daniel Lezcano wrote:
> > >> Remove the power field as it is not used.
> > >>
> > >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Acked.
> > 
> > Hi Rafael,
> > 
> > I did not see this patch going in. Is it possible to merge it ?
> 
> I think so.  I'll take care of it when I get back from LinuxCon/Plumbers Conf.
> (early next week).

Applied to the linux-next branch of the linux-pm.git tree as v3.7 material.

Are there any other patches you want me to consider for v3.7?

Rafael
