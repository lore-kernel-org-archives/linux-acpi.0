From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: constant processor 0x80 events
Date: Thu, 2 Jan 2003 22:52:41 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2b266$3bb85660$232202d3@sayonara>
References: <20030102101513.GA947@clara.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030102101513.GA947-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> THRT = Throttle?  Anyway, nothing in the DSDT updates that field.  Is
>> the OS supposed to?  Perhaps that is what the OS is supposed to
assert 
>> when it receives this message?  I hate groping in the dark :/
> 
> I've used THRT as the one shot flag in the meantime and I'll
> see how it goes.

"THRT = Throttle" sounds reasonable to me, too. Possibly Compaq BIOS
writer meant to make P1 the highest available P-State if CPU temp is
high && CPU is already duty-cycle throttled (Tx other than T0). I can't
be sure, though.

I also realized that nobody in your DSDT updates THRT, this could mean:
  - certain register is mapped to THRT and it will be implicitly updated
by hardware 
  or
  - Compaq (or template ASL code from Intel?) doesn't fully implement
this. 
Anyway your BIOS provides OS no information to update THRT field, in
that case OS should keep from poking around it. Only Compaq can tell you
the perfect/safest way to access it in your machine. (e.g. your hack in
DSDT could cause some side effects, or fatal system failure in the worst
case) 


>> The only time I've seen this is when the processor has been running 
>> at full pelt for some time - ie the CPU temp is high.  I would say 
>> that the processor is just trying to tell the OS to switch the 
>> processor state down 'cause it's hot.  Probably in the wrong way :)
>> 
>> I would say it's probably wrong to flood the system with these 
>> events.
>> 

Agree. Whatever the reason, what you're seeing is unexpected behavior
and it can shock Compaq BIOS writer. 

>> Is the event being sent as quickly as it can be received?  If so then

>> the action associated with the event should be run from the same 
>> thread or it will never be actioned.
>> 

But note that somehow OS can report these events to /proc entry, this
indicates it's not that much inrush. OS is always allowed to go through
the following 3 stages respectively in the different context.

1) ISR stage
+ events/evsci.c:acpi_ev_sci_handler()
  + events/evgpe.c:acpi_ev_gpe_detect()
    +                       acpi_ev_gpe_dispatch() ...
    
... calling osi.c:acpi_os_queue_for_execution() 
      to queue acpi_ev_asynch_execute_gpe_method() for later
scheduling/execution 

2) DPC stage
+ events/evgpe.c:acpi_ev_asynch_execute_gpe_method()
        :
    = parse/execute _L00 method = 
        :
    + executer/exoparg2.c:acpi_ex_opcode_2A_0T_0R()  // case
AML_NOTIFY_OP: 
      + event/evmisc.c:acpi_ev_queue_notify_request() ...

... calling osi.c:acpi_os_queue_for_execution() 
      to queue acpi_ev_notify_dispatch() for later scheduling/execution 

3) Notify handling stage (by processor driver)
+ event/evmisc.c:acpi_ev_notify_dispatch()
    :  
  + processor.c:acpi_processor_notify()  // case
ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
     +                  acpi_processor_get_platform_limit()  // evaluate
_PPC
     +                  acpi_processor_apply_limit()  // we always come
here as long as the above evaluation was successful 
     +         bus.c:acpi_bus_generate_event() // insert new event enrty
("processor / CPU0 / 0x80 / (RetVal of _PPC)") to /proc/acpi/event


>> Well, it does prevent the rush of messages but I don't think that's 
>> an
>> elegant solution.  How do other laptops report overheat request for 
>> Pstate change?

Requesting OS to reevaluate _PPC for thermal reason is somewhat new
concept in my understanding. Usually new idea comes from chipset vendor
and PC vendors tend to simply follow the sample supplied from chipset
vendor. 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
