From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Date: Mon, 6 Jan 2003 17:26:48 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030106172648.GA1743@clara.net>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com> <3E196C17.7D318CAF@digeo.com> <20150000.1041857884@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150000.1041857884-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
To: Andrew McGregor <andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org>
Cc: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew McGregor [andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org] wrote:
> So *that* is why ACPI kernels are so slow on my laptop (Dell i8k), and make 
> so much heat.  I bet one of those threads ends up busy looping because of 
> other brokenness.

My laptop was a lot happier when I removed the GPE _L00 method from my
DSDT which was busylooping sending a processor 0x80 event.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Familiarity breeds contempt -- and children.
		-- Mark Twain
