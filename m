From: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Sat, 5 Feb 2005 16:19:57 -0800
Message-ID: <200502051619.57639.jbarnes@sgi.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502041534.03004.jbarnes@engr.sgi.com> <9e47339105020516072b33a9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105020516072b33a9c6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, February 05, 2005 4:07 pm, Jon Smirl wrote:
> After thinking about this for a while I believe the solution is for
> bridges that implement a legacy space to export legacy_io/mem in
> sysfs. So in the ia64 world, all bridges would export these attributes
> since each bridge creates a unique legacy space.

Except some ia64 platforms don't have one legacy space per host bus like sn2 
does.

> Some questions...
> 1) Does the IA64 have child bridges that don't implement legacy space?

Yes, on sn2 each host<->pci bridge has two busses hanging off it, and each of 
them has its own legacy space.  Child bridges under that bus are routed 
according to the child bridge, which may not route legacy accesses.

> If so then they need to support VGA routing. What about Cardbus?

No ia64 boxes that I know of support cardbus.

> 2) Does an IA64 bridge supporting different legacy spaces alter the
> VGA io request to remove the offset and then send it out onto the bus?

Pretty much, yes.

> 3) How does all of this work with Opteron and Hypertransport?

Don't know, Andi probably does.

Jesse


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
