From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 6/6] device property: Constify device_get_match_data()
Date: Thu, 01 Feb 2018 22:38:45 +0200
Message-ID: <1517517525.7000.1444.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-6-andriy.shevchenko@linux.intel.com>
         <bfeef6d8-15d0-84f7-947f-f849616151a8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:53074 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755005AbeBAUis (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 15:38:48 -0500
In-Reply-To: <bfeef6d8-15d0-84f7-947f-f849616151a8@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-01 at 15:35 -0500, Sinan Kaya wrote:
> On 2/1/2018 3:20 PM, Andy Shevchenko wrote:
> > -void *device_get_match_data(struct device *dev)
> > +const void *device_get_match_data(struct device *dev)
> >  {
> > -	return fwnode_call_ptr_op(dev_fwnode(dev),
> > device_get_match_data,
> > -				  dev);
> > +	return fwnode_call_ptr_op(dev_fwnode(dev),
> > device_get_match_data, dev);
> >  }
> 
> I remember having a checkpatch problem here.

It's exactly 79 characters. 
What problem?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
