From: Stuart Levy <slevy-R3uSp7q5utt4piUD7e9S/g@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #632 - 12 msgs
Date: Tue, 29 Oct 2002 09:12:47 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021029151242.GA6016@niri.ncsa.uiuc.edu>
References: <E186Vl0-0005a7-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E186Vl0-0005a7-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

Trying the 20021022 patch to 2.4.20-pre11 on my Dell Latitude C600
(where APM, including suspension, actually is OK except for fan control),
the ACPI battery/fan/ac monitoring seems to be functional.  But
  echo "1" > /proc/acpi/sleep
puts the laptop promptly to sleep, but I can't find any way to
reawaken it.  Pressing the power button briefly does nothing;
pressing it for longer turns the power off.  Other buttons seem
to do nothing.

Is there anything I can do to track this?
I might get most syslog messages to survive the power-cycle if
I make syslogd write to a vfat partition; would those help?

Maybe I'll try 20021002 also.

Thanks.

    Stuart Levy
    NCSA, University of Illinois


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
