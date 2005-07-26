From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: [Fastboot] Fw: Problems with reboot/poweroff on SMP machine
Date: Tue, 26 Jul 2005 01:44:18 -0600
Message-ID: <m1br4qf1v1.fsf@ebiederm.dsl.xmission.com>
References: <20050725142951.6d47ca32.akpm@osdl.org>
	<m1ackah4r3.fsf@ebiederm.dsl.xmission.com>
	<42E5B533.60107@ribosome.natur.cuni.cz>
	<m1sly2fbw0.fsf@ebiederm.dsl.xmission.com>
	<m1oe8qf4er.fsf@ebiederm.dsl.xmission.com>
	<20050726002258.1591de62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050726002258.1591de62.akpm-3NddpPZAyC0@public.gmane.org> (Andrew Morton's
 message of "Tue, 26 Jul 2005 00:22:58 -0700")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, mmokrejs-FKSC99mem8wheYDy1lqhK0JFmxxWawaa@public.gmane.org, sjordet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fastboot-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, zlatko.calusic-2lF7rBilFQQ@public.gmane.org, linux-kernel-xyiX3/p4JzBDPfheJLI6IQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org> writes:

> (Added acpi people)
>
> I have a vague feeling that adding local_irq_disable() to acpi_power_off()
> is illegal.

I didn't my preliminary patch just fat fingered that line.
All I was really doing was removing acpi_sleep_prepare(),
to be certain we weren't calling it at the wrong time.


> void acpi_power_off(void)
> {
> 	printk("%s called\n", __FUNCTION__);
> 	local_irq_disable();
> 	acpi_enter_sleep_state(ACPI_STATE_S5);
> }
>
> Can an ACPI person please comment?

>From drivers/acpi/hwsleep.c
> /*******************************************************************************
>  *
>  * FUNCTION:    acpi_enter_sleep_state
>  *
>  * PARAMETERS:  sleep_state         - Which sleep state to enter
>  *
>  * RETURN:      Status
>  *
>  * DESCRIPTION: Enter a system sleep state (see ACPI 2.0 spec p 231)
>  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
>  *
>  ******************************************************************************/
> 
> acpi_status asmlinkage
> acpi_enter_sleep_state (

So at least according to the comments it would be an error
to call that function with interrupts enabled.

So either there is some weird control flow going on that gets
acpi_sleep_prepare called with interrupts disabled.  Or there
is an entirely different problem showing up with acpi_power_off.

My current hunch is some very weird control flow possibly the system
devices not being shutdown in the expected order but I don't know
at the moment.  

I have one bug report that remove the i8259A shutdown fixes
the problem in 2.6.13-rc2.  What I am having a very hard time
seeing is how it could possibly make a difference.

Eric


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
