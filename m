From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 22:15:03 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030221221503.F19234@parcelfarce.linux.theplanet.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com> <200302211509.15641.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200302211509.15641.bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>; from bjorn_helgaas-VXdhtT5mjnY@public.gmane.org on Fri, Feb 21, 2003 at 03:09:15PM -0700
To: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 21, 2003 at 03:09:15PM -0700, Bjorn Helgaas wrote:
> Or, since you mention a macro, maybe your question is not about
> the usefulness of acpi_resource_to_address64() itself, but about
> how I implemented it, namely, with the copy_field and copy_address
> macros:

Can I suggest that you do a simple memcpy() for the case where you're
translating an address64 into an address64?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
