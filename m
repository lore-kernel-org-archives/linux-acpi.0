From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: DSDT errors
Date: Wed, 16 Feb 2005 11:00:42 +1000
Message-ID: <200502161100.42543.meaton@vasco.com>
References: <20050214211105.GA12808@elf.ucw.cz> <200502160935.11842.meaton@vasco.com> <1108512025.4085.139.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108512025.4085.139.camel@tyrosine>
Content-Disposition: inline
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

I am looking at my DSDT for an acer ferrari 300 laptop. It hangs on resume and 
I believe the problem (at least partially) is the _WAK function which doesn't 
return a value. The question is what should it return ?

The method is as below.

    Method (\_WAK, 1, NotSerialized)
    {
        Store (0x01, \_SB.PCI0.ISA.LIDP)
        If (LEqual (Arg0, 0x03))
        {
            \_SB.Z001 (0x91)
            Acquire (\_SB.PSMX, 0xFFFF)
            Store (0x80, \_SB.BCMD)
            Store (0x07, \_SB.DID)
            Store (Zero, \_SB.SMIC)
            Release (\_SB.PSMX)
        }

        If (LEqual (Arg0, 0x04))
        {
            Acquire (\_SB.PSMX, 0xFFFF)
            Store (0x80, \_SB.BCMD)
            Store (0x04, \_SB.DID)
            Store (Zero, \_SB.SMIC)
            Release (\_SB.PSMX)
            Store (\_SB.INF, Local0)
            If (LEqual (Local0, 0x07)) {}
            Else
            {
                Store (Local0, Local1)
                Store (Local0, Local2)
                Store (Local0, \_SB.PCI0.AGP.VGA.DABL)
                And (Local1, 0x01, \_SB.PCI0.AGP.VGA.CRTA)
                And (Local2, 0x02, \_SB.PCI0.AGP.VGA.LCDA)
            }
        }

        Store (0xBA, \_SB.PCI0.ISA.Z002)
        \_SB.Z001 (0x97)
    }


thanks.
If this has nothing to do with my problem I can supply the entire dsdt for 
someone to have a look at.

-- 
Mark Eaton
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
