From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Fri, 4 Feb 2005 17:59:47 -0500
Message-ID: <9e4733910502041459500ae8d3@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <200502041010.13220.jbarnes@engr.sgi.com>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502041010.13220.jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
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

On Fri, 4 Feb 2005 10:10:12 -0800, Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org> wrote:
> Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I
> added them for this very reason, though atm only ia64 supports them.  There's
> documentation in Documentation/filesystems/sysfs-pci.txt if you want to take

Can you build a no-op version of these that will run on the x86? That
would allow a single user space API for x86, ia64. Maybe the ppc
people will join too.

Why does this appear in /sys/class/pci_bus/0000:17/? For example on my
x86 system I have a single legacy space but if I do a dir of
/sys/class/pci_bus I show three buses. You wouldn't want the
legacy_io/mem attributes on each of these three buses since that
implies three independent address spaces.

[jonsmirl@jonsmirl pci_bus]$ ls /sys/class/pci_bus
0000:00  0000:01  0000:02

How would things be sorted out so that legacy_io/mem attributes only
appear on my root bridge chip 0000:00 and not on the child buses. I
guess this also means the user space app has to search through the bus
entries.

In order to know how many VGA many simultaneous VGA devices you can
have there needs to be some way to count the number of legacy address
spaces. Maybe there should be a /sys/class/legacy to describe the
legacy spaces. Is it possible to have the same legacy space aliased at
two different addresses depending on which root bus is used to get to
it?

I need to know how to answer these questions:
1) how many legacy spaces are there
2) how many VGA devices are in each space
3) how do I do VGA bus routing to access the VGA device
4) how do I address each of the devices.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
