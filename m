From: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Fri, 08 Nov 2002 12:29:58 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036754998.3dcba03635bd3@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Zitiere Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>:

> Yes, /proc/acpi/fan/... should be present, also in 2.4.x kernels; I had
> it all the time since 2.4.18+acpi-20020329 (the first Linux+ACPI kernel
> I put on my then brandnew Gericom M6-T laptop). I haven't tried kernel
> 2.4.20-rc1 yet, though.
> 
> Are you using the ACPI patch from http://sf.net/projects/acpi?

Yes. With the suggested debugging-patch _HIGH -> _LOW and with acpi-debugging 
enabled.

> Of course the fan can only be controlled through ACPI if there is a fan
> and it is listed correctly in the ACPI description tables. This is
> typically the case for laptops and notebooks (but not for all of them),
> and typically not the case for desktop machines.

It's a Acer Travelmate Notebook and it has got a fan. I'm afraid, that I am not 
able to have a look to the ACPI-description table with my recent knowlege. How 
could I check this?

(According to lsmod the fan-module is loaded.)

Gerfried


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
