From: Robert Vollmert <rvollmert-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Unable to turn fan on - Asus M3N - 2.6.0-test9bk4
Date: Sun, 2 Nov 2003 18:47:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031102174730.GB2819@krikkit>
References: <20031101193817.GA19198@austinchronicle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031101193817.GA19198-lfYnT2qr6k+7/ODoCphcOEEOCMrvLtNR@public.gmane.org>
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

Hi,

> I'm attaching dsdt.dsl - it has not been patched into the kernel or
> anything. 
> 
> If you can help, THANK YOU!

are you sure the fan doesn't turn on? What kind of temperatures have
you been seing? As Karol noted, the fan isn't controlled the way the
spec intends (which would require implementing n fan devices for an
n-level fan, I think). Instead, TCHG is called every time the
temperature changes, which sets the fan speed directly based on some
threshold temperatures which vary based on cooling mode
(active/passive). That's the only place you can take influence wihtout
modifying the DSDT, though changing the mode to passive will increase
the thresholds. IIRC, these temperatures are quite high, though I don't
remember exact values. In the region of 70°C, for the lowest, I think.

Cheers
Robert


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
