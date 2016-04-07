From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH v2 0/3] Add ACPI support for pinctrl configuration
Date: Thu, 7 Apr 2016 15:56:34 +0300
Message-ID: <20160407125634.GO1727@lahna.fi.intel.com>
References: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459870406-15219-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Cristina Ciocan <cristina.ciocan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 05, 2016 at 06:33:23PM +0300, Irina Tirdea wrote:
> This is a proposal for adding ACPI support for pin controller
> configuration.
> 
> It has been developed to enable the MinnowBoard and IoT community
> by providing an easy way to specify pin multiplexing and
> pin configuration.
> 
> This proposal is based on using _DSD properties to specify device
> states and configuration nodes and it follows closely the device
> tree model. Device states are defined using the Device Properties
> format and the configuration nodes are defined using the
> Hierarchical Properties Extension format. The generic properties
> for the configuration nodes are the same as the ones for device
> tree, while pincontroller drivers can also define custom ones.
> 
> Changes from v1:
>  - address code review comments regarding coding style, documentation
> and fixes
>  - rewrote patch 3 ("pinctrl: Parse GpioInt/GpioIo resources") to
> avoid using triple pointers
>  - define pinconf_generic_dt_node_to_map since it is used by pinctrl
> sirf driver
>  - add dependency on PINCONF_GENERIC to the entire ACPI parsing code
>  - dropped first patch from the series since it got merged
> ("pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map")
> 
> Irina Tirdea (3):
>   pinctrl: pinconf-generic: Add ACPI support
>   pinctrl: Add ACPI support
>   pinctrl: Parse GpioInt/GpioIo resources

The series looks good to me now,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Of course this all depends on the decision whether this is the preferred
way of controlling and muxing pins in ACPI.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
