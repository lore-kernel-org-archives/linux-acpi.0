From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Mon, 27 Oct 2008 15:42:37 +0800
Message-ID: <1225093357.5189.47.camel@yakui_zhao.sh.intel.com>
References: <1224702636.6784.13.camel@localhost>
	 <1224702749.6784.15.camel@localhost>
	 <1224810982.3945.22.camel@yakui_zhao.sh.intel.com>
	 <1224817633.6789.41.camel@localhost>
	 <1224826604.4055.52.camel@yakui_zhao.sh.intel.com>
	 <1224883385.6754.116.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51493 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbYJ0HgI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Oct 2008 03:36:08 -0400
In-Reply-To: <1224883385.6754.116.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "aystarik@gmail.com" <aystarik@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, John Keller <jpk@sgi.com>

On Fri, 2008-10-24 at 14:23 -0700, Myron Stowe wrote:
thanks for the detailed info and explanation.
Understand what you said and agree with your analysis.
There are some types of processor definitions.
   a. the processor is declared by using processor block in ACPI
namespace without _UID object.
      The ACPI ID is obtained from the processor block definition. 
      For example: processor(CPU0, 0x02, 0x810, 0x06). And the ACPI ID
is 0x02.
      Then the ACPI_id is matched with the ACPI processor ID field of
Local APIC table or SLAPIC table to get the processor APIC ID. (If the
SLAPIC table is used, the APIC id is obtained by the SAPIC_ID &
SAPIC_EID field).
     
      This case can be handled by your patch. This is handled by adding
the new HID("ACPI_CPU") for processor.
   b. the processor is declared by using processor block in ACPI
namespace with the _UID object. (For example: On your own system).
      It seems that the string is returned by the _UID object. In such
case we should continue to use the ACPI ID obtained by the ACPI
processor block. Of course the ACPI id is matched with the ACPI
processor ID field of LAPIC table or SLAPIC table.
      And what you have done is right. 
      
      Of course please add some comments that the ACPI ID is always
obtained from the processor block if the processor object is declared by
processor.
      
  c. the processor is declared by device with the HID
object("ACPI0007"). And the _UID object also exists.
     According to the spec the returned value of _UID can be an integer
or string.
     If the returned value is an integer, it is matched with the ACPI
processor UID field of SAPIC table to get the processor ID. And what you
have done is correct. And I agree with what you have done.
    
     If the returned value is a string, it should be matched with the
ACPI processor UID string field of SAPIC table to get the processor ID.
Now this case is not handled by your patch. Of course maybe there
doesn't exist such a system. So we can ask the user to send the ACPIdump
and then add the corresponding support when a string is returned by the
_UID object. It will be great if we can add the support about this.

  d. the processor is declared by the device with the HID
object("ACPI0007"). But there is no the _UID object. 
     This case is incorrect. And we can't get the ACPI processor ID.
     And this case can be handed by your patch. But IMO the debug info
is not enough.

     How about add the following debug info in your patch?
+       if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_HID)) {
+               union acpi_object *element;
+               struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER,
NULL };
                unsigned long long value;
-               status = acpi_evaluate_integer(pr->handle,
METHOD_NAME__UID,
-                                               NULL, &value);
+               if (!has_uid) {
+                       printk(KERN_ERR PREFIX "No _UID object for
ACPI0007"
+                               " device\n");
+                       return -ENODEV;
+               }
+               status = acpi_evaluate_object(pr->handle,
METHOD_NAME__UID,
+                                               NULL, &buffer);
                if (ACPI_FAILURE(status)) {
-                       printk(KERN_ERR PREFIX "Evaluating processor
_UID\n");
+                       printk(KERN_ERR PREFIX "Evaluating in _UID
object\n");
                        return -ENODEV;
                }
+               element = buffer->pointer;
// If we can match this string with the ACPI Processor UID string of
SAPIC table, it will be great.
+               if (element->type == ACPI_TYPE_STRING ||
+                       elememt->type == ACPI_TYPE_BUFFER) {
+                       printk(KERN_DEBUG PREFIX "a string is returned
by the"
+                               " _UID object of ACPI0007\n");
+                       kfree(buffer.pointer);
+                       return -ENODEV;
+               }
+               value =(unsigned long long)(element->integer.value);
+               device_declaration = 1;
                pr->acpi_id = value;

     
     
      
      

   
 

> Yakui:
> 
> After I encountered the issue that this patch series addresses I wrote
> up a synopsis in my notes.  I find that trying to write something down
> really helps uncover areas I think I am familiar with but may not really
> be.  Plus, I then have the notes for future reference.
> 
> Anyway, I really didn't plan on sending this out but here is my write up
> from encountering this issue initially.  Please take the time to read
> this and follow the code.  If you follow the examples carefully I
> believe that you will then come to the same conclusion that I did and
> thus then understand the need for this patch series.
> 
> Thanks for your questions as I'm sure others have had the exact same
> ones.
> 
> Myron
> 
> 
> SYNOPSIS (This is IA64 specific)
> 
> During early boot two tables are created which map Logical CPUs to the
> CPUs Physical {S}APIC ID.  These tables are 'smp_boot_data' and
> 'ia64_cpu_to_sapic[]'.
> 
>   arch/ia64/include/asm/smp.h::
>   extern struct smp_boot_data {
>         int cpu_count;
>         int cpu_phys_id[NR_CPUS];
>   } smp_boot_data __initdata;
> 
>   arch/ia64/kernel/smpboot.c::
>   /* which logical CPU number maps to which CPU (physical APIC ID) */
>   volatile int ia64_cpu_to_sapicid[NR_CPUS];
>   EXPORT_SYMBOL(ia64_cpu_to_sapicid);
> 
> A CPUs Physical {S}APIC ID, often referred to as the CPUs Physical ID,
> is obtained from the CPUs corresponding LOCAL APIC entry in the
> platform's MADT by concatinating the Logical ID and EID -
> "lid.f.id << 8 | lid.f.eid;".
> 
> During initialization arch/ia64/kernel/acpi.c::acpi_boot_init() is
> invoked which parses the MADT via acpi_parse_lsapic().
> acpi_parse_lsapic() sets up 'available_cpus', 'total_cpus', and
> 'smp_boot_data' which contains the 'cpu_phys_id[]' table.  Later, still
> within the acpi_boot_init() routine, smp_build_cpu_map() is invoked.
> smp_build_cpu_map() initializes the 'arch_cpu_to_apicid[]' (which for
> IA64 is 'ia64_cpu_to_sapicid[]) table using information from
> 'smp_boot_data'.
> 
>         acpi_boot_init()
>         {
>                 acpi_parse_lsapic();
>                 ...
>                 smp_build_cpu_map();
>         }
> 
> In the above initialization, 'boot_cpu_id' is handled specially -
>   arch/ia64/kernel/smpboot.c::smp_build_cpu_map()
>   int boot_cpu_id = hard_smp_processor_id();
> 
>   arch/ia64/include/asm/smp.h::
>   static inline unsigned int ia64_get_lid (void)
>   {
>         union {
>                 struct {
>                         unsigned long reserved : 16;
>                         unsigned long eid : 8;
>                         unsigned long id : 8;
>                         unsigned long ignored : 32;
>                 } f;
>                 unsigned long bits;
>         } lid;
> 
>         lid.bits = ia64_getreg(_IA64_REG_CR_LID);
>         return lid.f.id << 8 | lid.f.eid;
>   }
> 
>   #define hard_smp_processor_id()         ia64_get_lid()
> 
> The result of this setup running on our new system yields:
>   smp_build_cpu_map
>     arch_cpu_to_apicid[00] 0x0000
>     arch_cpu_to_apicid[01] 0x0100
>     arch_cpu_to_apicid[02] 0x0200
>     arch_cpu_to_apicid[03] 0x0300
>     arch_cpu_to_apicid[04] 0x1000
>     arch_cpu_to_apicid[05] 0x1100
>     arch_cpu_to_apicid[06] 0x1200
>     arch_cpu_to_apicid[07] 0x1300
>     arch_cpu_to_apicid[08] 0x0002
>     arch_cpu_to_apicid[09] 0x0102
>     arch_cpu_to_apicid[10] 0x0202
>     arch_cpu_to_apicid[11] 0x0302
>     arch_cpu_to_apicid[12] 0x1002
>     arch_cpu_to_apicid[13] 0x1102
>     arch_cpu_to_apicid[14] 0x1202
>     arch_cpu_to_apicid[15] 0x1302
>   16 CPUs available, 16 CPUs total
> 
> 
> Later in the kernel's boot processing 'acpi_processor_init()' is
> invoked.  Via object oriented obfuscation both 'acpi_processor_add()'
> and 'acpi_processor_start()' get invoked.  As part of
> 'acpi_processor_start()' processing 'acpi_processor_get_info()' is
> called to get processor specific information (all of which is in
> drivers/acpi/processor_core.c). 'acpi_processor_get_info()' is called
> with two parameters; a pointer to an 'acpi_processor' struct and a flag
> indicating whether or not the processor object has a _UID.  The latter
> _UID flag was set earlier in the boot process - presumably when the ACPI
> namespace was parsed.
> 
> The processor's _UID flag indicates which mechanism was used in the
> namespace for declaring the processor: the ASL Processor statement or
> ASL Device statement.  If the Device statement was used then the
> processor's 'acpi_id' is set to it's _UID value: 'pr->acpi_id = value;'.
> For Processor statement declarations the processor's 'acpi_id' is set to
> the ProcessorID value: 'pr->acpi_id = object.processor.proc_id;'.  With
> the processor's acpi_id ('pr->acpi_id') value obtained, 'get_cpu_id()'
> is called to get and set the corresponding Logical CPU ID
> ('cpu_index'/'pr->apic_id').
> 
> 'get_cpu_id()' first maps the processor's 'acpi_id' to the corresponding
> 'apic_id' using either the processor's _MAT ACPI entry if one exists or
> the platforms MADT ACPI table.  Either way, the entry/table is parsed
> for LOCAL_{S}APIC entries.  The parsing - 'map_lapic_id()' or
> 'map_lsapic_id()' - first checks the 'lapic_flags' field to see if the
> processor is ENABLED (non-enabled processors are ignored).  Next the
> 'processor_id' member is checked against the 'acpi_id' for a match (this
> checking takes into consideration _UID values for Local SAPIC entries:
>         /* First check against id */
>         if (lsapic->processor_id == acpi_id) {
>                 *apic_id = (lsapic->id << 8) | lsapic->eid;
>                 return 1;
>         /* Check against optional uid */
>         } else if (entry->length >= 16 && lsapic->uid == acpi_id) {
>                 *apic_id = lsapic->uid;
>                 return 1;
>         }
> Note that precedence was given to matching ASL Processor statement based
> declarations over ASL Device statement declarations (this precedence is
> the opposite of what was used in 'acpi_processor_get_info()').
> 
> If a 'processor_id' member match to the 'acpi_id' occurs, it is assigned
> to 'apic_id' and used to obtain the CPU's Logical ID.  This mapping
> utilizes the 'ia64_cpu_to_sapicid[]' table created earler in the
> kernel's boot processing.  Each possible CPU is checked to see if it's
> Physical ID matches the 'apic_id'.
>         for_each_possible_cpu(i) {
>                 if (cpu_physical_id(i) == apic_id)
>                         return i;
>         }
> 'cpu_physical_id' is an alias for the ia64_cpu_to_sapic[]' table -
>   #define cpu_physical_id(i) ia64_cpu_to_sapicid[i]):
> 
> So, there are at least three issues here:
>       * Both Processor statement and Device statement processor
>         declarations get conflated to 'ACPI0007'.  Code then later tries
>         to make the distinction bases solely on whether or not the
>         processor declaration's scope has a _UID object (i.e. Processor
>         statement declarations can have a _UID within the processor's
>         scope!).  This logic is not strict enough - it is *not*
>         comparing the correct components which is dependent on the
>         processor's declaration type.
>       * When mapping the 'acpi_id' the precidence is reversed from
>         before (i.e. initially precidence is given to _UID, subsequently
>         in the mapping it is not.  Actually this is pretty much a mute
>         point in that this type of logic is not strict enough as covered
>         above).
>       * In the mapping - map_lsapic_id() - the fall-through path
>         incorrectly returns the Local SAPIC _UID value and *not*
>         '(lsapic->id << 8) | lsapic->eid' and so the subsequent mapping
>         at the end of 'get_cpu_id' against the table set up at early
>         boot will *not* match (or worse - a false positive can occur).
> Basically what is occuring is the table 'ia64_cpu_to_sapicid[]' was
> correctly calculated using ID:EID and, in the case of Device statement
> declarations, the processor's _UID value is being used trying to
> match/map to the ID:EID value.
> 
> 
> As a concrete example, using our new system's FW, the MADT - when
> decoded - is basically:
> 
>   LogicalID               PhysicalID (ID:EID)   _UID
>   ----------------------------------------------------------
>   arch_cpu_to_apicid[00]  0x0000                0x00
>   arch_cpu_to_apicid[01]  0x0100                0x01
>   arch_cpu_to_apicid[02]  0x0200                0x02
>   arch_cpu_to_apicid[03]  0x0300                0x03
>   arch_cpu_to_apicid[04]  0x1000                0x04
>   arch_cpu_to_apicid[05]  0x1100                0x05
>   arch_cpu_to_apicid[06]  0x1200                0x06
>   arch_cpu_to_apicid[07]  0x1300                0x07
>   arch_cpu_to_apicid[08]  0x0002                0x10
>   arch_cpu_to_apicid[09]  0x0102                0x11
>   arch_cpu_to_apicid[0A]  0x0202                0x12
>   arch_cpu_to_apicid[0B]  0x0302                0x13
>   arch_cpu_to_apicid[0C]  0x1002                0x14
>   arch_cpu_to_apicid[0D]  0x1102                0x15
>   arch_cpu_to_apicid[0E]  0x1202                0x16
>   arch_cpu_to_apicid[0F]  0x1302                0x17
> 
> During early boot processing both the 'smp_boot_data' and
> 'ia64_cpu_to_sapic[]' table are initialized.  Both tables end up with a
> mapping of Logical Processor ID to Physical {S}APIC ID as shown above
> (at this point ignore the _UID column).  In example, Logical CPU 0x0B's
> entry contains the processor's correspoding Local APIC ID of 0x0302.
> 
> Next, 'acpi_processor_get_info()' is called with it's second argument
> indicating the processor object contains a _UID method (the implication
> being that the ACPI namespace processor declaration used the AML Device
> statement [is this necessarly true - i.e. can a processor statement have
> a _UID method within it's scope?]).  'acpi_processor_get_info()' gives
> precedence to the _UID and so calls 'get_cpu_id()' with the processor's
> _UID as the 'acpi_id'.  Continuing the example, 'get_cpu_id()' is called
> on behalf of Logical processor 0xB with a _UID value of 0x13.
>         Device (P00B)
>         {
>                 Name (_HID, "ACPI0007")
>                 Name (_UID, 0x00000013)
>                 ...
>                 Method (_MAT, 0, NotSerialized)
>                 {
>                     Return (Buffer (0x10)
>                     {
>                         0x07, 0x10, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00,
>                         0x01, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00, 0x00
>                     })
>                 }
> 
> 'get_cpu_id()' attempts to map the 'acpi_id' of 0x13 to the
> corresponding _MAT entries PhysicalID - 0x0302 - which does not match.
> Next an attempt to map the 'acpi_id' to the _MAT entries _UID - 0x13 -
> which does match so 'apic_id' is set to 0x13.  The final step of mapping
> the 'apic_id' to a Logical CPU ID is attempted by parsing all the
> possible CPUS via the 'arch_cpu_to_apicid[]' table entries is made but
> no 'arch_cpu_to_apicid[]' entry value is 0x13!
> 
> Note that a "false positive" can be obtained - follow the same steps
> using the values corresponding to Logical CPU 0x02 whose _UID value ix
> 0x2.  The code will produce an incorrect Logical CPU value of 0x08!
> 
> >
> > Of course we should add such enhancement.
> >
> > >   "Device" without a _UID child object
> > >   "Device" with a _UID child object (which our systems now have)
> > > In the "Processor" declarations the match to the Local SAPIC is based on
> > > the 'ProcessorID' value regardless of whether or not there is a _UID
> > > child object.  For "Device" declarations, the match to the Local SAPIC
> > > is based on the '_UID' of the child object - so the third case above
> > > ("Device" without a _UID child object) would be illegal.
> > >
> > >
> > > This patch separates the type of CPU declaration that was encountered in
> > > the namespace (the current code conflated them into a single #define).
> > > The separation enables the mapping logic, that is done later, know
> > > explicitly which CPU declaration type was used so that it can use the
> > > proper field - 'ProcessorID' or '_UID' for the association.
> > >
> > > If you do not agree with this interpretation of the spec then please let
> > > me know where you believe I am wrong.
> > >
> > > Myron
> > > >
> > > > >
> > > > > This patch disambiguates the processor declaration's definition type enabling
> > > > > subsequent code to behave uniquely based explicitly on the declaration's type.
> > > > >
> > > > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > > > CC: Alexey Starikovskiy <aystarik@gmail.com>
> > > > >
> > > > > ---
> > > > >  drivers/acpi/processor_core.c |    1 +
> > > > >  drivers/acpi/scan.c           |    2 +-
> > > > >  include/acpi/acpi_drivers.h   |    1 +
> > > > >  3 files changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > Index: linux-2.6/drivers/acpi/processor_core.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/drivers/acpi/processor_core.c        2008-10-16 19:00:37.000000000 -0600
> > > > > +++ linux-2.6/drivers/acpi/processor_core.c     2008-10-21 13:11:00.000000000 -0600
> > > > > @@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(s
> > > > >
> > > > >
> > > > >  static const struct acpi_device_id processor_device_ids[] = {
> > > > > +       {ACPI_PROCESSOR_OBJECT_HID, 0},
> > > > >         {ACPI_PROCESSOR_HID, 0},
> > > > >         {"", 0},
> > > > >  };
> > > > > Index: linux-2.6/include/acpi/acpi_drivers.h
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/include/acpi/acpi_drivers.h  2008-10-16 18:53:26.000000000 -0600
> > > > > +++ linux-2.6/include/acpi/acpi_drivers.h       2008-10-20 13:23:28.000000000 -0600
> > > > > @@ -41,6 +41,7 @@
> > > > >   */
> > > > >
> > > > >  #define ACPI_POWER_HID                 "LNXPOWER"
> > > > > +#define ACPI_PROCESSOR_OBJECT_HID      "ACPI_CPU"
> > > > >  #define ACPI_PROCESSOR_HID             "ACPI0007"
> > > > >  #define ACPI_SYSTEM_HID                        "LNXSYSTM"
> > > > >  #define ACPI_THERMAL_HID               "LNXTHERM"
> > > > > Index: linux-2.6/drivers/acpi/scan.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/drivers/acpi/scan.c  2008-10-16 19:04:58.000000000 -0600
> > > > > +++ linux-2.6/drivers/acpi/scan.c       2008-10-21 13:09:09.000000000 -0600
> > > > > @@ -1025,7 +1025,7 @@ static void acpi_device_set_id(struct ac
> > > > >                 hid = ACPI_POWER_HID;
> > > > >                 break;
> > > > >         case ACPI_BUS_TYPE_PROCESSOR:
> > > > > -               hid = ACPI_PROCESSOR_HID;
> > > > > +               hid = ACPI_PROCESSOR_OBJECT_HID;
> > > > >                 break;
> > > > >         case ACPI_BUS_TYPE_SYSTEM:
> > > > >                 hid = ACPI_SYSTEM_HID;
> > > > >
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >
> >
> --
> Myron Stowe                             HP Open Source & Linux Org
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

