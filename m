From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 10:25:18 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Bjorn Helgaas' <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


1) This seems like a good idea to simplify the parsing of the resource lists

2) I'm not convinced that this buys a whole lot -- it just hides the code
behind a macro (something that's not generally liked in the Linux world.)
Would this procedure be called from more than one place?

3) Fallout from (1), ok.

Bob


-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn_helgaas-VXdhtT5mjnY@public.gmane.org] 
Sent: Tuesday, February 11, 2003 1:58 PM
To: Grover, Andrew
Cc: t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org; linux-kernel@vger.kernel.org;
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] [PATCH] 1/3 ACPI resource handling

These patches against acpi-20030123-2.5.59.diff.gz make it more
convenient to handle ACPI resources and reduce code duplication.

The changes fall into three pieces:

    1) Addition of acpi_walk_resources(), which calls a callback for
       each resource in _CRS or _PRS.  This is handy because you don't
       have to allocate/free buffers, loop over resource lists, or
       make assumptions about the order in which resources appear.

    2) Addition of acpi_resource_to_address64(), which copies
       address16, address32, or address64 resources to an address64
       structure, so you don't have to maintain three sets of code
       that differ only in the size of the address they deal with.

    3) Changes to the EC, PCI link, and ACPI PCI hot-plug drivers to
       use acpi_walk_resources() instead of acpi_get_current_resources().

So far this is just "cleanup" in the sense that there's no new
functionality.  As soon as any issues with these patches are
worked out, I have additional patches that build on them to
add ia64 support for multiple I/O port spaces.

Bjorn
