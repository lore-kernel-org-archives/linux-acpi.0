From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Suggestion for improving the handling of GPE enabling.
Date: Thu, 10 Mar 2005 13:30:33 +0000
Message-ID: <1110461434.5918.202.camel@tyrosine>
References: <1110318037.3663.19.camel@desktop.cunningham.myip.net.au>
	 <1110331896.12642.16.camel@sli10-desk.sh.intel.com>
	 <20050309222122.GA32516@elf.ucw.cz>  <1110431446.9336.60.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110431446.9336.60.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-03-10 at 00:10 -0500, Len Brown wrote:
> On Wed, 2005-03-09 at 17:21, Pavel Machek wrote:
> 
> > > 4. ACPI devices are in many different physical buses. If we just define
> > > an ACPI bus, we possibly can't show the bus hierarchy.
> > 
> > Maybe ACPI device should be "under" real hardware one?
> 
> I suspect that the current sysfs device tree hierarchy is largely
> fiction and that Linux would be better served by taking advantage of the
> hierarchy embodied in the DSDT.
> 
> The "ACPI devices" such as power, sleep, lid as well as the battery are
> represented at the root level in the DSDT.

Are the ACPI HID names exposed to userspace yet? At the moment userspace
tools need to try loading every ACPI module. If the HIDs were exported
via sysfs and the ACPI drivers exported the devices they could bind to,
we could use hotplug to autoload the correct drivers.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
