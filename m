From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Sat, 5 Feb 2005 19:07:17 -0500
Message-ID: <9e47339105020516072b33a9c6@mail.gmail.com>
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

After thinking about this for a while I believe the solution is for
bridges that implement a legacy space to export legacy_io/mem in
sysfs. So in the ia64 world, all bridges would export these attributes
since each bridge creates a unique legacy space.

In the x86 and I believe the ppc world, only host bridges create
legacy spaces and should have the legacy_io/mem attributes. All child
bridges should not export them.

This may be best handled by implementing bridge drivers. In my case I
need these:

Host needs to export a legacy io/mem space
8086:2578 - Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub

Child bridges do not export legacy space but implement VGA routing
8086:2579 - PCI bridge: Intel Corp. 82875P Processor to AGP Controller
8086:244e - PCI bridge: Intel Corp. 82801 PCI Bridge

I also have this..
8086:24d0 - ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge
But this is implementing the devices in the legacy space, it's the
host bridge that is creating the space.

Some questions...
1) Does the IA64 have child bridges that don't implement legacy space?
If so then they need to support VGA routing. What about Cardbus?
2) Does an IA64 bridge supporting different legacy spaces alter the
VGA io request to remove the offset and then send it out onto the bus?
3) How does all of this work with Opteron and Hypertransport?


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
