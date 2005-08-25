From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: loads of new errors with 2.6.13-rc6-mm1 (and -mm2)
Date: Thu, 25 Aug 2005 09:40:28 +0200
Message-ID: <20050825074028.GA10254@gamma.logic.tuwien.ac.at>
References: <6694B22B6436BC43B429958787E454983CBB7E@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E454983CBB7E@mssmsx402nb>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alexey!

On Don, 25 Aug 2005, Starikovskiy, Alexey Y wrote:
>  Please see my previous mail to this list with the patch.

Much better. I merged it into 2.6.13-rc6-mm2 (didn't apply cleanly).

Now I get some different errors:
    ACPI-0292: *** Error: Looking up [DCRS] in namespace, AE_ALREADY_EXIS=
TS
    ACPI-0509: *** Error: Method execution failed [\_SB_.PCI0.LPC0.SIO_.C=
OMA._CRS] (Node c14d1d80), AE_ALREADY_EXISTS
    ACPI-0156: *** Error: Method execution failed [\_SB_.PCI0.LPC0.SIO_.C=
OMA._CRS] (Node c14d1d80), AE_ALREADY_EXISTS

Other stuff related to acpi in the dmesg:
ACPI: RSDP (v000 ACER                                  ) @ 0x000f5e80
ACPI: RSDT (v001 ACER     RSDT   0x20020930  LTP 0x00000000) @ 0x1ff75a7b
ACPI: FADT (v001 ACER   IBIS     0x20020930 PTL  0x0000001e) @ 0x1ff7bf64
ACPI: BOOT (v001 ACER   IBIS     0x20020930  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
..
    ACPI-0284: *** Info: Table [DSDT] replaced by host OS

this is from me, I have fixed the DSDT table to get proper AC reporting.
If this could be a problem, I can send you the changes I made to the
DSDT, they are very unintrusive.


Best wishes

Norbert

-------------------------------------------------------------------------=
------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-=
690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
BOOK	Meanwhile, the starship has landed on the surface
	of Magrathea and Trillian is about to make one of the most
	important statements of her life. Its importance is not
	immediately recognised by her companions.
TRILL.	Hey, my white mice have escaped.
ZAPHOD	Nuts to your white mice.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
