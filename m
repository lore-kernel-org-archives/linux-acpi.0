From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: S3 resume not resuming VGA console
Date: Thu, 30 Jan 2003 21:01:54 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0301302058270.4624-100000@godzilla.axis.se>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA6D@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA6D-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
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

Hi!

With 2.5.59 and the latest ACPI patch applied, S3 suspend works and resume 
seem to work as well (it does not with vanilla 2.5.59) however the console 
never gets deblanked. You can type commands but you don't see anything..

I noticed that the latest ACPI patch included tweaks to in particular the S3 
resume VGA mode selection code - might this be a known instability or even 
something we know is unimplemented ? Or something that might result in 
machine-dependant failures ?

It's on an Acer Travelmate 634LC, and plain 80x25 text console without any 
funny fb devices or X running. Would be really great to get S3 working.. 

/Bjorn



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
