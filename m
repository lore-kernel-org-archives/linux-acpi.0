From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/3] of/property: Add of_fwnode_name()
Date: Mon, 26 Nov 2018 15:05:32 +0200
Message-ID: <20181126130532.GH10650@smile.fi.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
 <20181126114752.69597-4-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126114752.69597-4-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 26, 2018 at 02:47:52PM +0300, Heikki Krogerus wrote:
> This implements get_name fwnode op for DT.

> +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
> +			      size_t len)
> +{
> +	snprintf(buf, len, "%pOFn", to_of_node(fwnode));

Same concerns.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
