From: John Keller <jpk@sgi.com>
Subject: Re: [PATCH 2/3] ACPI: Behave uniquely based on processor
Date: Fri, 24 Oct 2008 13:42:08 -0500 (CDT)
Message-ID: <200810241842.m9OIg9TW216954@fcbayern.americas.sgi.com>
References: <1224868300.6754.76.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:42629 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751518AbYJXSmO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 14:42:14 -0400
In-Reply-To: <1224868300.6754.76.camel@localhost> from "Myron Stowe" at Oct 24, 2008 11:11:40 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: John Keller <jpk@sgi.com>, lenb@kernel.org, aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>

> 
> On Fri, 2008-10-24 at 10:56 -0500, John Keller wrote:
> > > 
> > > 
> > > Associating a Local SAPIC with a processor object is dependent upon the
> > > processor object's definition type.  CPUs declared as "Processor" should use
> > > the Local SAPIC's 'processor_id', and CPUs declared as "Device" should use the
> > > 'uid' (see section 5.2.11.13 - Local SAPIC Structure; "Advanced Configuration
> > > and Power Interface Specification", Revision 3.0b).  
> > > 
> > > This patch changes the lsapic mapping logic to rely on the distinction of
> > > how the processor object was declared - the mapping can't just try both types
> > > of matches irregardless of declaration type and rely on one failing as is
> > > currently being done.
> > > 
> > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > CC: Alexey Starikovskiy <aystarik@gmail.com>
> > > 
> > > ---
> > >  drivers/acpi/processor_core.c |   64 +++++++++++++++++++++++-------------------
> > >  1 file changed, 36 insertions(+), 28 deletions(-)
> > > 
> > > Index: linux-2.6/drivers/acpi/processor_core.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-21 13:12:13.000000000 -0600
> > > +++ linux-2.6/drivers/acpi/processor_core.c	2008-10-22 12:12:11.000000000 -0600
> > > @@ -410,7 +410,7 @@ static int acpi_processor_remove_fs(stru
> > >  /* Use the acpiid in MADT to map cpus in case of SMP */
> > >  
> > >  #ifndef CONFIG_SMP
> > > -static int get_cpu_id(acpi_handle handle, u32 acpi_id) {return -1;}
> > > +static int get_cpu_id(acpi_handle handle, int type, u32 acpi_id) { return -1; }
> > >  #else
> > >  
> > >  static struct acpi_table_madt *madt;
> > > @@ -429,27 +429,33 @@ static int map_lapic_id(struct acpi_subt
> > >  }
> > >  
> > >  static int map_lsapic_id(struct acpi_subtable_header *entry,
> > > -		  u32 acpi_id, int *apic_id)
> > > +		int device_declaration, u32 acpi_id, int *apic_id)
> > >  {
> > >  	struct acpi_madt_local_sapic *lsapic =
> > >  		(struct acpi_madt_local_sapic *)entry;
> > > +	u32 tmp = (lsapic->id << 8) | lsapic->eid;
> > > +
> > >  	/* Only check enabled APICs*/
> > > -	if (lsapic->lapic_flags & ACPI_MADT_ENABLED) {
> > > -		/* First check against id */
> > > -		if (lsapic->processor_id == acpi_id) {
> > > -			*apic_id = (lsapic->id << 8) | lsapic->eid;
> > > -			return 1;
> > > -		/* Check against optional uid */
> > > -		} else if (entry->length >= 16 &&
> > > -			lsapic->uid == acpi_id) {
> > > -			*apic_id = lsapic->uid;
> > > -			return 1;
> > > -		}
> > > -	}
> > > +	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
> > > +		return 0;
> > > +
> > > +	/* Device statement declaration type */
> > > +	if (device_declaration) {
> > > +		if (entry->length < 16)
> > > +			printk(KERN_ERR PREFIX "Invalid Local SAPIC structure corresponding to Device statement processor with SAPIC ID %#x\n", tmp);
> > > +		else if (lsapic->uid == acpi_id)
> > > +			goto found;
> > > +	/* Processor statement declaration type */
> > > +	} else if (lsapic->processor_id == acpi_id)
> > > +		goto found;
> > > +
> > >  	return 0;
> > > +found:
> > > +	*apic_id = tmp;
> > > +	return 1;
> > >  }
> > 
> > If I read this right, lsapic->uid and acpi_id (Processor Device _UID)
> > no longer need to equal (lsapic->id << 8) | lsapic->eid), as now 'tmp'
> > will be the value returned.
> > Is this correct?
> Yes.
> > I don't know of a problem with this, just making sure I understand this.
> Yeah - there were problems  ;)
> 
> What I think you might be getting at is that there are two possible
> explanations for why this logic has been working till now:
>       * There have been platforms using the "Device" declaration but the
>         firmware must have went through great pains to ensure that all
>         these fields involved *artificially* matched (which is what I
>         believe you are alluding to and I believe is a misunderstanding
>         of the spec if that was the case).

Yes, this is what motivated my questions.
As part of testing firmware support for an upcoming platform, where
"Device" declarations will be used, I quickly learned that currently
all these fields need to match.

Thanks for the reply,
John


>   - or -
>       * There have been no platforms using the "Device" declaration and
>         so map_lsapic_id()'s 'if (lsapic->processor_id == acpi_id)' was
>         always succeeding and the 'else if ...' path was never taken. I
>         tend to believe this has been the case (but that is pure
>         assumption which means little).
> > 
> > Glad to see this change, as I had concerns of map_lsapic_id() first
> > trying to match against lsapic->processor_id, and possibly ignoring
> > lsapic->uid.
> Yes - the logic as it currently is, is not specific/strict enough.  What
> I seem to be failing to be able to express well enough earlier in the
> thread is basically this:
> 
>         CPUs declared in namespace using a "Processor" statement must
>         use the "Processor" statement's 'ProcessorID' field to match to
>         the corresponding Local SAPIC entry (matching the Local SAPIC
>         entries 'ACPIProcessorID' field).  Whether or not the
>         "Processor" statement has a '_UID' child object has no bearing
>         with respect to the mapping.
>         
>         Conversely, CPUs declared in namespace using a "Device"
>         statement must use the "Device" statement's '_UID' child object
>         field to match to the corresponding Local SAPIC entry (matching
>         the Local SAPIC entries '_UID' field).
>         
> At least this is how we are interpreting section 5.2.11.13 "Local SAPIC
> Structure" of the specification (specifically see the Description for
> both ACPI Processor ID and ACPI Processor UID Value).
> 
> Thanks for your query!
> Myron
> > 
> > Thanks,
> > John
> > 
> > 
> > 
> > >  
> > > -static int map_madt_entry(u32 acpi_id)
> > > +static int map_madt_entry(int type, u32 acpi_id)
> > >  {
> > >  	unsigned long madt_end, entry;
> > >  	int apic_id = -1;
> > > @@ -470,7 +476,7 @@ static int map_madt_entry(u32 acpi_id)
> > >  			if (map_lapic_id(header, acpi_id, &apic_id))
> > >  				break;
> > >  		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
> > > -			if (map_lsapic_id(header, acpi_id, &apic_id))
> > > +			if (map_lsapic_id(header, type, acpi_id, &apic_id))
> > >  				break;
> > >  		}
> > >  		entry += header->length;
> > > @@ -478,7 +484,7 @@ static int map_madt_entry(u32 acpi_id)
> > >  	return apic_id;
> > >  }
> > >  
> > > -static int map_mat_entry(acpi_handle handle, u32 acpi_id)
> > > +static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> > >  {
> > >  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > >  	union acpi_object *obj;
> > > @@ -501,7 +507,7 @@ static int map_mat_entry(acpi_handle han
> > >  	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
> > >  		map_lapic_id(header, acpi_id, &apic_id);
> > >  	} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
> > > -		map_lsapic_id(header, acpi_id, &apic_id);
> > > +		map_lsapic_id(header, type, acpi_id, &apic_id);
> > >  	}
> > >  
> > >  exit:
> > > @@ -510,14 +516,14 @@ exit:
> > >  	return apic_id;
> > >  }
> > >  
> > > -static int get_cpu_id(acpi_handle handle, u32 acpi_id)
> > > +static int get_cpu_id(acpi_handle handle, int type, u32 acpi_id)
> > >  {
> > >  	int i;
> > >  	int apic_id = -1;
> > >  
> > > -	apic_id = map_mat_entry(handle, acpi_id);
> > > +	apic_id = map_mat_entry(handle, type, acpi_id);
> > >  	if (apic_id == -1)
> > > -		apic_id = map_madt_entry(acpi_id);
> > > +		apic_id = map_madt_entry(type, acpi_id);
> > >  	if (apic_id == -1)
> > >  		return apic_id;
> > >  
> > > @@ -533,15 +539,16 @@ static int get_cpu_id(acpi_handle handle
> > >                                   Driver Interface
> > >     -------------------------------------------------------------------------- */
> > >  
> > > -static int acpi_processor_get_info(struct acpi_processor *pr, unsigned has_uid)
> > > +static int acpi_processor_get_info(struct acpi_device *device)
> > >  {
> > >  	acpi_status status = 0;
> > >  	union acpi_object object = { 0 };
> > >  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
> > > -	int cpu_index;
> > > +	struct acpi_processor *pr;
> > > +	int cpu_index, device_declaration = 0;
> > >  	static int cpu0_initialized;
> > >  
> > > -
> > > +	pr = acpi_driver_data(device);
> > >  	if (!pr)
> > >  		return -EINVAL;
> > >  
> > > @@ -562,8 +569,8 @@ static int acpi_processor_get_info(struc
> > >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > >  				  "No bus mastering arbitration control\n"));
> > >  
> > > -	/* Check if it is a Device with HID and UID */
> > > -	if (has_uid) {
> > > +	/* Check if it is a Device statement declaration with HID and UID */
> > > +	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_HID)) {
> > >  		unsigned long value;
> > >  		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
> > >  						NULL, &value);
> > > @@ -571,6 +578,7 @@ static int acpi_processor_get_info(struc
> > >  			printk(KERN_ERR PREFIX "Evaluating processor _UID\n");
> > >  			return -ENODEV;
> > >  		}
> > > +		device_declaration = 1;
> > >  		pr->acpi_id = value;
> > >  	} else {
> > >  		/*
> > > @@ -590,7 +598,7 @@ static int acpi_processor_get_info(struc
> > >  		*/
> > >  		pr->acpi_id = object.processor.proc_id;
> > >  	}
> > > -	cpu_index = get_cpu_id(pr->handle, pr->acpi_id);
> > > +	cpu_index = get_cpu_id(pr->handle, device_declaration, pr->acpi_id);
> > >  
> > >  	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
> > >  	if (!cpu0_initialized && (cpu_index == -1) &&
> > > @@ -662,7 +670,7 @@ static int __cpuinit acpi_processor_star
> > >  
> > >  	pr = acpi_driver_data(device);
> > >  
> > > -	result = acpi_processor_get_info(pr, device->flags.unique_id);
> > > +	result = acpi_processor_get_info(device);
> > >  	if (result) {
> > >  		/* Processor is physically not present */
> > >  		return 0;
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> -- 
> Myron Stowe                             HP Open Source & Linux Org
> 
> 

