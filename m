From: "Manpreet Singh" <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Subject: S3 resume and Wake events
Date: Thu, 25 Mar 2004 17:34:46 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EB6B0A91B0F6AC44842492A8F6852CDE11AAB6@fcexmb01.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

Hi,

I am attempting to resume from S3 using a magic packet from an NIC. The =
NIC
asserts the PME# and the status bit gets set in the I/O controller, but =
it
turns out that the ACPI suspend code in the kernel disables *all* GPEs =
before
sleeping and so I can't wake the system up after it goes to sleep.

Tracing through the code (on the 2.6.4 stock kernel), at one point, the
function acpi_enter_sleep_state() calls acpi_disable_non_wakeup_gpes() =
which
disables all GPEs, even the ones that are potentially the wake-up events =
like
the PME_EN bit.

I am not sure if this is the case always or if there is a way to =
configure
the system to specify which GPEs are the candidates for wake-up.

I would appreciate your help and suggestions.

Thanks,
Manpreet.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
