From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [PATCH] Drop back to extended IRQ resource type
Date: Tue, 2 Sep 2003 17:52:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309021752.27100.adq_dvb@lidskialf.net>
References: <20030829045032.GA688@gambit.implode.net> <200308301956.41007.adq_dvb@lidskialf.net> <20030902154820.GA961@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030902154820.GA961-XxA8UMA2PDBPKbTXaf03yKxOck334EZe@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Wong <kernel-AAfBIQCtFhbR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 02 Sep 2003 4:48 pm, John Wong wrote:
> The patch does appear to give the card an IRQ, but it does not appear to
> be valid.  Doesn't the IRQ only go up to 24 on a single APIC processor?
> The IRQ of 27 does not get registered in /proc/interrupts either.

No, theres no limit like that with APIC.. really depends on the hardware 
configuration in the machine (number and type of IO-APIC(s) used).

IRQs do not appear in /proc/interrupts unless a device driver claims it... I 
have the same thing with my Geforce4 card... I'm using the drivers that come 
with X.

Does the card work OK?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
