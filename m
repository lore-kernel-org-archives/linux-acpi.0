From: "Praveen C" <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: Re:  acpi on r40e
Date: Tue, 02 Mar 2004 05:57:04 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <W64818352108621078207024@mail.mailsnare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is about the hangup problem with processor modules on Thinkpad R40e.=
 I have narrowed the problem down to the following functions in drivers/a=
cpi/processor.c

acpi_processor_idle
acpi_processor_get_throttling
acpi_processor_set_throttling

I forced a return in the beginning of all these three functions so that t=
he above functions are not executed. The module then does not hangup and =
I can also load the thermal module. So I can now get the temperature. I s=
uspect the above three functions because all of them disable irq (local_i=
rq_disable() and local_irq_enable() in 2.6 kernel) which could be causing=
 some problem but thats just a guess. I hope somebody will be able to tel=
l me the possible problems with these functions.
Thanks
praveen




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
