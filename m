From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kacpidpc needs to die
Date: Wed, 8 Jan 2003 10:57:53 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A10C@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> For reasons discussed before [forking from timer is not safe, anyway],
> kacpidpc needs to die. Andrew, are you going to kill it or should I do
> it?

I can kill it...let me just verify with you --
acpi_os_queue_for_execution has a two block switch statement, just use
the first block (the case that uses schedule_work) and delete the rest,
yes?

Thanks -- Regards -- Andy
