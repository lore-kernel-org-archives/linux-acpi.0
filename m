From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 05 Feb 2004 17:07:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40226A58.5080004@basmevissen.nl>
References: <C50AB9511EE59B49B2A503CB7AE1ABD1066111ED@cceexc19.americas.cpqcorp.net> <20040205161923.37eebc64.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205161923.37eebc64.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:

> 
> To guarantee parseable AML all you have to do is to compile the AML
> with the Intel AML compiler (available from the Intel ACPI website)
> This could be done from the source code or by just disassembling
> it (iasl -d DSDTdump) and then reassembling it. If it compiles it should be ok
> for the interpreter.
> 

That would at least mean that the interpreter would not have to deal 
with it at runtime. But it looks like a lot of DSDTs don't even pass 
that test...

How is the interpreter currently designed/behaving to cope with such 
situation?

> Of course that doesn't guarantee that Linux will work with it
> (it could parse the tables incorrectly or not like something the
> methods do when executed) but will catch at least some basic AML errors and
> do some static verifying.
> 

Maybe linux-acpi should first do a quick-scan on the DSDT and then 
decide in what "emulation-mode" it should go. Think of

* Simply good according ACPI-2.xxx spec -> follow the spec (ideal case)

* Special Linux-specific behaviour in DSDT -> do what the ACPI 
implementation of does at the moment (likely older BIOS that was tested 
on _some_ version of Linux-acpi)

* DSDT with behaviour customised for one or more Windows version -> 
emulate one of them (the latest version named?)

* Nothing -> just pick a windows emulation depending on BIOS date or 
other prior knowledge

Regards,

Bas.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
