From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/9] Making the generic ACPI GSI layer irqdomain aware
Date: Tue, 29 Sep 2015 12:11:11 -0500
Message-ID: <CAL_Jsq+b10aEREipSsrg69=S4gpv-xZWRYS+TVTvhbqdHGATsA@mail.gmail.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tomasz.nowicki-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, Graeme Gregory <graeme-/SyDAi3Rz4f10XsdtD+oqA@public.gmane.org>, Jake Oshins <jakeo-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 28, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
> The irqdomain code is not entierely ACPI friendly, as it has some
> built-in knowledge of the device-tree. Nothing too harmful, but enough
> to scare the ARM ACPI developpers which end up with their own version
> of the square wheel.
>
> This small patch series adapts the irqdomain code to remove the
> hurdles that prevent the full blown irqdomain subsystem to be used on
> ACPI, creates an interface between the GSI layer and the irqdomain,
> and as an example, convert the ARM GIC ACPI support to use irqdomains
> as originally intended.
>
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure. The
> "convert the GSI information to be DT friendly" is admitedly not very
> pretty, but I see it as a stepping stone towards unifying the two
> structures.

Did I miss v1-v3 or did the DT change just show up? I probably tuned
out with ACPI in the subject.

Needing fake DT nodes for ACPI is just wrong. There's got to be
another, better way.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
