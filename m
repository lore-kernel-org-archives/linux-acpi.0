From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: S5 Powerdown problem on TX150 servers
Date: Tue, 16 Sep 2003 14:50:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309161450.19600.adq_dvb@lidskialf.net>
References: <200309160912.15060.adq_dvb@lidskialf.net> <200309161209.35760.adq_dvb@lidskialf.net> <20030916131922.GT11391@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030916131922.GT11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Ok.  But trouble: you have at first write the desired sleep type,
> then set SLP_EN.  Not the two at the same time.

Yup, its doing that as well. Heres a quick summary of what it does:

Clears any wake status
Disable BM arbitration

Get current value of PM1A control (and store two copies in variables 
PM1AControl, PM1BControl)

Clear SLP_EN and SLP_TYP fields in the above variables
Insert the SLP_TYP bits in each variable.

Store PM1AControl into ACPI PM1A
Store PM1BControl into ACPI PM1B

Insert the SLP_ENABLE bit in PM1AControl, PM1BControl
Flush the CPU cache
Store PM1AControl into ACPI PM1A
Store PM1BControl into ACPI PM1B

At this point the machine should be in S5, but appears to be in S1.

Prior to all this, it has called the _PTS and _GTS (if present) methods as it 
should.


Should I try masking off the SLP_TYP bits when the second write to PM1A/PM1B 
occurs?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
