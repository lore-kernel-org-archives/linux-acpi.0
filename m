From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 0/6] Move firmware specific code to firmware specific
 locations
Date: Wed, 31 May 2017 15:23:12 +0300
Message-ID: <20170531122312.GH2784@lahna.fi.intel.com>
References: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdEaMXo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 08:23:44 -0400
Content-Disposition: inline
In-Reply-To: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

On Wed, May 31, 2017 at 02:52:06PM +0300, Sakari Ailus wrote:
> Kieran Bingham (1):
>   device property: Add fwnode_graph_get_port_parent
> 
> Sakari Ailus (5):
>   ACPI: Constify argument to acpi_device_is_present()
>   device property: Move FW type specific functionality to FW specific
>     files
>   device property: Move fwnode graph ops to firmware specific locations
>   device property: Introduce fwnode_device_is_available()
>   device property: Add FW type agnostic fwnode_graph_get_remote_node
> 
>  drivers/acpi/device_pm.c |   4 +-
>  drivers/acpi/internal.h  |   2 +-
>  drivers/acpi/property.c  | 117 ++++++++++++++++
>  drivers/acpi/scan.c      |  10 +-
>  drivers/base/property.c  | 347 ++++++++++++++++++++---------------------------
>  drivers/of/property.c    | 148 ++++++++++++++++++++
>  include/linux/acpi.h     |   4 +
>  include/linux/fwnode.h   |  69 ++++++++++
>  include/linux/of.h       |   2 +
>  include/linux/property.h |   5 +
>  10 files changed, 501 insertions(+), 207 deletions(-)

In general looks good to me now. I commented on one patch but other than
that no objections from me.

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
