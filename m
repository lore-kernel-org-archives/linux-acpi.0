From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 5 Feb 2004 16:19:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205161923.37eebc64.ak@suse.de>
References: <C50AB9511EE59B49B2A503CB7AE1ABD1066111ED@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD1066111ED-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 5 Feb 2004 08:33:14 -0600
"Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org> wrote:

> Bas Mevissen wrote:
> > 
> > ACPI committee did not push a proper validation program. It's 
> > like the 
> > web "standards": standards are therem but everybody tests with IE and 
> > most web developers are satisfied when it works with it...
> > 
> > ACPI committee should make a proper validation mandatory before a 
> > computer may be sold as "ACPI X.Y compliant". Then manufacturers can 
> > test against (open) validation platform and Linux-ACPI can be 
> > validated 
> > against it too.
> 
> This is a very good point, something for all of us to remember when
> participating in any standards-creating process.
> 
> Also, if there were a Linux-ACPI standard validation suite, it would
> make HP's Linux QA Engineers very happy, and much more likely to
> find and fix ACPI AML errors *before* we ship new hardware.  Anyone
> interested in working on something like that?

To guarantee parseable AML all you have to do is to compile the AML 
with the Intel AML compiler (available from the Intel ACPI website) 
This could be done from the source code or by just disassembling 
it (iasl -d DSDTdump) and then reassembling it. If it compiles it should be ok 
for the interpreter.

Of course that doesn't guarantee that Linux will work with it
(it could parse the tables incorrectly or not like something the
methods do when executed) but will catch at least some basic AML errors and 
do some static verifying.

-Andi



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
