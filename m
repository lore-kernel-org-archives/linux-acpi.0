From: info-HF0vHiRXI/roK6nBLMlh1Q@public.gmane.org
Subject: S1 stopped working with 2.6.2 on the Inspiron 8600
Date: Thu, 5 Feb 2004 09:46:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205084614.GA1277@bzzz.elysianfields>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello!

After my last woe was cured in record time with the help of this list, I try my
next:

When trying to enter S1 on my notebook (Dell Inspiron 8600/Centrino, kernel:
Linux 2.6.2), the last message appearing is "PM: Entering state", and the
notebook is _not_ switched off.

The power LED is blinkig as it would if it were sleeping. but the display is
still on, displaying the last messages from PM. Pressing the power button
"resumes" (with the first message "Back to C"), and everyting is working again.

The strange thing is that entering S1 (suspend to RAM) actually worked with
2.6.0-test11.
What made it unusable for me was the fact that after resume the ethernet card
(broadcomm 4400 / b44) would not receive any interrupts, even if the module was
unloaded before suspend and inserted again after resume.

Any hints welcome.

  Rudi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
