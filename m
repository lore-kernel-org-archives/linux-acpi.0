From: Juliusz Chroboczek <jch-klhGwnj84BUD5ynB6aAmlA@public.gmane.org>
Subject: Re: kacpid and my daemon
Date: 23 Jul 2002 18:34:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87bs8y768s.fsf@trurl.cs.unibo.it>
References: <200204051427.g35ERYM20814@foobar.pps.jussieu.fr>
	<200207221802.52785.douard@pl.ecp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200207221802.52785.douard-m7abxLq4WJJQFI55V6+gNQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: David Douard <douard-m7abxLq4WJJQFI55V6+gNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

DD> But, I have written a little user space deamon (fansd) which periodically 
DD> check themperature, and decide wether or not turn on/off fan. Because that 
DD> feature does not work out of my (very patched DSDT) ACPI system.

That's weird -- it would appear that ACPI does properly export thermal
zones and fans to userspace, but OSPM (the kernel-side
power-management code) doesn't manage them?  I'd be curious to know
how that can happen.

DD> The strange thing is that every time my deamon decide to change
DD> the state of the fans, I have a zombi process which ps trace is :

DD> note that 4609 is the PID of my fan daemon. I cannot make those process be 
DD> collected and eliminated but my killing my deamon...

I've noticed this too, and I believe it's a bug in either ACPI's or
the kernel's code for dealing with /proc; I haven't found the time to
debug it, though.

Could you check (with strace) whether all the ``close'' system calls
in your code are successful?

                                        Juliusz



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
