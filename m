From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 05 Feb 2004 18:15:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40227A36.5070002@basmevissen.nl>
References: <C50AB9511EE59B49B2A503CB7AE1ABD1066111ED@cceexc19.americas.cpqcorp.net>	<20040205161923.37eebc64.ak@suse.de>	<40226A58.5080004@basmevissen.nl> <20040205172405.01777986.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205172405.01777986.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: john.cagle-VXdhtT5mjnY@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:

> 
> The Intel interpreter is very strict (even with the relaxed aml option),
> microsoft is very lax. That causes problems.
> 
> But interpreter problems are usually fairly easy to fix. The
> interpreter could be probably be made even more relaxed, but the
> maintainers (Len.et.al) don't seem to want to go that path so I don't see it
> happening.  They write the code, so it works like they want it.
> 
> It would not help that much anyways.
> 
> The interpreter problems would be all easy to catch by QA
> (even without actually booting linux). And also easy to fix
> afterwards, just a bit time consuming.
> 

What about keeping the interpreter strict, but always before passing the 
DSDT to the interpreter, disassemble it and check it for problems. That 
"tester" should then be able to fix the most common problems. Then 
compile it again and pass it to the interpreter. Eventually a sort of 
intermediate language can be used that gives an easy to parse output.

Pro:
* Can fix common problems on the fly
* Can maintain a table of know defects (e.g. don't drive fan of notebook 
XXX)
* Can do all kinds of changes based upon command line options
* Parser code fast, clean and according to standard (verificatable!)
* "New" DSDT is very trustable, so less checking/conditional handling in 
rest of LL kernel code regarding ACPI
* APM -> ACPI "tranlation": write APM in ACPI-terms and get rid of APM 
code in kernel.
* Does not need to be kernel code -> easier to debug and less runtime-risk

Con:
* Boot time
* Maintenance
* Initrd size
* Development time

> The nasty problems are other logic bugs in parsing tables and interpreting
> results of methods. There doing the same thing as Windows is basically
> impossible.
> 

Why? Is that missing knowledge of what Windows does or is the Windows 
implementation too different?

> You're assuming that all interactions with ACPI are well understood.
> But it's an extremly complex system hooking into all kinds of low level
> parts of the kernel
> 
 > (snipped some explanation)

True. So maybe pre-examening is a way to keep the implementation as 
simple as it can be. You are right that having a dynamic behaviour of 
the linux-acpi is not the way to go.

So I think we need to have means to reshape the DSDT at runtime before 
interpreting it. It will definitely not catch all cases, but at least 
some of them.


Bas.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
