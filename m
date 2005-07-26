From: =?windows-1252?Q?Martin_MOKREJ=8A?= <mmokrejs-FKSC99mem8wheYDy1lqhK0JFmxxWawaa@public.gmane.org>
Subject: Re: [Fastboot] Fw: Problems with reboot/poweroff on SMP machine
Date: Tue, 26 Jul 2005 11:13:18 +0200
Message-ID: <42E5FEAE.2010208@ribosome.natur.cuni.cz>
References: <20050725142951.6d47ca32.akpm@osdl.org>	<m1ackah4r3.fsf@ebiederm.dsl.xmission.com>	<42E5B533.60107@ribosome.natur.cuni.cz>	<m1sly2fbw0.fsf@ebiederm.dsl.xmission.com>	<m1oe8qf4er.fsf@ebiederm.dsl.xmission.com> <20050726002258.1591de62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050726002258.1591de62.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, sjordet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fastboot-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, zlatko.calusic-2lF7rBilFQQ@public.gmane.org, linux-kernel-xyiX3/p4JzBDPfheJLI6IQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The patch below really doesn't help of ASUS P4C800E-Deluxe when
applied to plain 2.6.13-rc3-git7. The machines turns the power immediately
again.
Martin

Andrew Morton wrote:
> (Added acpi people)
> 
> ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman) wrote:
> 
>>ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman) writes:
>>
>>
>>>Martin MOKREJ___ <mmokrejs-FKSC99mem8wheYDy1lqhK0JFmxxWawaa@public.gmane.org> writes:
>>>
>>>
>>>>Hi Eric,
>>>>  I don't know if I was epxected to test this right away, but
>>>>I just tried over acpi patched sources on my i686:
>>>
>>>Thanks.  That is my bug. 
>>>
>>>I knew the code wasn't quite right but I missed how off it
>>>was :)
>>>
>>>Just remove the BUG_ON(!shutdown_prepared) line and it should
>>>compile.  I don't know why I though I could read a static
>>>variable in another function...
>>
>>I am now officially confused.  My patch might clean up a corner
>>case or two but it really should not help, because the issue
>>I was worried about is mostly fixed.
>>
>>All of the pieces are there for the acpi power off case to work
>>correctly so is beginning to look like a completely different bug
>>then what I am suspecting.  Anyone who can testing of my patch
>>would be a help.
>>
>>The only other interesting data point I can think of at the moment
>>is the attached patch below.  
>>
>>I want to know if acpi_power_off is having problems because interrupts
>>get disabled.
> 
> 
> I have a vague feeling that adding local_irq_disable() to acpi_power_off()
> is illegal.
> 
> void acpi_power_off(void)
> {
> 	printk("%s called\n", __FUNCTION__);
> 	local_irq_disable();
> 	acpi_enter_sleep_state(ACPI_STATE_S5);
> }
> 
> Can an ACPI person please comment?
> 
> 
>>Eric
>>
>>diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
>>--- a/arch/i386/kernel/i8259.c
>>+++ b/arch/i386/kernel/i8259.c
>>@@ -283,7 +283,7 @@ static struct sysdev_class i8259_sysdev_
>>        set_kset_name("i8259"),
>>        .suspend = i8259A_suspend,
>>        .resume = i8259A_resume,
>>-       .shutdown = i8259A_shutdown,
>>+//     .shutdown = i8259A_shutdown,
>> };
>>
>> static struct sys_device device_i8259A = {
> 
> 
> 

-- 
Martin Mokrejs
Email: 'bW9rcmVqc21Acmlib3NvbWUubmF0dXIuY3VuaS5jeg==\n'.decode('base64')
GPG key is at http://www.natur.cuni.cz/~mmokrejs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
