From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: mem= option for broken bioses
Date: Wed, 26 Feb 2003 14:39:42 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> I've seen broken bios that did not mark acpi tables in e820
> tables. This allows user to override it. Please apply,

OK, looks reasonable. Can you also gen up a patch documenting this in
kernel-parameters.txt?

Thanks -- Regards -- Andy
