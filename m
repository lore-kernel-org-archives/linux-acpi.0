From: Andrew McGregor <andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Date: Tue, 07 Jan 2003 01:58:04 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20150000.1041857884@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
 <3E196C17.7D318CAF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3E196C17.7D318CAF-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
To: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



--On Monday, January 06, 2003 03:44:23 -0800 Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org> 
wrote:

> acpi_thermal_run is doing many sinful things.  Blocking memory
> allocations as well as launching kernel threads from within a
> timer handler.
>
> Converting it to use schedule_work() or schedule_delayed_work()
> would fix that up.

So *that* is why ACPI kernels are so slow on my laptop (Dell i8k), and make 
so much heat.  I bet one of those threads ends up busy looping because of 
other brokenness.
