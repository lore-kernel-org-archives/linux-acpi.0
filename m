From: asu <asubedi-crMJuEk9IMvltQq4i4S/Dg@public.gmane.org>
Subject: broken DSDT on sony vaio pcg-grx500
Date: Fri, 26 Mar 2004 03:25:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87u10c5821.fsf@depauw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Compiling the decompiled DSDT gives me two errors. One error was that
it required ByteAcc access which I fixed easily. The other error is:

dsdt.dsl    16:                 Return (DCST)
Error    1022 -      Object does not exist ^  (DCST)


The region of code it corresponds to is:

DefinitionBlock ("DSDT.aml", "DSDT", 1, "SONY", "B0", 537002772)
{
    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06) {}
        Scope (\_PR.CPU0)
        {
            Method (_CST, 0, NotSerialized)
            {
                Return (DCST)
            }
        }


Changing DCST to _CST and compiling it gives me segmentation fault
while compiling. Realizing that it is dangerous, I tried various
things like DSDT, \_CST, etc. Changing it to 0x0 did not give me any
errors or warnings. Then I changed it to 0x033 which also did not give
me any error. So, I think changing it to 0x0 or 0x033 is incorrect.

I am using iasl-linux-20030918 to compile my dsl file. 

Can anyone point me to the solution to this error?

Thanks,
asubedi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
