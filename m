From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/2] Video Extension patch
Date: Thu, 2 Sep 2004 14:10:20 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F840561A03A@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>
>>will change the current value, as you can see, but it does not change
>>the brightness value for my screen. Second, pressing the brightness
>
>This is feature is missing from the patch, I will make up it.

Actually, the code is there.  If you found the value of currnet is what
you just input,
then the _BCM has been called successfully. If there is NO brightness
change,
then this should be BIOS issue.

>
>>control buttons with the video extensions patch applied causes=20
>>a loss of
>>keyboard input. The mouse will work, but both internal and external
>>keyboards are dead after using those keys. BIOS-trapped keys such as
>>brightness and CRT/LCD still work. I do get a video event in
>>/proc/acpi/event when I press the CRT/LCD switch key.
>
>Hmm, if you don't mind, please sent the DSDT to me.
>
>>

There are some sleep statements in the hotkey method:
It will significantly slow down the execution of HKDS, Maybe this is the
cause of of a loss of keyboard.

    Method (HKDS, 1, Serialized)
    {
        If (LEqual (0x00, DSEN))
        {
            If (LEqual (SMIF, 0x00))
            {
                If (LNot (LEqual (CADL, PADL)))
                {
..............
                    Sleep (0x02EE)
                }

                Notify (\_SB.PCI0.GFX0, 0x80)
            }
        }

..............

        Sleep (0x03E8)
..............
    }

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
