From: Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Thu, 25 Nov 2004 08:02:43 +0100
Message-ID: <200411250802.43756.od@fet.uni-hannover.de>
References: <200411211600.01820.od@fet.uni-hannover.de> <41A4613F.2020905@helios.de> <200411241354.53598.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411241354.53598.stefandoesinger-RbZlAiThDcE@public.gmane.org>
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
Cc: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>, Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Stefan,

On Mittwoch, 24. November 2004 13:54 Stefan D=F6singer wrote:
> > Now its time to switch on my backlight ;-)
>
> The attached program may help you. It uses lrmi and vm86 to call the reset
> routine of the VGA bios. I use it to wake up my radeon card.
>
> You need the lrmi libaries.
> Compile with gcc boot-vga-bios.c -o boot-vga-bios -llrmi
> It's a user space program, you can call it eighter manually or better from
> a script.

Ok tried out that stuff yesterday. Like MAtthias, I have the same problem.=
=20
Calling this prog before suspend, display goes black (no signal, na=20
backlight) after suspend nothing happens - display stays black w/o signal.

Regards,
Oliver

=2D-=20
Oliver Dawid * od-9LIF7zR9EMg@public.gmane.org * http://www.fet.uni-hannover.de/~od/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
