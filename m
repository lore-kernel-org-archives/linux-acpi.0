From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Mon, 24 Feb 2003 14:48:06 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Bjorn Helgaas' <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Yes, as long as the code is used more than once (which it appears to be),
then of course it should be procedurized.
Bob


-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
Sent: Sunday, February 23, 2003 2:55 PM
To: Moore, Robert
Cc: 'Bjorn Helgaas'; Grover, Andrew; Walz, Michael; t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org;
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling

Hi!

> 1) This seems like a good idea to simplify the parsing of the resource
lists
> 
> 2) I'm not convinced that this buys a whole lot -- it just hides the code
> behind a macro (something that's not generally liked in the Linux world.)
> Would this procedure be called from more than one place?

Well, reducing code duplication *is* liked in Linux world. Use inline
function instead of macro if possible, through.
	
Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
