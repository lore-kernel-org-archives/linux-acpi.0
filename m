From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 11:33:45 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200302211133.45773.bjorn_helgaas@hp.com>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> 2) I'm not convinced that this buys a whole lot -- it just hides the code
> behind a macro (something that's not generally liked in the Linux world.)
> Would this procedure be called from more than one place?

I assume you're wondering about the value of this piece:

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn_helgaas-VXdhtT5mjnY@public.gmane.org] 
> Sent: Tuesday, February 11, 2003 1:58 PM
> ...
>     2) Addition of acpi_resource_to_address64(), which copies
>        address16, address32, or address64 resources to an address64
>        structure, so you don't have to maintain three sets of code
>        that differ only in the size of the address they deal with.

If so, decode_acpi_resource() in drivers/hotplug/acpiphp_glue.c is a
good example of why acpi_resource_to_address64() is useful.
decode_acpi_resource() contains a switch to handle 16-, 32-,
and 64-bit addresses.

So does acpi_get_crs_addr() in arch/ia64/kernel/acpi.c.  So will
my code to support multiple IO port space on IA64 (unless we
have something like acpi_resource_to_address64()).

None of these places really cares whether the address is 16, 32,
or 64 bits; they just have to have code to use the correct structure
type.  I'm proposing that we hide that ugliness in one place, and
most places can just deal with address64 and be done with it.

Bjorn
