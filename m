From: Nate Lawson <nate@root.org>
Subject: Bug in "implicit return" code
Date: Sun, 02 Jan 2005 20:08:22 -0800
Message-ID: <41D8C536.8020301@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-freebsd-acpi@freebsd.org>
List-Unsubscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=unsubscribe>
List-Archive: <http://lists.freebsd.org/pipermail/freebsd-acpi>
List-Post: <mailto:freebsd-acpi@freebsd.org>
List-Help: <mailto:freebsd-acpi-request@freebsd.org?subject=help>
List-Subscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=subscribe>
Sender: owner-freebsd-acpi@freebsd.org
Errors-To: owner-freebsd-acpi@freebsd.org
To: acpi@freebsd.org
Cc: acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

I have identified a problem in the implicit return code in dsutils.c. 
Various Toshiba laptops have a _STA method that is similar to this:

DefinitionBlock ("DSDT.aml", "DSDT", 1, "TOSHIB", "8100    ", 536872468)
{
     Device (LNKA)
     {
         Name (_HID, EisaId ("PNP0C0F"))
         Method (_STA, 0, NotSerialized)
         {
             STAL (0x60)
         }
     }

     Method (STAL, 1, NotSerialized)
     {
         /* Various link accesses removed for clarity. */
         Return (0x0B)
     }
}

If you compile and run this snippet in the debugger, you'll see that 
_STA doesn't return anything even with EnableInterpreterSlack set to 
TRUE.  This means the implicit return code doesn't work properly.

I examined the AcpiDsIsResultUsed() function and found that the check 
that was failing was this one:

     /*
      * If there is no parent, we are executing at the method level.
      * An executing method typically has no parent, since each method
      * is parsed separately.
      */
     if (!Op->Common.Parent)

So it appears that there _is_ a parent and the implicit return code 
below is never executed for this method.  I'm not sure the proper way to 
change this check for the above AML case but hopefully the Intel people 
will know.

-- 
Nate
