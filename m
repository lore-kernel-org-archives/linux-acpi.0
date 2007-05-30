From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: AML method concurrency
Date: Wed, 30 May 2007 21:27:02 +0400
Message-ID: <465DB3E6.5050207@gmail.com>
References: <200705291454.27905.bjorn.helgaas@hp.com> <465D29C4.20707@gmail.com> <200705301011.46724.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:60336 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbXE3R1L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 May 2007 13:27:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so240631ugf
        for <linux-acpi@vger.kernel.org>; Wed, 30 May 2007 10:27:09 -0700 (PDT)
In-Reply-To: <200705301011.46724.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Bjorn Helgaas ?????:
> On Wednesday 30 May 2007 01:37:40 am Alexey Starikovskiy wrote:
>> There is a "limited concurrency" in interpreter.
>> There is a "executor" semaphore(acpi_ex_{enter/exit}_interpreter), which
>> prevents generic concurrent execution of methods, but in the case of the
>> method blocking (mutex or sleep) it will be released and reacquired
>> after, thus allowing some other method to run during block.
> 
> That's good information on the Intel CA implementation.  Do we know
> what other implementations do?
Essentially there is only one _other_ implementation and by some rumors
it was not allowing execution of methods in parallel at all, so
acpi_serialize was introduced to copy that behavior.
> 
> Is there language in the ACPI spec itself that precludes concurrent
> execution?
This spec should be taken with some caution, because the _other_
implementation, on which BIOS vendors _do_ check their code, does not
follow every letter of it... And we could only guess how they choose to
deviate from it in every case.

> 
> How exactly is the "acpi_serialize" Linux option useful?  If the
> ACPI_MTX_INTERPRETER mutex prevents concurrency already, what good
> is "acpi_serialize"?
Without acpi_serialize there is some degree of concurrency, as I
explained earlier. So acpi_serialize does not allow methods to execute
while some method is blocked.
> 
>> Bjorn Helgaas ?????:
>>> Can AML methods be executed concurrently?
>>>
>>> The existence of mutexes, serialized methods, and the Linux
>>> "acpi_serialize" parameter makes me think that in general, we
>>> should be able to execute multiple AML methods concurrently.
>>>
>>> However, the ACPI CA Programmer Reference, rev 1.16, section 2.2.5,
>>> says:
>>>
>>>   The specification states that at most one control method can be
>>>   actually executing AML code at any given time.  ...  it can be
>>>   said that the specification precludes the concurrent execution
>>>   of control methods.
>>>
>>> It is referring to the ACPI specification, but I don't see any
>>> explicit statement there.  I've been pointed to this text from
>>> ACPI 3.0, section 5.5.2:
>>>
>>>   Interpretation of a Control Method is not preemptive, but it can
>>>   block.  When a control method does block, the operating software
>>>   can initiate or continue the execution of a different control
>>>   method.
>>>
>>> But this doesn't actually say anything about concurrency.
>>>
>>> If ACPI does in fact preclude concurrent method execution, can you
>>> point me to discussion of this in the ACPI spec?
>>>
>>> Bjorn
> 

