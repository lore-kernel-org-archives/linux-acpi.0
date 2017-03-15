From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v4 11/16] of: No need to include linux/property.h,
 linux/fwnode.h is sufficient
Date: Wed, 15 Mar 2017 15:58:56 +0200
Message-ID: <20170315135856.GE10701@valkosipuli.retiisi.org.uk>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-12-git-send-email-sakari.ailus@linux.intel.com>
 <5243740.SuWZqUpGfj@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:46372 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752300AbdCON7d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 09:59:33 -0400
Content-Disposition: inline
In-Reply-To: <5243740.SuWZqUpGfj@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Mon, Mar 13, 2017 at 10:46:32PM +0100, Rafael J. Wysocki wrote:
> On Monday, March 06, 2017 04:19:25 PM Sakari Ailus wrote:
> > of.h requires a definition of struct fwnode_handle, and for that it
> > includes linux/property.h. struct fwnode_handle, however, is defined in
> > linux/fwnode.h. Include linux/fwnode.h directly.
> > 
> > A number of users were however depending on linux/property.h, thus fix
> > them by including that header directly as well.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> How exactly is this related to the rest of the series?  Do any other patches in
> the series depend on it?

It did; keeping dev_fwnode() in property.c instead of moving it to the
header removes the need for the patch. I'll drop it.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
