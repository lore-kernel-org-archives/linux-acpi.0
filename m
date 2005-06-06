From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT problem with Acer Aspire 3002NLC
Date: Mon, 06 Jun 2005 19:34:09 +0200
Message-ID: <42A48911.6070000@suse.de>
References: <9a9bfc170506060740547d2bd6@mail.gmail.com> <42A467C8.503@suse.de> <9a9bfc170506061006433fbcd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9a9bfc170506061006433fbcd7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ramkumar R <andyetitmoves-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ramkumar R wrote:
> thanx a lot...that worked ! .... just curious as to what it changed in
> the dsdt ... coz out of curiosity i also tried the one with the errors
> (just realised that even when there are errors, it still outputs a hex
> file) ... atleast /proc/acpi didn't show any changes...

Don't know whether the .hex file of a DSDT compiled with errors is valid.
> 
> secondly, is this a big enough change for me to create a new dsdt
> entry in the dsdt database ?

Adding the External (...) statements?
No this doesn't fix anything.
It's just a hint for the compiler that these objects are in a separate
table.
You can do:
acpidmp > /tmp/acpidmp
acpixtract ssdt /tmp/acpidmp > /tmp/ssdt
(be careful there could be more than one, maybe you have to split
the /tmp/acpidmp outputfile (it's a text file, you can just copy away
several SSDT.... parts) to e.g. /tmp/ssdt1 /tmp/ssdt2).
iasl -d /tmp/ssdtX
There should somewhere exist the \PR.CPU0._PDC object the compiler complained
about.

However your dsdt/ssdt(s) seem to work well.
I expect your battery to be a smart battery system, for which an instruction
exists to get it going. It includes patching your DSDT with some additional
instructions.

If you grep the archives you should find a step by step instruction.
IIRC Rich Townsend posted it, at least he did this smart battery stuff.

> and a bit off topic, what exactly can i do with the
> embedded_controller entry i have in my /proc/acpi ? it just shows up
> an info file ?

That's OK, AFAIK the embedded controller does not provide any interface
to userspace you could play around with.

     Thomas

P.S.: you should CC the list again, so that others with similar problems
grepping the archives or googling know what to do.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
