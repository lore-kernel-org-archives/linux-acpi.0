From: Paul Richards <p.a.richards-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Subject: gettimeofday() moving backwards
Date: Wed, 18 Dec 2002 19:53:19 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040241199.3e00d22fe594b@sms.ed.ac.uk>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I am using linux kernel v2.4.20 with ACPI patch dated 2002-12-05.

I have noticed that if my processor changes state (800Mhz up to 1200Mhz say)
then gettimeofday() behaves weirdly.  It runs smoothly but every now and again
(on the order of 10 times a second) it makes a correction.  If I have gone from
800Mhz to 1200Mhz then the correction is backwards, otherwise it makes a forward
jump..

I presume that this is because the kernel hasn't noticed that the cpu state has
changed and hasn't corrected the variables that control how the time is
calculated using the tsc.

Is there a patch for this..?  It doesn't sound like *too* big a thing.. ie just
recalculate a cpl of timing variables when the cpu state changes.. but ofc I
don't know the details :)

-- 
Paul Richards



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
