From: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Subject: Re: S3 on Asus M6R
Date: Mon, 21 Mar 2005 22:02:17 +0100
Message-ID: <20050321210217.GF14356@fi.muni.cz>
References: <20050321135401.GC30293@fi.muni.cz> <423F05A9.6050309@gmx.net> <20050321173912.GN30293@fi.muni.cz> <200503212056.20589.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <200503212056.20589.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan D=F6singer wrote:
: You can try to place a few markers in the wakeup code. The first one wo=
uld be=20
: to insert "lcall $0xffff, $0" (without the quote, hope the code is corr=
ect)=20
: in arch/i386/kernel/wakeup.S right at the beginning after ".code16" (Li=
ne=20
: number 22 in 2.6.11.3.

	It is arch/i386/kernel/acpi/wakeup.S. Yes, adding "lcall $0xffff, $0"
to the line #22 causes the machine reboot when I hit the power button aft=
er
the suspend.

	OK, I will try to move this instruction down in wakeup.S now.
Any other hints? Thanks!

-Yenya

--=20
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}=
> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5=
E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz=
/ |
> Whatever the Java applications and desktop dances may lead to, Unix wil=
l <
> still be pushing the packets around for a quite a while.      --Rob Pik=
e <


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
