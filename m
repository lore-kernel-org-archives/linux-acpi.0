From: Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
Subject: ACPI troubles on a Sony Vaio R505ES
Date: 07 Sep 2002 00:27:49 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031376469.1643.71.camel@rodan.monsters.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all. I'm new to the list and to ACPI in general. I've recently
bought a Sony Vaio R505ES laptop. I've got Linux running faily well on
it. All of the hardware is working, but I've run into some problems with
switching performance states and suspending.

Using the latest ACPI code from the linux-2.4-acpi tree and linux
2.5.33, I can switch the processor performance from P0 to P1. But I
can't switch it from P1 to P0. I get a "Transition failed" error. I've
tried various combinations of AC power/no AC power and throttling
settings with no success.

And I suspend to S3, but I can't resume using the power button or any
keys at all. I have to remove the battery in order to restore the
system.

I've gone over the mailing list archives, read through the ACPI
specifications,and poured over the kernel source until my brains are
running out my ears and patched kernels 'til my fingers are numb. I
haven't found any solutions to my problems. I don't know if my problem
is with my BIOS, DSDT table, or kernel support isn't along fair enough.

So I now plead for some help or guidance. 

Thanks in advance.

--
Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>








-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
