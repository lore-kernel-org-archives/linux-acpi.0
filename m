From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: broken DSDT on sony vaio pcg-grx500
Date: Fri, 26 Mar 2004 12:41:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040326114155.GP19001@poupinou.org>
References: <87u10c5821.fsf@depauw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87u10c5821.fsf-cmVtLlTERLQ3uPMLIKxrzw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: asu <asubedi-crMJuEk9IMvltQq4i4S/Dg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 26, 2004 at 03:25:26AM -0500, asu wrote:
> Compiling the decompiled DSDT gives me two errors. One error was that
> it required ByteAcc access which I fixed easily. The other error is:
> 
> dsdt.dsl    16:                 Return (DCST)
> Error    1022 -      Object does not exist ^  (DCST)
> 
> 
> The region of code it corresponds to is:
> 
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "SONY", "B0", 537002772)
> {
>     Scope (_PR)
>     {
>         Processor (CPU0, 0x00, 0x00001010, 0x06) {}
>         Scope (\_PR.CPU0)
>         {
>             Method (_CST, 0, NotSerialized)
>             {
>                 Return (DCST)
>             }
>         }
> 
> 
> Changing DCST to _CST and compiling it gives me segmentation fault
> while compiling. Realizing that it is dangerous, I tried various
> things like DSDT, \_CST, etc. Changing it to 0x0 did not give me any
> errors or warnings. Then I changed it to 0x033 which also did not give
> me any error. So, I think changing it to 0x0 or 0x033 is incorrect.
> 
> I am using iasl-linux-20030918 to compile my dsl file. 
> 

There is good chance that your system do have a table called SSDT, which
contains a DCST package.

Try something like
sudo ./acpidmp/acpidmp | grep SSDT
to see if I'm correct.
Then
./acpidmp/acpidmp SSDT > ssdt
hd ssdt

will dump the SSDT.  Look then if something like DCST do exist.

In that case, just making something like:
             Method (_CST, 0, NotSerialized)
             {
                 External(DCST)
                 Return (DCST)
             }


should be ok.

If that is not the case, I'm afraid that I need the full dump from
acpidmp (no just the DSDT) to look.  For this:

wget http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
tar xzvfp pmtools-20010730.tar.gz
cd pmtools-20010730/acpidmp
make
sudo ./acpidmp > acpidmp.out
gzip acpidmp.out.gz


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
