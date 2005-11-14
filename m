From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Radeon suspend to ram
Date: Mon, 14 Nov 2005 10:11:41 +0100
Message-ID: <20051114091141.GB2103@gamma.logic.tuwien.ac.at>
References: <200511121747.18086.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200511121747.18086.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sam, 12 Nov 2005, Stefan D=F6singer wrote:
> I've just noticed  that the newly released fglrx driver 8.19.10 finally=
 has=20
> suspend functionality. It works fine for me(Radeon M9) without any othe=
r=20
> utilities :)

This unfortunately does not help the M7 users to get it working with DRI.=
=20
I can resume, I get back my screen on the console, but as soon as I switc=
h to
X the laptop freezes. Screen is a nice fractal image, and nothing works,
not even sysrq.

Current situation is like this
	suspend2disk:	works with and without DRI
	suspend2ram:	works only without DRI

all on latest -mm kernels. (Well in fact not anymore with latest -mm
kernels, as vbetool is not working with -mm kernels anymore (program
vbetool is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory,
which is deprecated. Please report this to linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)


Pity.

Best wishes

Norbert

-------------------------------------------------------------------------=
------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0 =
di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
HASSOP (n.)
The pocket down the back of an armchair used for storing two-shilling
bits and pieces of Lego.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
