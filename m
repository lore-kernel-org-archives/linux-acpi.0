From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v3 00/16] ACPI graph support
Date: Fri, 24 Feb 2017 11:13:09 +0200
Message-ID: <20170224091309.GW16975@valkosipuli.retiisi.org.uk>
References: <1487866776-24578-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:38744 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751057AbdBXJNo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Feb 2017 04:13:44 -0500
Content-Disposition: inline
In-Reply-To: <1487866776-24578-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Thu, Feb 23, 2017 at 06:19:20PM +0200, Sakari Ailus wrote:
> changes since v2.2:
> 
> - Drop device_fwnode_handle() function in favour of moving the existing
>   dev_fwnode() function from drivers/base/property.c to linux/property.h
>   (now patch 12).
> 
> - Unmerge two unrelated patches accidentally merged between RFC v1 and
>   PATCH v1 of the series. The patch adding device_fwnode_handle() was
>   accidentally merged with "device property: Obtain device's fwnode
>   independently of FW type".
> 
> - Remove redundant forward declaration of struct device in
>   linux/property.h.

I forgot to mention that the patch "device property: Get endpoint index from
the ACPI tables" has been merged with "device property: Obtain device's
fwnode independently of FW type". This is how it was expected to be already
in v2. There are no changes in code though.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
