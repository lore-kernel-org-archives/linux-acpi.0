From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device properties interface
Date: Tue, 23 Sep 2014 18:25:01 +0200
Message-ID: <2895905.coa5UvrkJk@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <CACRpkdaZJt_6cd1vtDw-Ys+YqUhNb0aXazUxGCX8mk4=6EmdHw@mail.gmail.com> <12538216.vu4CbU01qP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <12538216.vu4CbU01qP@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, September 23, 2014 05:45:57 PM Arnd Bergmann wrote:
> On Tuesday 23 September 2014 17:25:50 Linus Walleij wrote:
> > On Tue, Sep 16, 2014 at 1:52 PM, Mika Westerberg
> > <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > 
> > > Some drivers need to deal with only firmware representation of its
> > > GPIOs. An example would be a GPIO button array driver where each button
> > > is described as a separate firmware node in device tree. Typically these
> > > child nodes do not have physical representation in the Linux device
> > > model.
> > >
> > > In order to help device drivers to handle such firmware child nodes we
> > > add dev[m]_node_get_named_gpiod() that takes a firmware node pointer as
> > > parameter, finds the GPIO using whatever is the underlying firmware
> > > method, and requests the GPIO properly.
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > I have a hard time figuring out if this is what we want for common
> > accessors between DT and ACPI.
> > 
> > Can I get some input from Grant, Arnd, Mark, Darren...?
> 
> I just took a brief look at this. My first impression is that the
> fw_dev_node structure is weird when all callers just do (in patch 2)
> 
> +	struct fw_dev_node fdn = {
> +		.of_node = dev->of_node,
> +		.acpi_node = ACPI_COMPANION(dev),
> +	};
> 
> I'd much rather see an interface that passes the 'struct device'
> pointer down to dev_get_named_gpiod() and all other exported
> functions, and then internally does the conversion at the point
> where the access is done.

The problem is iteration over child nodes of a given one where there
may not be struct device objects.

For example (from patch [2/16]):

+int acpi_for_each_child_node(struct acpi_device *adev,
+                             int (*fn)(struct fw_dev_node *fdn, void *data),
+                             void *data)
+{
+       struct acpi_device *child;
+       int ret = 0;
+
+       list_for_each_entry(child, &adev->children, node) {
+               struct fw_dev_node fdn = { .acpi_node = child, };
+
+               ret = fn(&fdn, data);
+               if (ret)
+                       break;
+       }
+       return ret;
+}

and then fn() can be made work for both DTs and ACPI.  Without this we'd
need to have two versions of fn(), one for DTs and one for ACPI (and possibly
more for some other FW protocols), which isn't necessary in general (and
duplicates code etc.). 

That actually is used by some patches down in the series (eg. [10/16]).

Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
