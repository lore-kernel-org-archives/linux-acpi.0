From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
Date: Thu, 7 Dec 2017 14:40:45 +0200
Message-ID: <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> @@ -101,6 +103,8 @@ struct fwnode_operations {
>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>  				    struct fwnode_endpoint *endpoint);
> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
> +				struct device *dev);

You can make dev const, too.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
