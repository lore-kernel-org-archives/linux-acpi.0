From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 5 Feb 2004 17:24:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205172405.01777986.ak@suse.de>
References: <C50AB9511EE59B49B2A503CB7AE1ABD1066111ED@cceexc19.americas.cpqcorp.net>
	<20040205161923.37eebc64.ak@suse.de>
	<40226A58.5080004@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40226A58.5080004-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Cc: john.cagle-VXdhtT5mjnY@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 05 Feb 2004 17:07:52 +0100
Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org> wrote:

> Andi Kleen wrote:
> 
> > 
> > To guarantee parseable AML all you have to do is to compile the AML
> > with the Intel AML compiler (available from the Intel ACPI website)
> > This could be done from the source code or by just disassembling
> > it (iasl -d DSDTdump) and then reassembling it. If it compiles it should be ok
> > for the interpreter.
> > 
> 
> That would at least mean that the interpreter would not have to deal 
> with it at runtime. But it looks like a lot of DSDTs don't even pass 
> that test...
> 
> How is the interpreter currently designed/behaving to cope with such 
> situation?

The Intel interpreter is very strict (even with the relaxed aml option),
microsoft is very lax. That causes problems.

But interpreter problems are usually fairly easy to fix. The 
interpreter could be probably be made even more relaxed, but the 
maintainers (Len.et.al) don't seem to want to go that path so I don't see it 
happening.  They write the code, so it works like they want it.

It would not help that much anyways. 

The interpreter problems would be all easy to catch by QA
(even without actually booting linux). And also easy to fix
afterwards, just a bit time consuming.

The nasty problems are other logic bugs in parsing tables and interpreting 
results of methods. There doing the same thing as Windows is basically
impossible.

> > Of course that doesn't guarantee that Linux will work with it
> > (it could parse the tables incorrectly or not like something the
> > methods do when executed) but will catch at least some basic AML errors and
> > do some static verifying.
> > 
> 
> Maybe linux-acpi should first do a quick-scan on the DSDT and then 
> decide in what "emulation-mode" it should go. Think of
> 
> * Simply good according ACPI-2.xxx spec -> follow the spec (ideal case)
> 
> * Special Linux-specific behaviour in DSDT -> do what the ACPI 
> implementation of does at the moment (likely older BIOS that was tested 
> on _some_ version of Linux-acpi)
> 
> * DSDT with behaviour customised for one or more Windows version -> 
> emulate one of them (the latest version named?)
> 
> * Nothing -> just pick a windows emulation depending on BIOS date or 
> other prior knowledge

You're assuming that all interactions with ACPI are well understood.
But it's an extremly complex system hooking into all kinds of low level
parts of the kernel

(e.g. a lot of ACPI DSDT parsing behaviour doesn't actually come from
the ACPI subsystem code, but from the linux APIC and interrupt code)

Doing "ACPI behaviour emulations" would be impossible to maintain. It's already 
difficult enough to catch and test the various cases. ACPI problems at boot are usually
difficult to debug. Keeping it simple stupid is the only way to keep
it manageable. And the ACPI subsystem is already too complex.

Remember we're not talking about Mozilla here, but about an extremly
low level part of a kernel.

-Andi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
