From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Sat, 5 Feb 2005 19:17:14 -0500
Message-ID: <9e4733910502051617e34855b@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
	 <9e47339105020416486cf19738@mail.gmail.com>
	 <1107643352.30270.26.camel@gaston>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107643352.30270.26.camel@gaston>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 06 Feb 2005 09:42:32 +1100, Benjamin Herrenschmidt
<benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> wrote:
>  I think it could be as simple as an additional sysfs entry
> "legacy_enabled" added to all "VGA" devices in the system at the PCI
> layer level. Toggling it triggers the "untoggling" of all others,
> including VGA forwarding on bridges, and enables the path to that
> device. For in-kernel users, a pci_* API would work.
> 
> The problem I see though is that it should all be synchronous &
> spinlocked since the vgacon could want to grab at interrupt time (unless
> it's locked by userland, in which case, vgacon should cache & trigger an
> update later).

This is my current code it adds a vga entry to all VGA devices in the system.
http://kerneltrap.org/mailarchive/1/message/15974/flat

Instead of toggle there are four states:
1) off
2) on - make sure everything else is off
3) turn off all VGA devices and remember the active one
4) restore the active one

States 3 and 4 and used for running the reset program. Set state 3 to
remember the active device and turn it off, reset the card which will
enable it's VGA, disable it, set state 4 to restore the saved device.

This thread is active too:
Reliable video POSTing on resume

Restart video after resume is the same problem as posting it in the first place.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
