From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: AML method concurrency
Date: Wed, 30 May 2007 10:11:45 -0600
Message-ID: <200705301011.46724.bjorn.helgaas@hp.com>
References: <200705291454.27905.bjorn.helgaas@hp.com> <465D29C4.20707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:39061 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbXE3QLx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 May 2007 12:11:53 -0400
In-Reply-To: <465D29C4.20707@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Wednesday 30 May 2007 01:37:40 am Alexey Starikovskiy wrote:
> There is a "limited concurrency" in interpreter.
> There is a "executor" semaphore(acpi_ex_{enter/exit}_interpreter), which
> prevents generic concurrent execution of methods, but in the case of the
> method blocking (mutex or sleep) it will be released and reacquired
> after, thus allowing some other method to run during block.

That's good information on the Intel CA implementation.  Do we know
what other implementations do?

Is there language in the ACPI spec itself that precludes concurrent
execution?

How exactly is the "acpi_serialize" Linux option useful?  If the
ACPI_MTX_INTERPRETER mutex prevents concurrency already, what good
is "acpi_serialize"?

> Bjorn Helgaas ?????:
> > Can AML methods be executed concurrently?
> > 
> > The existence of mutexes, serialized methods, and the Linux
> > "acpi_serialize" parameter makes me think that in general, we
> > should be able to execute multiple AML methods concurrently.
> > 
> > However, the ACPI CA Programmer Reference, rev 1.16, section 2.2.5,
> > says:
> > 
> >   The specification states that at most one control method can be
> >   actually executing AML code at any given time.  ...  it can be
> >   said that the specification precludes the concurrent execution
> >   of control methods.
> > 
> > It is referring to the ACPI specification, but I don't see any
> > explicit statement there.  I've been pointed to this text from
> > ACPI 3.0, section 5.5.2:
> > 
> >   Interpretation of a Control Method is not preemptive, but it can
> >   block.  When a control method does block, the operating software
> >   can initiate or continue the execution of a different control
> >   method.
> > 
> > But this doesn't actually say anything about concurrency.
> > 
> > If ACPI does in fact preclude concurrent method execution, can you
> > point me to discussion of this in the ACPI spec?
> > 
> > Bjorn
