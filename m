From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Fri, 24 Oct 2008 13:36:44 +0800
Message-ID: <1224826604.4055.52.camel@yakui_zhao.sh.intel.com>
References: <1224702636.6784.13.camel@localhost>
	 <1224702749.6784.15.camel@localhost>
	 <1224810982.3945.22.camel@yakui_zhao.sh.intel.com>
	 <1224817633.6789.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39874 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbYJXFab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 01:30:31 -0400
In-Reply-To: <1224817633.6789.41.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: lenb@kernel.org, aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2008-10-23 at 21:07 -0600, Myron Stowe wrote:
> On Fri, 2008-10-24 at 09:16 +0800, Zhao Yakui wrote:
> > On Wed, 2008-10-22 at 13:12 -0600, Myron Stowe wrote:
> > > Declaring processors in ACPI namespace can be done using either a "Processor"
> > > definition or a "Device" definition (see section 8.4 - Declaring Processors;
> > > "Advanced Configuration and Power Interface Specification", Revision 3.0b).
> > > Currently the two processor declaration types are conflated.
> > In most cases there is no _UID object under the scope of processor
> > namespace. So the current source can work well without adding the new
> > HID("ACPI_CPU") for processor definition.
> > 
> > If there exists the _UID object under the scope of processor namespace,
> > IMO the ProcessorID returned by _UID will have higher priority. In such
> > case the patch can't work well.
> 
> According to section 5.2.11.13 "Local SAPIC Structure" - Local SAPIC to
> processor object association uses the 'ProcessorID' for CPUs declared
> with "Processor" statements and Local SAPIC to processor object
> association for CPUs declared with "Device" statements use the '_UID'.
> There is no "higher priority" - the association is fixed and must take
> into account the type of CPU declaration - either "Processor" or
> "Device" - to use the appropriate field - either 'ProcessorID' or '_UID'
> - for the match.
Agree with what you said. For the processor definition using Processor
macro, we can get the ACPI ID by the processor block or _UID object (if
it exists) and match it with the ACPI processor ID filed of LAPIC table
or sapic table. 
If there is no _UID object under the scope of processor namespace, the
current source code still can work well. In such case it is unnecessary
to add a new HID. Of course it is harmless if you add it.
> In example, the combinations of CPU declaration type used in combination
> with whether or not the CPU declaration contains a _UID child object are
>   "Processor" without a _UID child object (which our systems have)
>   "Processor" with a _UID child object (which our systems have)
It is very lucky that there exists such a system. Will you please
confirm whether the ACPI ID returned by _UID object is consistent with
the ACPI ID declared in the processor block?
If they are the same value, any one can be used. 
If they are different, maybe we should confirm which one is correct.

The remaining issue is that _UID can return the string according to ACPI
spec. If the _UID string is returned, it should be matched with the ACPI
UID_string field of slapic table to get the APIC ID of processor. 

If you can confirm that the integer is returned by the _UID object under
the scope of processor using device definition on your system, I think
that your patch is OK. 

Of course we should add such enhancement.

>   "Device" without a _UID child object
>   "Device" with a _UID child object (which our systems now have)
> In the "Processor" declarations the match to the Local SAPIC is based on
> the 'ProcessorID' value regardless of whether or not there is a _UID
> child object.  For "Device" declarations, the match to the Local SAPIC
> is based on the '_UID' of the child object - so the third case above
> ("Device" without a _UID child object) would be illegal.
> 
> 
> This patch separates the type of CPU declaration that was encountered in
> the namespace (the current code conflated them into a single #define).
> The separation enables the mapping logic, that is done later, know
> explicitly which CPU declaration type was used so that it can use the
> proper field - 'ProcessorID' or '_UID' for the association.
> 
> If you do not agree with this interpretation of the spec then please let
> me know where you believe I am wrong.
> 
> Myron
> > 
> > > 
> > > This patch disambiguates the processor declaration's definition type enabling
> > > subsequent code to behave uniquely based explicitly on the declaration's type.
> > > 
> > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > CC: Alexey Starikovskiy <aystarik@gmail.com>
> > > 
> > > ---
> > >  drivers/acpi/processor_core.c |    1 +
> > >  drivers/acpi/scan.c           |    2 +-
> > >  include/acpi/acpi_drivers.h   |    1 +
> > >  3 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/drivers/acpi/processor_core.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-16 19:00:37.000000000 -0600
> > > +++ linux-2.6/drivers/acpi/processor_core.c	2008-10-21 13:11:00.000000000 -0600
> > > @@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(s
> > >  
> > > 
> > >  static const struct acpi_device_id processor_device_ids[] = {
> > > +	{ACPI_PROCESSOR_OBJECT_HID, 0},
> > >  	{ACPI_PROCESSOR_HID, 0},
> > >  	{"", 0},
> > >  };
> > > Index: linux-2.6/include/acpi/acpi_drivers.h
> > > ===================================================================
> > > --- linux-2.6.orig/include/acpi/acpi_drivers.h	2008-10-16 18:53:26.000000000 -0600
> > > +++ linux-2.6/include/acpi/acpi_drivers.h	2008-10-20 13:23:28.000000000 -0600
> > > @@ -41,6 +41,7 @@
> > >   */
> > >  
> > >  #define ACPI_POWER_HID			"LNXPOWER"
> > > +#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
> > >  #define ACPI_PROCESSOR_HID		"ACPI0007"
> > >  #define ACPI_SYSTEM_HID			"LNXSYSTM"
> > >  #define ACPI_THERMAL_HID		"LNXTHERM"
> > > Index: linux-2.6/drivers/acpi/scan.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/scan.c	2008-10-16 19:04:58.000000000 -0600
> > > +++ linux-2.6/drivers/acpi/scan.c	2008-10-21 13:09:09.000000000 -0600
> > > @@ -1025,7 +1025,7 @@ static void acpi_device_set_id(struct ac
> > >  		hid = ACPI_POWER_HID;
> > >  		break;
> > >  	case ACPI_BUS_TYPE_PROCESSOR:
> > > -		hid = ACPI_PROCESSOR_HID;
> > > +		hid = ACPI_PROCESSOR_OBJECT_HID;
> > >  		break;
> > >  	case ACPI_BUS_TYPE_SYSTEM:
> > >  		hid = ACPI_SYSTEM_HID;
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

