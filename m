From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Last acpi patch against 2.4.18 and 2.4.19 released
Date: 03 Sep 2002 01:05:31 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031029533.1420.60.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi support <acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi(gh)

So I had update my web site with last acpi patches for kernel 2.4.18 and
kernel 2.4.19 since some people have been asked for it.

http://codecs.home.sapo.pt/acpi/index.html

the concept now is different because under linux/drivers/acpi the source
is the same for all kernel-2.4.x, this I call it: acpisubsystem.=20
The rest is the integration of the new acpi in kernel.
So, now you just have to apply the integration patch for the proper
kernel. After this, delete drivers/acpi directory and replace to new
acpisubsystem, in this case is acpisubsystem20020829.tar.gz, with this
and expecting the new patches just have changes in subsystem, can be
more easy upgrade acpi releases because we just have to replace the
drivers/acpi directory.

This time the sources are completely copy from the official sources,
and have the small patch made by KOCHI, Takayoshi.

So it is one suggestion that all source under drivers/acpi for kernel
2.4.x and 2.5.x be release or accessibly from sf.net site, with CVS or
downloading. Will be great because will be more easy integrated in other
kernels like -ac kernels or redhat kernels, unfortunately I don't have
much time to do it but maybe I will try to do it.

Thanks=20
S=E9rgiomb =20




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
