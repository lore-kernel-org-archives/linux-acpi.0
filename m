From: "Hyung K. Kim \(±èÇü±Ô\)" <hyungkk-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Compaq 1700, 2.4.18, acpi-7,24 - SUCCESS (I think)
Date: Mon, 12 Aug 2002 07:49:07 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020812144907.30057.qmail@web11102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Thanks to the people on the list, I was able to get
most of ACPI(features I care about)to work with my
laptop.

I had to modify the DSDT. (Very little)

I am pretty sure I didn't correct all the errors.  I
am getting some error messages in the
/var/log/messages like

Aug 12 10:24:33 dhcp--210-156 kernel: Executing all
Device _STA and_INI methods:....... dswexec-0117 [14]
Ds_get_predicate_value: Bad predicate (not a number)
Obj_desc=cffe07e8 State=c143e028 Type=2

and

Aug 12 10:24:33 dhcp--210-156 kernel:
..................  uteval-0432 [07] Ut_execute_STA   
    : No object was returned from _STA


I am guessing this has to be with my battery capacity.

I had to hack the battstat_applet to hard code the
capacity.  It was reading Unknown.  Actually, I had to
hack it so that it didn't read
/proc/acpi/battery/CMB0/info.  Prior to doing this, my
laptop would lock up about 10 minutes after the applet
is started.

HK


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
