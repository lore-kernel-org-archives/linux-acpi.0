From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Mon, 31 Jan 2005 23:59:08 +0100
Message-ID: <20050131225908.GA1731@elf.ucw.cz>
References: <41FBDDE2.1050403@bartol.udel.edu> <1107097154.25905.22.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1107097154.25905.22.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, aj-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Eventually, the modified DSDTs can be put back into the ACPI4Linux 
> > database; but I'm more interested at the moment in ironing out any 
> > glitches in the code.
> 
> While this is a neat hack, there's no real way that distributions are
> ever going to adopt this approach - DSDTs are copyrighted by the
> vendors, and without permission they're not going to be distributed by
> the Linux vendors. The alternative approach of modifying the user's DSDT
> on the fly is likely to be excessively fragile. The only reasonable
> solution is to provide a mechanism to read the battery directly.

Actually, it is now time to call Acer saying "hey, Linux community
actually did the work for you; add this to your BIOS and your
batteries will start to work under Linux as control-method
batteries". It would help if you could release that DSDT part
under public domain; it is unlikely that Acer is going to put GPLed
part into their BIOS.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
