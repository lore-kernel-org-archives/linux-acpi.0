From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: Fix reading pset strings using
 array access functions
Date: Tue, 28 Mar 2017 15:48:29 +0300
Message-ID: <20170328124829.GO2957@lahna.fi.intel.com>
References: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
 <1490703739-28270-3-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62754 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932720AbdC1MuK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 08:50:10 -0400
Content-Disposition: inline
In-Reply-To: <1490703739-28270-3-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Tue, Mar 28, 2017 at 03:22:18PM +0300, Sakari Ailus wrote:
> The length field value of non-array string properties is the length of the
> string itself. Non-array string properties thus require specific handling.
> Fix this.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
