From: "Gaetano Sferra" <gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: About ASL and DSDT fixing
Date: Wed, 15 Sep 2004 11:03:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <I42RT7$043051603B3815A736335BEE0AD7FB44@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello to all,
I'm trying to correct the DSDT for my AMILO D 7830, I see =
already other messages about it but my question is another: Where I can f=
ound resources on the ASL language? I've searched on Intel's site and dow=
nloaded a lot of manuals but none tells to me the syntax and the semantic=
 of this language, can you help me so I can try to understand what's wron=
g in my DSDT, what should be the correct behavior of this or that functio=
nality and how try to fix or re-code it?

Another simple question: How =
I can pass the kernel argument acpi_os_name using LILO? I've tried using =
the attach=3D<...> option but I can't because the it's content must be do=
uble quoted so attach=3D"hdc=3Dide-cd acpi_os_name=3D"Microsoft Windows X=
P"" doesn't work cause the nested quote, the same is with attach=3D"hdc=3D=
ide-cd acpi_os_name=3D'Microsoft Windows XP'", the kernel got only half s=
tring ("Microsoft"). How I shoud pass it?

Thanks
Gaetano Sferra



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
