From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Suspend-to-RAM on Sony Vaios
Date: Tue, 19 Oct 2004 17:25:30 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057559A05A@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luc Saillard <luc.saillard-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yes, this is a known issue - link device resume must be with irq
enabled. Could you please try if below workaround makes any difference
in your system.

Thanks,
Shaohua



=3D=3D=3D=3D=3D drivers/acpi/pci_link.c 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/drivers/acpi/pci_link.c        2004-08-19 07:26:48 +08:00
+++ edited/drivers/acpi/pci_link.c      2004-10-19 17:15:09 +08:00
@@ -714,7 +714,10 @@ irqrouter_resume(
 {
        struct list_head        *node =3D NULL;
        struct acpi_pci_link    *link =3D NULL;
+       unsigned long flag;

+       local_save_flags(flag);
+       local_irq_disable();
        ACPI_FUNCTION_TRACE("irqrouter_resume");

        list_for_each(node, &acpi_link.entries) {
@@ -727,6 +730,7 @@ irqrouter_resume(

                acpi_pci_link_resume(link);
        }
+       local_irq_restore(flag);
        return_VALUE(0);
 }

@@ -851,7 +855,7 @@ static int __init irqrouter_init_sysfs(v
        return_VALUE(error);
 }

-device_initcall(irqrouter_init_sysfs);
+fs_initcall(irqrouter_init_sysfs);


 static int __init acpi_pci_link_init (void)

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Luc Saillard
>Sent: Tuesday, October 19, 2004 4:11 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Suspend-to-RAM on Sony Vaios
>
>On Mon, Oct 18, 2004 at 02:08:16AM +0200, Jon Valvatne wrote:
>> Hello list,
>>
>> I'd very much like to get suspend-to-RAM working on my Vaio X505; any
>> pointers would be very welcome. Trying with the latest RPM-kernel for
FC2,
>> I can get it suspended just fine (after removing the ehci_hcd
module),
>but
>> it doesn't come back up.
>>
>
>For the first time, with a vanilla 2.6.9-rc4, S3 works on my laptop.
It's a
>Sony PCG-Z1RMP. If I echo 3 > /proc/acpi/sleep while i'm in console,
resume
>doesn't light on the screen (radeontool has the same problem). I can
reboot,
>send command on my shell, but if I start X, my laptop freeze.
>If I'm under X, suspend and resume works but if i go to console text
screen
>is black of bad video resolution.
>
>I've also a problem with kmalloc(GFP_KERNEL) and resume while interrupt
is
>disabled.
>
>PM: Preparing system for suspend
>Stopping tasks: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
>PM: Entering state.
>Back to C!
>Debug: sleeping function called from invalid context at mm/slab.c:2052
>in_atomic():0, irqs_disabled():1
> [__might_sleep+182/224] __might_sleep+0xb6/0xe0
> [__kmalloc+138/160] __kmalloc+0x8a/0xa0
> [acpi_os_allocate+10/11] acpi_os_allocate+0xa/0xb
> [acpi_ut_allocate+52/87] acpi_ut_allocate+0x34/0x57
> [acpi_ut_initialize_buffer+66/125] acpi_ut_initialize_buffer+0x42/0x7
> [acpi_rs_create_byte_stream+35/57] acpi_rs_create_byte_stream+0x23/0x
> [acpi_rs_set_srs_method_data+27/157] acpi_rs_set_srs_method_data+0x1b
> [recalc_task_prio+151/400] recalc_task_prio+0x97/0x190
> [acpi_pci_link_set+222/341] acpi_pci_link_set+0xde/0x155
> [irqrouter_resume+28/48] irqrouter_resume+0x1c/0x30
> [sysdev_resume+247/252] sysdev_resume+0xf7/0xfc
> [device_power_up+5/10] device_power_up+0x5/0xa
> [suspend_enter+48/80] suspend_enter+0x30/0x50
> [enter_state+101/160] enter_state+0x65/0xa0
> [acpi_suspend+59/73] acpi_suspend+0x3b/0x49
> [copy_from_user+84/144] copy_from_user+0x54/0x90
> [acpi_system_write_sleep+93/110] acpi_system_write_sleep+0x5d/0x6e
> [vfs_write+176/272] vfs_write+0xb0/0x110
> [sys_write+71/128] sys_write+0x47/0x80
> [syscall_call+7/11] syscall_call+0x7/0xb
>sonypi: unknown event port1=3D0x0e,port2=3D0x05
>PM: Finishing up.
>
>
>Luc
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on
ITManagersJournal
>Use IT products in your business? Tell us what you think of them. Give
us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
