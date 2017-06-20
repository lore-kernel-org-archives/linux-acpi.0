From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7.2 7/7] device property: Get rid of struct
 fwnode_handle type field
Date: Tue, 20 Jun 2017 15:03:34 +0300
Message-ID: <20170620120334.GX629@lahna.fi.intel.com>
References: <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56074 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdFTMFt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jun 2017 08:05:49 -0400
Content-Disposition: inline
In-Reply-To: <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

On Tue, Jun 20, 2017 at 11:49:56AM +0300, Sakari Ailus wrote:
> Instead of relying on the struct fwnode_handle type field, define
> fwnode_operations structs for all separate types of fwnodes. To find out
> the type, compare to the ops field to relevant ops structs.
> 
> This change has two benefits:
> 
> 1. it avoids adding the type field to each and every instance of struct
> fwnode_handle, thus saving memory and
> 
> 2. makes the ops field the single factor that defines both the types of
> the fwnode as well as defines the implementation of its operations,
> decreasing the possibility of bugs when developing code dealing with
> fwnode internals.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
