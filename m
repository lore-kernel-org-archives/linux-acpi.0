From: Hollis Blanchard <hollis-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: 02 Aug 2002 13:20:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028312475.23390.63.camel@granite.austin.ibm.com>
References: <20020802172802.GA32612@avalon.paulsen.org>
	<1028315477.18635.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1028315477.18635.113.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Robert C. Paulsen Jr." <robert-J3gkRE/D7QA8RZtLRHdnRF6hYfS7NtTn@public.gmane.org>, Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-08-02 at 14:11, Alan Cox wrote:
> Take a look at cpufreq. The processor speed/voltage side is a solved
> problem with working code for x86 and ARM processors including the
> framework to adjust other devices. For example on ARM you have to frob
> with the RAM clocks. Cpufreq deals with it nicely both from user and
> kernel sides

cpufreq seems entirely aimed at CPU frequency control. Lowering your
frequency will linearly decrease power, but will also linearly extend
the duration of your task. Therefore it makes a lot of sense to lower
voltage in addition to frequency. Some hardware drivers supported in the
cpufreq code already scale down voltage as allowed by frequency
reduction.

However, it also makes sense to decrease frequency independent of
voltage, since voltage transitions can have higher latency than
frequency transitions. The idle task is a great place to lower frequency
only, since you're not doing anything anyways (you're not extending the
running time of a meaningful task), but you may not want to incur the
overhead of a voltage transition every time you come in and out of it.

There are also other frequencies that can affect power consumption, such
as PLB (processor local bus) frequency.

There are situations (especially in dedicated-purpose devices running
only a few hand-written applications) in which it helps to change some
of these values without changing the others. Changing them all according
to a single variable (CPU core frequency) could be very limiting. To my
knowledge the cpufreq code also does not allow for this flexibility, but
certainly it would be nice to add it.

(Perhaps we should continue the thread on linux-pm-devel or cpufreq
instead of cross-posting everywhere?)

-Hollis



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
