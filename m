From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: 2.4.22 ACPI fails with VIA EPIA-M board
Date: Sun, 31 Aug 2003 18:50:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308311850.27629.adq_dvb@lidskialf.net>
References: <1062161988.26754.20.camel@dhcp23.swansea.linux.org.uk> <200308310230.11492.adq_dvb@lidskialf.net> <1062335884.31861.48.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1062335884.31861.48.camel-Z+iYsftfazAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 31 August 2003 14:18, Alan Cox wrote:
> On Sul, 2003-08-31 at 02:30, Andrew de Quincey wrote:
> > Hmm, there's no warnings generated from the ACPI code during bootup I
> > take it?
>
> Not that I noticed. It used to be fine then 2.4.22 proper broke it.

Ah yeah, I see the main ACPI patch which would include the IRQ routing changes 
went in at -rc3.

Hmm, I'd need the following to diagnose:
/proc/interrupts from -pre7 and -final
dmesg from -pre7 and -final
DSDT dump 
lspci -vvv




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
