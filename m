From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 15:36:51 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200302211536.51368.bjorn_helgaas@hp.com>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com> <200302211509.15641.bjorn_helgaas@hp.com> <20030221221503.F19234@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030221221503.F19234-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 21 February 2003 3:15 pm, Matthew Wilcox wrote:
> On Fri, Feb 21, 2003 at 03:09:15PM -0700, Bjorn Helgaas wrote:
> > Or, since you mention a macro, maybe your question is not about
> > the usefulness of acpi_resource_to_address64() itself, but about
> > how I implemented it, namely, with the copy_field and copy_address
> > macros:
> 
> Can I suggest that you do a simple memcpy() for the case where you're
> translating an address64 into an address64?

I suppose we could.  Or maybe we should just get to the root of the
thing and make a generic acpi_resource_address structure and never
even expose the 16, 32, and 64 bit variants.  As far as I can tell,
they just make life difficult for consumers.

Then acpi_rs_address16_resource(), acpi_rs_address32_resource(),
and acpi_rs_address64_resource() could be collapsed into one function
with pretty trivial checks for the different sizes.  And there's lots
of similar collapsing that could be done.  I bet we'd even find one
or two defects in the process of removing all the duplicated code.

Of course, I guess that would change the CA interface, so that
constrains things a bit.

Bjorn
