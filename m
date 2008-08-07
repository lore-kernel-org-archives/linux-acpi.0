From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 4/5] acpi: remove interpreter lock
Date: Thu, 7 Aug 2008 14:30:28 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3CE13CB@orsmsx415.amr.corp.intel.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com> <1218121178-13779-2-git-send-email-dwalker@mvista.com> <1218121178-13779-3-git-send-email-dwalker@mvista.com> <1218121178-13779-4-git-send-email-dwalker@mvista.com> <1218121178-13779-5-git-send-email-dwalker@mvista.com> <9D39833986E69849A2A8E74C1078B6B3CE1334@orsmsx415.amr.corp.intel.com> <1218143340.19162.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28650 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355AbYHGVa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 17:30:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1218143340.19162.40.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Yes, we lock the interpreter for major parts of control method execution
in order to implement the multithreading model of the ACPI
specification.

Here are a couple of sections from the ACPICA programmer reference that
explain the ACPICA multithreading, control method execution, reentrancy,
etc.


--------------------

2.2.5	Multitasking and Reentrancy
All components of the ACPI subsystem are intended to be fully reentrant
and support multiple threads of execution. To achieve this, there are
several mutual exclusion OSL interfaces that must be properly
implemented with the native host OS primitives to ensure that mutual
exclusion and synchronization can be performed correctly. Although
dependent on the correct implementation of these interfaces, the ACPI
Core Subsystem is otherwise fully reentrant and supports multiple
threads throughout the component, with the exception of the AML
interpreter, as explained below.

Because of the constraints of the ACPI specification, there is a major
limitation on the concurrency that can be achieved within the AML
interpreter portion of the subsystem. The specification states that at
most one control method can be actually executing AML code at any given
time. If a control method blocks (an event that can occur only under a
few limited conditions), another method may begin execution. However, it
can be said that the specification precludes the concurrent execution of
control methods. Therefore, the AML interpreter itself is essentially a
single-threaded component of the ACPI subsystem. Serialization of both
internal and external requests for execution of control methods is
performed and managed by the front-end of the interpreter.

And section 3.3.2
3.3.2	Control Method Execution
Most of the multithread support within the ACPI subsystem is implemented
using traditional locks and mutexes around critical (shared) data areas.
However, the AML interpreter design is different in that the ACPI
specification defines a special threading behavior for the execution of
control methods. The design implements the following portion of the ACPI
specification that defines a partially multithreaded AML interpreter in
four sentences:
A control method can use other internal, or well-defined, control
methods to accomplish the task at hand, which can include defined
control methods provided by the operating software. Interpretation of a
Control Method is not preemptive, but can block. When a control method
does block, the operating software can initiate or continue the
execution of a different control method. A control method can only
assume that access to global objects is exclusive for any period the
control method does not block.

3.3.2.1	Control Method Blocking
First of all, how can a control method block? This is a fairly
exhaustive list of the possibilities:
1.	Executes the Sleep() ASL opcode
2.	Executes the Acquire() ASL opcode and the request cannot be
immediately satisfied
3.	Executes the Wait() ASL opcode and the request cannot be
immediately satisfied
4.	Attempts to acquire the Global Lock (via Operation Region
access, etc), but must wait
5.	Attempts to execute a control method that is serialized and
already executing (or is blocked), or has reached its concurrency limit
6.	Invokes the host debugger via a write to the debug object or
executes the BreakPoint() ASL opcode
7.	Accesses an Operation Region which results in a dispatch to a
user-installed handler that blocks on I/O or other long-term operation
8.	A Notify AML opcode results in a dispatch to a user-installed
handler that blocks in a similar way


---------------------


The "handler" in question is the code that implements #7 above. A good
example of this is the EC operation region, which can be very slow.

Essentially, the implementation of 1-8 above is to unlock the
interpreter for the duration of the event.

There's more information about this in the ACPICA document, which is
available at

http://www.acpica.org/documentation/



>-----Original Message-----
>From: Daniel Walker [mailto:dwalker@mvista.com]
>Sent: Thursday, August 07, 2008 2:09 PM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org; Andi Kleen; Matthew Wilcox; Peter
Zijlstra;
>Zhao, Yakui; Dave Chinner; Ingo Molnar
>Subject: RE: [PATCH 4/5] acpi: remove interpreter lock
>
>On Thu, 2008-08-07 at 13:32 -0700, Moore, Robert wrote:
>> I believe the point was to allow the handler to execute methods, even
>> from other threads and to not block the interpreter for an unknown
>> amount of time.
>>
>
>Could you elaborate on this more, I'm not following you.. What do you
>mean by "handler"? The name "interpreter lock" to me sort of indicates
>that it's protecting the interpreter. So I'm guessing the point was to
>stop multiple threads from being inside the interpreter at once.
>
>If that's the case it doesn't make sense to release the mutex while
your
>inside the interpreter. That means another thread could then enter and
>the protection doesn't hold.
>
>It looked like most if the interpreter functions allocate their own
>memory, then use that memory without sharing it with other instances of
>the interpreter. So it's all contained into the one thread.
>
>You also have the mutexes embedded in the AML , which seem to indicate
>the AML is thread safe (might be a big assumption tho).
>
>Daniel

