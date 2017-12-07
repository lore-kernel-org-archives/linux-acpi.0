From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
Date: Fri, 8 Dec 2017 00:06:42 +0200
Message-ID: <20171207220642.qqiwf4vvk2gf42uf@valkosipuli.retiisi.org.uk>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
 <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
 <c2b38889-888a-3518-bf59-c2377f64a8ce@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2b38889-888a-3518-bf59-c2377f64a8ce@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 07, 2017 at 03:17:52PM -0500, Sinan Kaya wrote:
> On 12/7/2017 7:40 AM, Sakari Ailus wrote:
> > On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> >> @@ -101,6 +103,8 @@ struct fwnode_operations {
> >>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
> >>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
> >>  				    struct fwnode_endpoint *endpoint);
> >> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
> >> +				struct device *dev);
> > 
> > You can make dev const, too.
> > 
> 
> done, I couldn't change device_get_match_data() parameter const due to
> dev_fwnode() function.
> 
>                  from /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:13:
> 
> /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:1341:39: warning: passing argument 1 of 'dev_fwnode' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,

Right. Makes sense.

I guess it's not perhaps worth it introducing dev_fwnode_const just for
this. devices are seldom if ever const anyway.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
