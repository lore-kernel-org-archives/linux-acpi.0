From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Tue, 21 Jan 2003 09:38:33 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301210838.h0L8cZD02633@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: alK7HsKsUEe1kutgEg1WRw==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, axel.mueller-qenKrGB1/YlH8HOlP0F5JqhivhuVJJ3m@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I have installed the acpi-20021212 Patch on my Asus L2400D Laptop with a=
=20
> 2.4.20 Kernel (AMD Athlon XP mobile, SiS chipset, latest Bios version fro=
m=20
> Asus).
> First the good things:
> - I can monitor battery and temperature status
> - I get acpi events with acpid (powerbutton, ac_adapter)
> - I can send the laptop sleeping with echo 1 > /proc/acpi/sleep, but the=
=20
> processor does not really awake after pressing a key; the performance is=
=20
> quit sluggish
>=20
> bad things:
> - no processor throttling
> - only CPU state C1
> I think this is caused by the Invalid PBLK length (Invalid PBLK length [5=
])
> reported in /var/log/dmesg. I think this issue was discussed in this list=
=20
> before, but I did not see any conclusions/solutions.=20

Short term dirty hack:
http://sourceforge.net/mailarchive/message.php?msg_id=3D2138093
Long term solution:
Add a feature to ACPI (like CONFIG_ACPI_BROKEN_AML) which will make
the kernel complain about a buggy BIOS but at the same time offer
some workarounds. This goes towards bug to bug compatibility with M$.
I think this is planned already, but development for this hasn't
started yet.

> Therefore the CPU is=20
> always in the most power consuming mode and the fan runs the most time as=
=20
> the temperature is above 70=B0C. However, I installed then athcool from=
=20
> http://members.jcom.home.ne.jp/jacobi/linux/softwares.html
> to disconnect the Northbridge when STPGNT is detected. To my surprise it=
=20
> worked.=20

I'm really surprised, too. I have the little brother of your notebook
(the L2000D, see my page http://mitglied.lycos.de/chamo3/md9688.html),
and tried something similar called VCool which didn't work. :-/

> How can I get rid of this Invalid PBLK message and how can I use the slee=
p=20
> mode?

I have no idea why S1 doesn't work for you - I have the same hardware
and it always worked (with every version of ACPI).
Maybe it's a question of video driver or kernel setup? We can check
these non-acpi issues in private mail if you want to.


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
