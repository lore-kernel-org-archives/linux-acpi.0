From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 on Asus M6R
Date: Mon, 21 Mar 2005 20:56:20 +0100
Message-ID: <200503212056.20589.stefandoesinger@gmx.at>
References: <20050321135401.GC30293@fi.muni.cz> <423F05A9.6050309@gmx.net> <20050321173912.GN30293@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050321173912.GN30293-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
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
Cc: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Montag, 21. M=E4rz 2005 18:39 schrieb Jan Kasprzak:
> Carl-Daniel Hailfinger wrote:
> : Bah. Last try: Is a CD/DVD in the drive or are you plugged into a
> : docking station?
>
> 	No and no.
>
> : Another thing you could try is a serial console, but I doubt it
> : will work after resume.
>
> 	No serial port on Asus M6R :-(.

You can try to place a few markers in the wakeup code. The first one would =
be=20
to insert "lcall $0xffff, $0" (without the quote, hope the code is correct)=
=20
in arch/i386/kernel/wakeup.S right at the beginning after ".code16" (Line=20
number 22 in 2.6.11.3. If your kernel gets the control on resume this shoul=
d=20
cause a reboot right after wakeup. If it does, the problem is in the wakeup=
=20
code, if it does not it's in the suspend code

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
