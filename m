From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Fri, 4 Feb 2005 19:48:45 -0500
Message-ID: <9e47339105020416486cf19738@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502041534.03004.jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > /sys/class/pci_bus I show three buses. You wouldn't want the
> > legacy_io/mem attributes on each of these three buses since that
> > implies three independent address spaces.
> >
> > [jonsmirl@jonsmirl pci_bus]$ ls /sys/class/pci_bus
> > 0000:00  0000:01  0000:02
> 
> In that case they'll all point to the same memory and I/O space.  On the
> machines I coded it on, each bus has its own space.

If they all point to the same space, I can't tell whether I have three
legacy spaces or one. I need to know how many legacy spaces there are
in order to know how many VGA cards can simultaneously be enabled.

> We might have to add more arch code in that case, but I thought it might be
> easiest for apps if they could just open the space for the bus they're
> interested in and it would be routed correctly.  I think that'll be ok so
> long as two apps aren't trying to do stuff on the bus at the same time.
> 
> > In order to know how many VGA many simultaneous VGA devices you can
> > have there needs to be some way to count the number of legacy address
> > spaces. Maybe there should be a /sys/class/legacy to describe the
> > legacy spaces. Is it possible to have the same legacy space aliased at
> > two different addresses depending on which root bus is used to get to
> > it?

What I meant by the questions is how can my video reset program ask
these questions, it needs to know the answers in order to properly
reset the VGA hardware.  There needs to be some way to figure out the
answers from sysfs info.

1) how many legacy spaces are there
no way to tell 
2) how many VGA devices are in each space
no way to tell, you need to know which legacy space each card is in
3) how do I do VGA bus routing to access the VGA device
I've posted code that starts doing this
4) how do I address each of the devices.
The routing code I posted needs to be update to handle multiple spaces.

For example I might have a machine with 3 spaces, 2 vga in #1, 1 in #2
and zero in #3. In that case I can have two active VGA's. My home
machine has one space and 2 vga's so I can have one active. There
needs to be enough info available to figure this out.

Or maybe the answer is simpler, if the legacy_io/mem attributes exist,
then you can assume each bus has it's own legacy space. If they don't
exist then there is a single legacy space. Is this a safe assumption?

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
