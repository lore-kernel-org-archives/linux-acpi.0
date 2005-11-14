From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: New Smart Battery release (incl. updated embedded controller patches)
Date: Mon, 14 Nov 2005 18:05:52 +0800
Message-ID: <200511141805.54633.luming.yu@intel.com>
References: <4376BD90.5080603@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4376BD90.5080603-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 November 2005 12:14, Rich Townsend wrote:
> I'm pleased to announce that, after quite a long period of inactivity, I've
>  finally managed to grab enough spare time from the real world to bring the
>  SBS-CM (Smart Battery System/Control Method) project up to date.

Nice to see update on smart battery.
I'm curious if you plan to have a smart battery driver without  hacking DSDT.

> However, I've included new patches for replacing the spinlock mutexing in
> the embedded controller (EC) driver with semaphore mutexing. In addition to
> the kernel 2.6.10 and 2.6.11 patches included in previous releases, I now
> provide patches for 2.6.12. 2.6.13 and 2.6.14 kernels. I intend to offer a
> 2.6.15 patch once this kernel version becomes the current version.
>
>  Why are these patches still necessary? Yuming Lu has done some great work
>  getting EC burst mode working under Linux; I believe all kernels since
> 2.6.13 contain the burst mode code by default. Unfortunately, however,
> burst mode does not fix the problems that the spinlock patches were
> designed to fix.

I'm wondering why. Because, my patch has two parts. One part is to remove 
spin_lock_irqsave like what your patch did. Another part is employing 
pure-interrupt based ec handling with burst-mode enabled for ec_read and 
ec_write. So, my assumption is if your spinlock patch works, my patch should
work too.

>
>  To be specific: I have fixed my kernel (2.6.13) with Yuming's most recent
> patch that prevents the boot process from stalling when the EC driver is
> loaded. Booting with burst mode enabled (boot parameter ec_burst=1) gets
> into immediate trouble if I have the thermal zone ACPI driver loaded, since
> my computer thinks the cpu is at 250C. This is indicative that the EC is
> not working properly.

I'd like to find out the root cause . For your information, I do hear some 
thermal related issues which is not root caused as ec issues.

>
>  Then, after disabling the thermal zone stuff, my computer boots up OK but
> still shows all the symptoms of lost interrupts. Furthermore, after 10
> minutes of uptime, I notice that the kacpid task has expended nearly 3
> seconds of CPU time. This expenditure is wholly due to the EC access, and
> indicates that for 3 seconds out of 10 minutes, the EC burst code is not
> interruptible -- hence the lost interrupts.
If I remember clealy, my latest ec code has removed spin_lock_irqave for code 
patch of ec_burst=1.

>
>  While I will certainly agree that my own patches are not nearly as elegant
> as the burst mode solution, I must point out that they do not lead to any
> lost interrupts at all -- I don't lose any keypresses, and the kacpid task
> doesn't use up any CPU time.
>
>  I would really appreciate it if those involved in maintaining the EC code
> --- both Yuming and perhaps Len Brown --- could get in touch with me and
> help sort out a way to get EC burst mode working without lost interrupts.
> When that's done, I'll feel much more comfortable about focusing on porting
> my SBS stuff to the HAL, which is where it belongs.

I want to root cause  this problem.
Would you like to open a tracker on bugzilla.kernel.org?

Thanks,
Luming


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
