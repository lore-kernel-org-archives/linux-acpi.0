From: Folkert van Heusden <appel-Beo89p9qyDM6GGFevw1D/A@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Mon, 24 Feb 2003 21:48:35 +0100 (CET)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302242146420.16778-100000@muur.intranet.vanheusden.com>
References: <20030223225439.GC120@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030223225439.GC120-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Bjorn Helgaas' <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > 1) This seems like a good idea to simplify the parsing of the resource lists
> > 2) I'm not convinced that this buys a whole lot -- it just hides the code
> > behind a macro (something that's not generally liked in the Linux world.)
> > Would this procedure be called from more than one place?
> Well, reducing code duplication *is* liked in Linux world. Use inline
> function instead of macro if possible, through.

Isn't it better to use functions instead of macro's? Reduces the code
size--> less dirty cache-lines.

I saw, by the way, several functions duplicated in the networking-code.
For example a lot of them have a net_random-alike function. Imho they
should use the net_random in utils.c. Sadly my patches were ignored by the
maintainers.


Folkert
