From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Fri, 24 Oct 2008 10:41:06 -0600
Message-ID: <1224866466.6754.54.camel@localhost>
References: <1224702636.6784.13.camel@localhost>
	 <1224702749.6784.15.camel@localhost>
	 <1224810982.3945.22.camel@yakui_zhao.sh.intel.com>
	 <1224817633.6789.41.camel@localhost>
	 <1224826604.4055.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:23889 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYJXQlJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 12:41:09 -0400
In-Reply-To: <1224826604.4055.52.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 2008-10-24 at 13:36 +0800, Zhao Yakui wrote:
> On Thu, 2008-10-23 at 21:07 -0600, Myron Stowe wrote:
> > On Fri, 2008-10-24 at 09:16 +0800, Zhao Yakui wrote:
> > > On Wed, 2008-10-22 at 13:12 -0600, Myron Stowe wrote:
> > > > Declaring processors in ACPI namespace can be done using either a "Processor"
> > > > definition or a "Device" definition (see section 8.4 - Declaring Processors;
> > > > "Advanced Configuration and Power Interface Specification", Revision 3.0b).
> > > > Currently the two processor declaration types are conflated.
> > > In most cases there is no _UID object under the scope of processor
> > > namespace. So the current source can work well without adding the new
> > > HID("ACPI_CPU") for processor definition.
> > > 
> > > If there exists the _UID object under the scope of processor namespace,
> > > IMO the ProcessorID returned by _UID will have higher priority. In such
> > > case the patch can't work well.
> > 
> > According to section 5.2.11.13 "Local SAPIC Structure" - Local SAPIC to
> > processor object association uses the 'ProcessorID' for CPUs declared
> > with "Processor" statements and Local SAPIC to processor object
> > association for CPUs declared with "Device" statements use the '_UID'.
> > There is no "higher priority" - the association is fixed and must take
> > into account the type of CPU declaration - either "Processor" or
> > "Device" - to use the appropriate field - either 'ProcessorID' or '_UID'
> > - for the match.
> Agree with what you said. For the processor definition using Processor
> macro, we can get the ACPI ID by the processor block or _UID object (if
> it exists) and match it with the ACPI processor ID filed of LAPIC table
> or sapic table.
No, I do not believe this is correct.  For a processor defined in ACPI
namespace using the "Processor" statement type, it's 'ProcessorID' field
must be used to map to the Local SAPIC table entry regardless of whether
or not a '_UID' child object also appears.  The "Processor" statement's
'ProcessorID' field is used to match against the Local SAPIC table
entries 'ACPIProcessorID' field.  A '_UID' child object has no bearing
with respect to the mapping for "Processor" statement types.
>  
> If there is no _UID object under the scope of processor namespace, the
> current source code still can work well. In such case it is unnecessary
> to add a new HID. Of course it is harmless if you add it.
> > In example, the combinations of CPU declaration type used in combination
> > with whether or not the CPU declaration contains a _UID child object are
> >   "Processor" without a _UID child object (which our systems have)
> >   "Processor" with a _UID child object (which our systems have)
> It is very lucky that there exists such a system. Will you please
> confirm whether the ACPI ID returned by _UID object is consistent with
> the ACPI ID declared in the processor block?
Here is an small portion of the namespace of one our existing platforms
with this combination (by the way, this system is a HP SuperDome and has
been in the field for 7+ years now):

                    Processor (P002, 0x02, 0x00000000, 0x00)
                    {
                        Method (SSTA, 0, NotSerialized)
                        {
                            Return (0x0000000F)
                        }
        
                        Name (_SUN, 0x01)
                        Name (_STR, Unicode ("Location:00-FF-FF-00-FF-01-FF-11"))
                        Name (_UID, "0083f9b132089e43_HP_01_00_00")
                        Zero
                        Name (_PXM, 0x00)
                        Method (_MAT, 0, NotSerialized)
                        {
                            Return (Buffer (0x0C)
                            {
                                0x07, 0x0C, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00,
                                0x01, 0x00, 0x00, 0x00
                            })
        		...

This is a CPU defined using the "Processor" declaration statement.  This
CPU's 'ProcessorID' filed is '0x02' (the second argument).  Note also
the _MAT object that is basically just a copy of the MADT table's Local
SAPIC entry that corresponds to this CPU.  Decoding it yields (remember
little endian):
        Type: 0x07
        Length: 0x0C
        ACPI Processor ID: 0x02
        Local SAPIC ID: 0x04
        Local SAPIC EID: 0x00
        Reserved: 0x000000
        Flags: 0x00000001
        
> If they are the same value, any one can be used.
No, this is not true - even if they did happen to be the same value.
The "Processor" statement's 'ProcessorID' field (0x02) *must* be used to
match the Local SAPIC's 'ACPIProcessorID' field (0x02).  The '_UID'
child object has *no* bearing what so ever in these regards for
"Processor" statement's.
> If they are different, maybe we should confirm which one is correct.
Exactly - the spec is already pretty explicit about this.
> 
> The remaining issue is that _UID can return the string according to ACPI
> spec. If the _UID string is returned, it should be matched with the ACPI
> UID_string field of slapic table to get the APIC ID of processor. 
Yes, but *only* in the case of a processor defined using the "Device"
statement in namespace is the '_UID' field used to map to the Local
SAPIC entry (again, see the example above as it is this type of case).

This is basically the opposite case.  For a processor defined in ACPI
namespace using the "Device" statement type it's '_UID' field must be
used to map to the Local SAPIC table entry - the Local SAPIC's
'ACPIProcessorID' field has no bearing in this case.  The "Device"
statement's '_UID' field is used to match against the Local SAPIC table
entries '_UID' field with the complication that the '_UID' field can be
either an integer or a string.

As I indicated earlier, I chose not to cover this case as it became
complicated and there are currently no platforms that use this
combination yet.  I'm sure some will come at which time we will have to
address such a case.  As I also indicated earlier - the code will
currently 'printk' a message indicating that this exact scenario is has
occurred.
> 
> If you can confirm that the integer is returned by the _UID object under
> the scope of processor using device definition on your system, I think
> that your patch is OK. 
Yes - my testing of various platforms that cover three of the four
possible cases (the fourth case - a "Device" statement defined processor
without a '_UID' object - I believe is invalid) has shown that:
      * The code, as it currently is, panics on platforms that are now
        beginning to use the "Device" statement for declaring
        processors,
      * This patch series addresses this case and shows no regressions
        on existing platforms that use the other two cases.
> 
> Of course we should add such enhancement.
I hope this information now helps you understand the need for this
patch.
> 
> >   "Device" without a _UID child object
> >   "Device" with a _UID child object (which our systems now have)
> > In the "Processor" declarations the match to the Local SAPIC is based on
> > the 'ProcessorID' value regardless of whether or not there is a _UID
> > child object.  For "Device" declarations, the match to the Local SAPIC
> > is based on the '_UID' of the child object - so the third case above
> > ("Device" without a _UID child object) would be illegal.
> > 
> > 
> > This patch separates the type of CPU declaration that was encountered in
> > the namespace (the current code conflated them into a single #define).
> > The separation enables the mapping logic, that is done later, know
> > explicitly which CPU declaration type was used so that it can use the
> > proper field - 'ProcessorID' or '_UID' for the association.
> > 
> > If you do not agree with this interpretation of the spec then please let
> > me know where you believe I am wrong.
> > 
> > Myron
> > > 
> > > > 
> > > > This patch disambiguates the processor declaration's definition type enabling
> > > > subsequent code to behave uniquely based explicitly on the declaration's type.
> > > > 
> > > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > > CC: Alexey Starikovskiy <aystarik@gmail.com>
> > > > 
> > > > ---
> > > >  drivers/acpi/processor_core.c |    1 +
> > > >  drivers/acpi/scan.c           |    2 +-
> > > >  include/acpi/acpi_drivers.h   |    1 +
> > > >  3 files changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > Index: linux-2.6/drivers/acpi/processor_core.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-16 19:00:37.000000000 -0600
> > > > +++ linux-2.6/drivers/acpi/processor_core.c	2008-10-21 13:11:00.000000000 -0600
> > > > @@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(s
> > > >  
> > > > 
> > > >  static const struct acpi_device_id processor_device_ids[] = {
> > > > +	{ACPI_PROCESSOR_OBJECT_HID, 0},
> > > >  	{ACPI_PROCESSOR_HID, 0},
> > > >  	{"", 0},
> > > >  };
> > > > Index: linux-2.6/include/acpi/acpi_drivers.h
> > > > ===================================================================
> > > > --- linux-2.6.orig/include/acpi/acpi_drivers.h	2008-10-16 18:53:26.000000000 -0600
> > > > +++ linux-2.6/include/acpi/acpi_drivers.h	2008-10-20 13:23:28.000000000 -0600
> > > > @@ -41,6 +41,7 @@
> > > >   */
> > > >  
> > > >  #define ACPI_POWER_HID			"LNXPOWER"
> > > > +#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
> > > >  #define ACPI_PROCESSOR_HID		"ACPI0007"
> > > >  #define ACPI_SYSTEM_HID			"LNXSYSTM"
> > > >  #define ACPI_THERMAL_HID		"LNXTHERM"
> > > > Index: linux-2.6/drivers/acpi/scan.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/drivers/acpi/scan.c	2008-10-16 19:04:58.000000000 -0600
> > > > +++ linux-2.6/drivers/acpi/scan.c	2008-10-21 13:09:09.000000000 -0600
> > > > @@ -1025,7 +1025,7 @@ static void acpi_device_set_id(struct ac
> > > >  		hid = ACPI_POWER_HID;
> > > >  		break;
> > > >  	case ACPI_BUS_TYPE_PROCESSOR:
> > > > -		hid = ACPI_PROCESSOR_HID;
> > > > +		hid = ACPI_PROCESSOR_OBJECT_HID;
> > > >  		break;
> > > >  	case ACPI_BUS_TYPE_SYSTEM:
> > > >  		hid = ACPI_SYSTEM_HID;
> > > > 
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> 
-- 
Myron Stowe                             HP Open Source & Linux Org

