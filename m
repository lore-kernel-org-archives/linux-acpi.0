From: Jiri Musil <musil-TFwWp4wlsn4@public.gmane.org>
Subject: Compaq EVO N110, bad state handling?
Date: Fri, 18 Apr 2003 14:31:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030418123144.GB2623@nostromo>
Reply-To: Jiri Musil <musil-TFwWp4wlsn4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
i didn't recieve answer in acpi-support so i'm trying to send mail here to devel
list.

I have Compaq EVO N110, i compiled 2.4.21-pre6 with acpi for this kernel. I can
read info about battery, CPU etc. but state file shows bad values.

When i try to read state of battery at first time it shows probably good value. 
But when i try to read it one more time there is crazy value (ten time more 
then capacity of my battery) which decreases very quickly and when it reaches 
zero value it returns to some crazy high value and the fast decreasing repeats. 
That all the time.

CPU stat shows 50C all the time and it is not possible. (it shows 50C even if my
fan rotates, according to my BIOS my fan turns on when temperature get over
76C).

Does it exist some solution of this problem or do i have to wait for some next
version of your kernel patch?

Thanks for response.


-- 
jiri musil
icq# 125282227, http://www.stud.fit.vutbr.cz/~xmusil21


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
