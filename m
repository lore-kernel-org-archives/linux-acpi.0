From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Need Help interpreting my DSDT
Date: Sun, 02 May 2004 17:00:08 +0200
Message-ID: <1083510020.20641.5.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey, 
I figured out, that my Notebook ist capable of 4 C states. 
But in case I boot Linux ACPI return only one C-State. 
I tracked it to this code :
                If (\_SB.INV7)
                {
                    Return (NOC3)
                }

                If (\_SB.BATO)
                {
                    Return (BCST)
                }
                Else
                {
                    Return (ACST)
                }
Where \_SB.INV7 seems ot be set in this method :
    Scope (\_SB)
    {
        OperationRegion (GPIO, SystemIO, IO2B, 0x40)
        Field (GPIO, ByteAcc, NoLock, Preserve)
        {
            Offset (0x0C), 
                ,   7, 
            G07S,   1, 
                ,   9, 
            G17S,   1, 
                ,   9, 
            G27S,   1, 
            G28S,   1, 
            Offset (0x2C), 
                ,   3, 
            BT1S,   1, 
                ,   3, 
            INV7,   1, 
                ,   3, 
            LIDL,   1, 
            Offset (0x38), 
            BKLT,   1, 
            BAYI,   2
        }
    }

    Scope (\_GPE)
    {
        Method (_L17, 0, NotSerialized)
        {
            If (\_SB.INV7)
            {
                Store (0x00, \_SB.INV7)
            }
            Else
            {
                Store (0x01, \_SB.INV7)
            }

            Notify (\_PR.CPU1, 0x81)
        }
As far as I could figure out, this would be some contol register of an
embedded device (this is just a guess) Any idea, what this could be ?
Thx
   Janosch

P.S.: I thougt about hardcoding the C-states into my kernel, would this
work ?  



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
