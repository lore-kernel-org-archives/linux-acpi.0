From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device properties interface
Date: Tue, 23 Sep 2014 18:26:07 +0200
Message-ID: <2809308.3y5s7TV5Ip@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <12538216.vu4CbU01qP@wuerfel> <2895905.coa5UvrkJk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2895905.coa5UvrkJk-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 23 September 2014 18:25:01 Rafael J. Wysocki wrote:
> The problem is iteration over child nodes of a given one where there
> may not be struct device objects.
> 
> For example (from patch [2/16]):
> 
> +int acpi_for_each_child_node(struct acpi_device *adev,
> +                             int (*fn)(struct fw_dev_node *fdn, void *data),
> +                             void *data)
> +{
> +       struct acpi_device *child;
> +       int ret = 0;
> +
> +       list_for_each_entry(child, &adev->children, node) {
> +               struct fw_dev_node fdn = { .acpi_node = child, };
> +
> +               ret = fn(&fdn, data);
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> 
> and then fn() can be made work for both DTs and ACPI.  Without this we'd
> need to have two versions of fn(), one for DTs and one for ACPI (and possibly
> more for some other FW protocols), which isn't necessary in general (and
> duplicates code etc.). 
> 
> That actually is used by some patches down in the series (eg. [10/16]).
> 

Ok, I understand what you are doing now.

Looking at the example you point to (http://www.spinics.net/lists/devicetree/msg49502.html), I still feel
that this is adding more abstraction than what is good for us, and
I'd be happier with an implementation of gpio_leds_create() that
has a bit more duplication and less abstraction.

The important part should be that the driver-side interface is
sensible, other than that an implementation like

static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
{
	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
		return gpio_leds_create_of(pdev);
	else if (IS_ENABLED(CONFIG_ACPI))
		return gpio_leds_create_of(acpi);
	return ERR_PTR(-ENXIO);
}

would keep either side of it relatively simple, by leaving out the
indirect function calls and new for_each_available_child_of_node()
macro.

How many other users of fw_dev_node do you have at the moment?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
