From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich-S0/GAf8tV78@public.gmane.org>
Subject: RE: p2b-ds blacklisted?
Date: Mon, 27 Oct 2003 23:31:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310272331.13118.Mathias.Froehlich@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

I seems that early ASUS P2B-DS boards have a hardware bug.
I finally got it working using linux 2.4.23-pre8 and the fix described in

http://www.asus.com.tw/support/english/techref/acpi/index_2.aspx

and of course the kernel argument acpi=force. The power button works and the 
cpu's tell me that they support C1. I don't know a way to test this.

I had the resistor at the wrong place and have tried before with the RedHat 
severn 3 kernel with acpi=force which did not work. I could not use the scsi 
controler and the acpi interrupt count growed very fast. Past changing the 
resistor, the acpi interrupt count was ok, but the pci ethernet card stopped 
working. Then I tried 2.4.23-pre1 and everything was fine.

Hope this helps.

   Mathias Fröhlich

-- 
Mathias Fröhlich, email: Mathias.Froehlich-S0/GAf8tV78@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
