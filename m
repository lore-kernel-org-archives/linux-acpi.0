From: =?ISO-8859-1?Q?Axel_M=FCller?= <axel.mueller-qenKrGB1/YlH8HOlP0F5JqhivhuVJJ3m@public.gmane.org>
Subject: Invalid PBLK length
Date: Mon, 20 Jan 2003 18:58:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7160000.1043107116@iwe070.etec.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I have installed the acpi-20021212 Patch on my Asus L2400D Laptop with a=20
2.4.20 Kernel (AMD Athlon XP mobile, SiS chipset, latest Bios version from=20
Asus).
First the good things:
- I can monitor battery and temperature status
- I get acpi events with acpid (powerbutton, ac_adapter)
- I can send the laptop sleeping with echo 1 > /proc/acpi/sleep, but the=20
processor does not really awake after pressing a key; the performance is=20
quit sluggish

bad things:
- no processor throttling
- only CPU state C1
I think this is caused by the Invalid PBLK length (Invalid PBLK length [5])
reported in /var/log/dmesg. I think this issue was discussed in this list=20
before, but I did not see any conclusions/solutions. Therefore the CPU is=20
always in the most power consuming mode and the fan runs the most time as=20
the temperature is above 70=B0C. However, I installed then athcool from=20
http://members.jcom.home.ne.jp/jacobi/linux/softwares.html
to disconnect the Northbridge when STPGNT is detected. To my surprise it=20
worked. Temperature is decreased to 60=B0C and power consumption decreases =
so=20
I can use the laptop more than 1 hour (I thought that STPGNT is only send=20
when processor is in C2 state, but concerning acpi output this is not=20
supported).
How can I get rid of this Invalid PBLK message and how can I use the sleep=20
mode?

  Axel

--
Dipl.Phys. Axel M=FCller (axel.mueller-qenKrGB1/YlH8HOlP0F5JqhivhuVJJ3m@public.gmane.org)
Institut f=FCr Werkstoffe der Elektrotechnik IWE
Universit=E4t Karlsruhe
Tel. 0721/608-7569   Fax  0721/608-7492
http://www.iwe.uni-karlsruhe.de



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
