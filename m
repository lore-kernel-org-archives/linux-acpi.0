From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI sleep: stupid bug reintroduced
Date: Tue, 1 Oct 2002 15:41:03 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEE9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> There's extremely stupid bug in sleep.c -- it will only alow user to
> enter *unsupported* states. What's even worse that I remember fixing
> that once before, and *it was merged to mainline*.

Cough cough Pat... ;-)

It's (re-)fixed in my bk tree already. Didn't have this bit at the end so
I'll apply that.

Regards -- Andy

> +#else
> +	return_VALUE(-ENODEV);
>  #endif
