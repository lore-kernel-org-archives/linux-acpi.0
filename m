From: James Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Battery Status on Inspiron 8200-- working as of kernel 2.4.22
Date: Tue, 09 Sep 2003 16:48:27 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1063140506.2931.15.camel@sirius.strandboge.cxm>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Just thought I'd post my progress on this.

Prior to kernel 2.4.22 I could poll the battery on a Dell Inspiron 8200,
but repeated polling would crash the system (around 16000 times on my
computer).  As such, battery status applets would crash the computer
after a a day and a half-- so I couldn't use them.

As of kernel 2.4.22, the polling the battery does NOT crash the system
anymore.  I polled some 300,000 times without error and have been
running a battery monitor for days without a hiccup.  Thank you for the
good work.

I did notice that polling /proc/acpi/battery/*/state DOES slow down the
clock now (it didn't before 2.4.22).  Polling the battery under apm does
the same thing.  I am in no way complaining-- I can just use tickadj. 
Apparently interrupts are now enabled when getting the state
information?

Anyway, thanks for the good work.  This laptop works MUCH better with
acpi in general, and now that the battery status works, I am very happy.

Jamie Strandboge



-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
