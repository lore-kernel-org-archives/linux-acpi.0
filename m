From: Marco Walther <Marco.Walther-xsfywfwIY+M@public.gmane.org>
Subject: RE: Where does Dell i8200 hide it's fans?
Date: Mon, 27 Jan 2003 09:51:57 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15925.29117.505821.857797@jena.eng.sun.com>
References: <15921.42374.651850.622121@jena.eng.sun.com>
	<006601c2c44a$ded48990$134425db@sayonara>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <006601c2c44a$ded48990$134425db-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "KA" == Kenichi Adachi <Adachi> writes:

KA> Hi Marco,
>> I've a Dell Inspiron 8200 and I know it has two fans. The 
>> Dell-laptop driver is able to switch them but I don't see 
>> anything in the acpi DSDT:-( 

KA> Likely it's because "Dell-laptop driver" directly communicates with
KA> Thermal monitor and programs PWM FAN controller. It's not a big surprise
KA> to see that PC vendor doesn't expose FAN control to ACPI.

Why not? Isn't ACPI supposed to be `the' interface to all those
things?  Yes, I can use my own little way for each of them, something
of the fans/thermal control, something else for the batteries etc.

 
>> Another question: The Dell DSDT has some parts which work 
>> differently for different Windows OS's. Since this laptop is 
>> only supported with WinXP, whould it make sense to to fake 
>> that even under Linux?

KA> If you're talking about _OSI which is defined by Microsoft and not
KA> described in ACPI spec, your attempt shouldn't make a difference in
KA> Linux. Microsoft wants to determine which version of Windows was in BIOS

No, not only the _OSI method but I'm seeing also a OSID method in my
DSDT which returns a bitfield based on the _OS/_OSI and the result of
this is used in different parts of the DSDT again.

    Method (OSID, 0, NotSerialized)
    {
        If (LEqual (MIS3, 0x00))
        {
            Store (0x04, MIS3)
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI (WXP))
                {
                    Store (0x40, MIS3)
                }
            }
            Else
            {
                If (STRE (\_OS, W98S))
                {
                    Store (0x08, MIS3)
                }

                If (STRE (\_OS, NT5S))
                {
                    Store (0x10, MIS3)
                }

                If (STRE (\_OS, WINM))
                {
                    Store (0x20, MIS3)
                }
            }
        }

        Return (MIS3)
    }


KA> writer's mind when he/she wrote ACPI BIOS for the machine. By knowing
KA> the targeted Windows version, they can adjust their OS's behavior and
KA> keep the compatibility for the end user's sake. For more details, please
KA> take a glance at the following white paper:
KA> http://www.microsoft.com/hwdev/tech/onnow/_OSI-method.asp

This works both ways.  The BIOS can also adapt to the OS mostly the
same way:
....
            Method (_CRS, 0, NotSerialized)
            {
                CRS3 ()
                CR_0 (0x01, 0x00, 0x0009FC00)
                CR_0 (0x01, 0x0009FC00, 0x0400)
                If (LOr (LEqual (OSID (), 0x10), LEqual (OSID (), 0x40)))
                {
                    Store (GORL (), Local0)
                    CR_0 (0x00, 0x000C0000, Local0)
                }

.....

Thanks,
-- Marco


KA> Thanks,
KA> - Adachi, Kenichi

-- 


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
