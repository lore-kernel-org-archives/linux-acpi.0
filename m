From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Tue, 25 Feb 2003 09:57:44 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200302250957.44409.bjorn_helgaas@hp.com>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Good grief.  If people would actually read and think about the
change instead of having a knee-jerk reaction to seeing
"#define", they would see that inline functions will not work
in this particular application.  The macros were used to
factor code that was identical except that it operated on
different structure types.  Inline functions obviously require
explicit argument declarations, while macros don't, so macros
are the only choice for this type of factoring.

In any case, this horse has been long dead.  I've posted versions of
acpi_resource_to_address64() both with and without the macros, and
haven't heard any substantial objections, so I'm assuming the ACPI
folks will either ignore them or pick the one they like best and
we can move on.

Bjorn

On Monday 24 February 2003 3:48 pm, Moore, Robert wrote:
> Yes, as long as the code is used more than once (which it appears to be),
> then of course it should be procedurized.
> Bob
> 
> -----Original Message-----
> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> Sent: Sunday, February 23, 2003 2:55 PM
> To: Moore, Robert
> Cc: 'Bjorn Helgaas'; Grover, Andrew; Walz, Michael; t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-devel@lists.sourceforge.net
> Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
> 
> Hi!
> 
> > 1) This seems like a good idea to simplify the parsing of the resource
> lists
> > 
> > 2) I'm not convinced that this buys a whole lot -- it just hides the code
> > behind a macro (something that's not generally liked in the Linux world.)
> > Would this procedure be called from more than one place?
> 
> Well, reducing code duplication *is* liked in Linux world. Use inline
> function instead of macro if possible, through.
> 	
> Pavel
