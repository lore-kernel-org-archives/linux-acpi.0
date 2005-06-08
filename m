From: Klaus Muth <muth-5lHx5lHeYlQ@public.gmane.org>
Subject: Re: ACPI: RSDP - ERROR: Invalid checksum
Date: Wed, 8 Jun 2005 15:29:48 +0200
Message-ID: <200506081529.49355.muth@hagos.de>
References: <200506071546.57120.muth@hagos.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506071546.57120.muth-5lHx5lHeYlQ@public.gmane.org>
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

Hi!

Ok, I do the Ingrid.

Am Dienstag, 7. Juni 2005 15:46 schrieb Klaus Muth:
> ACPI: RSDP (v002 IBM                                   ) @ 0x000fdfb0
>
>   >>> ERROR: Invalid checksum
[...]
> The RSDP found by acpidmp:
> RSDP "IBM" @ 0x000fdfb0
>   0000: 52 53 44 20 50 54 52 20 75 49 42 4d 20 20 20 02  RSD PTR uIBM   .
>   0010: 80 f7 fc bf                                      ....

Yeah, this is the problem. I downgraded the BIOS, now the kernel uses ACPI:

ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfc0
ACPI: RSDT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0xbffcf780
ACPI: FADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0xbffcf700
ACPI: MADT (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0xbffcf640
ACPI: MCFG (v001 IBM    SERONYXP 0x00001000 IBM  0x45444f43) @ 0xbffcf600
ACPI: DSDT (v001 IBM    SERGEODE 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x588
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[and so on]

and acpidmp:

RSDP "IBM" @ 0x000fdfc0
  0000: 52 53 44 20 50 54 52 20 77 49 42 4d 20 20 20 00  RSD PTR wIBM   .
  0010: 80 f7 fc bf 

Is it possible, that IBM did update the version without updating the checksum?
Now, that I downgraded the BIOS, the x236 runs like a charm with 4 processors 
and all PCI interrupts routed correctly ;). I strongly suspect now, that the 
linux acpi code is correct with saying "Checksum error" ;).
-- 
Klaus Muth
HAGOS eG                      Industriestr. 62      fon: (+49) 711 78805-86
EDV-Programmierung            70565  Stuttgart      fax: (+49) 711 78805-35
http://www.hagos.de               Germany              mailto:muth-5lHx5lHeYlQ@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
