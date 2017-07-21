From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/8] ACPI: Use IS_ERR_OR_NULL() instead of non-NULL
 check in is_acpi_data_node
Date: Fri, 21 Jul 2017 15:12:15 +0300
Message-ID: <1500639135.29303.172.camel@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
         <1500637177-16095-2-git-send-email-sakari.ailus@linux.intel.com>
         <1500638399.29303.166.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64268 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbdGUMNu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 08:13:50 -0400
In-Reply-To: <1500638399.29303.166.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com

On Fri, 2017-07-21 at 14:59 +0300, Andy Shevchenko wrote:
> On Fri, 2017-07-21 at 14:39 +0300, Sakari Ailus wrote:
> > The is_acpi_data_node() function takes a struct fwnode_handle
> > pointer
> > as
> > its argument. The validity of the pointer is first checked. Extend
> > the
> > check to cover error values as is done by similar is_acpi_node() and
> > is_acpi_device_node() functions.
> > 
> 
> 
> It seems we will have three places with such code. Do we care to get
> rid
> of them in favor of is_acpi_data_node()? (I didn't read whole series
> yet, maybe it's already done)

Please, ignore this comment, I messed up with FWNODE_ACPI type.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
