From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: ACPI and framebuffer related problems with Linux
 2.6.1-rc1
Date: Fri, 2 Jan 2004 11:29:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040102112914.17654746.mike@it-loops.com>
References: <20040101220615.GA1804@minerva.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040101220615.GA1804-pLH66uKTs7QSl9drg5isYP8+0UxHXcjY@public.gmane.org>
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

On Thu, 1 Jan 2004 23:06:15 +0100
Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org> wrote:

> However, there is a problem with ACPI:
> /proc/acpi/processor/CPU0/performance, which was there in previous
> versions of the kernel and allowed me to slow the CPU down in order to
> save power, disappeared in Linux 2.6.1-rc1. It's simply not there
> anymore. Was it replaced? If so, what is the right way to do it by
> now?

After reading this E-Mail I tested it on my notebook (TarvelMate800) and
noticed that even with kernel 2.6.0 

	/proc/acpi/processor/CPU0/limit and
	/proc/acpi/processor/CPU0/performance

disappeared.

Kernel 2.4.23:
($:/)-> cat /proc/acpi/processor/CPU0/info 
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
performance management:  yes
limit interface:         yes


Kernel 2.6.0:
($:/)-> cat /proc/acpi/processor/CPU0/info 
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
performance management:  no
limit interface:         no


I don't use the performance option, since I throttle my
notebook with cpufreq, but it still looks like a regression.



/Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
