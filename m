From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: 01 Mar 2005 04:12:50 -0700
Message-ID: <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301015231.091b5329.akpm@osdl.org>
	<20050301105448.GG1345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050301105448.GG1345-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, barryn-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> writes:

> Yes, the patch is very ugly. If something like this needs to be done,
> then perhaps acpi should properly register into driver model and do
> the work there. This will also mean code will be called consistently.

I totally agree.  Do you have an example of how a non-device
can do this?

In particular something that gets as close to shutting down
the system devices as possible.  But gets called before that.

Or perhaps acpi should simply be setup to be the first system device?

Eric


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
