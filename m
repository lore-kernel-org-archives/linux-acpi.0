From: Ang Way Chuang <wcang79@gmail.com>
Subject: ACPI reports critical temperature even though the sensors data says
 otherwise
Date: Sun, 08 Apr 2012 11:32:36 +0800
Message-ID: <4F8106D4.7080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55852 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2DHDcj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Apr 2012 23:32:39 -0400
Received: by dake40 with SMTP id e40so4039624dak.11
        for <linux-acpi@vger.kernel.org>; Sat, 07 Apr 2012 20:32:39 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
  I am not sure if this is the right mailing list to ask for help. I have a Dell Vostro 3350 that I have been using for almost one year, but the laptop got a big problem of auto-shutdown from time to time. The problem was ACPI reports critical temperature even though the output of sensors command says otherwise. I had tried Fedora 15, Fedora 16, CentOS 6.2, Ubuntu 11.10 and Ubuntu 12.04-beta2 and many version of kernels, but they all exhibited the same problem. Long story short, this problem occurs when bluetooth is enabled. If I use dual display + bluetooth, the auto-shutdown can be triggered within 5 minutes. If I enable bluetooth without using dual display, the auto-shutdown may take some time before it is triggered. I had enabled ACPI debug in the kernel, but the output is too verbose 
 and I don't understand ACPI well enough to know what's the cause of the problem. Therefore, I would like to ask for your help on this matter. The following is the syslog output from the kernel:

Apr  7 02:12:26 wcang-laptop kernel: [  364.265571]      osl-1128 [430818512] [4294967291] os_wait_semaphore     : Waiting for semaphore[ffff88011b004300|1|65535]
Apr  7 02:12:26 wcang-laptop kernel: [  364.265601]      osl-1147 [430818512] [4294967291] os_wait_semaphore     : Acquired semaphore[ffff88011b004300|1|65535] utmutex-0269 [430818512] [4294967291] ut_acquire_mutex      : Thread 430818512 acquired Mutex [ACPI_MTX_Interpreter]
Apr  7 02:12:26 wcang-laptop kernel: [  364.265655]  exutils-0099 [430818512] [4294967291] ex_enter_interpreter  : ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.265680] utdelete-0678 [430818512] [4294967291] ut_remove_reference   : ----Entry ffff880030afa480
Apr  7 02:12:26 wcang-laptop kernel: [  364.265706] utdelete-0698 [430818512] [4294967291] ut_remove_reference   : Obj ffff880030afa480 Current Refs=1 [To Be Decremented]
Apr  7 02:12:26 wcang-laptop kernel: [  364.265737] utdelete-0486 [430818512] [4294967292] ut_update_object_refer: ----Entry ffff880030afa480
Apr  7 02:12:26 wcang-laptop kernel: [  364.265764] utdelete-0412 [430818512] [4294967292] ut_update_ref_count   : Obj ffff880030afa480 Refs=0, [Decremented]
Apr  7 02:12:26 wcang-laptop kernel: [  364.265795] utdelete-0080 [430818512] [4294967293] ut_delete_internal_obj: ----Entry ffff880030afa480
Apr  7 02:12:26 wcang-laptop kernel: [  364.265821] utdelete-0320 [430818512] [4294967293] ut_delete_internal_obj: Deleting Object ffff880030afa480 [Integer]
Apr  7 02:12:26 wcang-laptop kernel: [  364.265851] utobject-0420 [430818512] [4294967294] ut_delete_object_desc : ----Entry ffff880030afa480
Apr  7 02:12:26 wcang-laptop kernel: [  364.265877] utobject-0432 [430818512] [4294967294] ut_delete_object_desc : ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.265901] utdelete-0323 [430818512] [4294967293] ut_delete_internal_obj: ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.265926] utdelete-0612 [430818512] [4294967292] ut_update_object_refer: ----Exit- AE_OK
Apr  7 02:12:26 wcang-laptop kernel: [  364.265947] utdelete-0706 [430818512] [4294967291] ut_remove_reference   : ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.265963]  exutils-0151 [430818512] [4294967291] ex_exit_interpreter   : ----Entry
Apr  7 02:12:26 wcang-laptop kernel: [  364.265980]  utmutex-0300 [430818512] [4294967291] ut_release_mutex      : Thread 430818512 releasing Mutex [ACPI_MTX_Interpreter]
Apr  7 02:12:26 wcang-laptop kernel: [  364.266001]      osl-1167 [430818512] [4294967291] os_signal_semaphore   : Signaling semaphore[ffff88011b004300|1]
Apr  7 02:12:26 wcang-laptop kernel: [  364.266021]  exutils-0159 [430818512] [4294967291] ex_exit_interpreter   : ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.266038] nsxfeval-0358 [430818512] [4294967290] evaluate_object       : ----Exit- AE_OK
Apr  7 02:12:26 wcang-laptop kernel: [  364.266055]    utils-0286 [430818512] [4294967289] evaluate_integer      : Return value [3732]
Apr  7 02:12:26 wcang-laptop kernel: [  364.266073]  thermal-0212 [430818512] [4294967289] thermal_get_temperatur: Temperature is 3732 dK
Apr  7 02:12:26 wcang-laptop kernel: [  364.266115] Critical temperature reached (100 C), shutting down.
Apr  7 02:12:26 wcang-laptop kernel: [  364.266128] Pid: 4, comm: kworker/0:0 Tainted: G         C   3.3.1+ #4
Apr  7 02:12:26 wcang-laptop kernel: [  364.266135] Call Trace:
Apr  7 02:12:26 wcang-laptop kernel: [  364.266158]  [<ffffffff814ce287>] thermal_zone_device_update+0x1e7/0x2f0
Apr  7 02:12:26 wcang-laptop kernel: [  364.266179]  [<ffffffff810687df>] ? queue_delayed_work_on+0x11f/0x130
Apr  7 02:12:26 wcang-laptop kernel: [  364.266195]  [<ffffffff8136d56c>] ? acpi_os_wait_events_complete+0x23/0x23
Apr  7 02:12:26 wcang-laptop kernel: [  364.266210]  [<ffffffff813ae5ad>] acpi_thermal_notify+0x4c/0x124
Apr  7 02:12:26 wcang-laptop kernel: [  364.266224]  [<ffffffff81370b63>] acpi_device_notify+0x19/0x1b
Apr  7 02:12:26 wcang-laptop kernel: [  364.266240]  [<ffffffff813825c8>] acpi_ev_notify_dispatch+0x6c/0x83
Apr  7 02:12:26 wcang-laptop kernel: [  364.266252]  [<ffffffff8136d593>] acpi_os_execute_deferred+0x27/0x34
Apr  7 02:12:26 wcang-laptop kernel: [  364.266272]  [<ffffffff8106abaa>] process_one_work+0x11a/0x480
Apr  7 02:12:26 wcang-laptop kernel: [  364.266286]  [<ffffffff8106b864>] worker_thread+0x164/0x370
Apr  7 02:12:26 wcang-laptop kernel: [  364.266299]  [<ffffffff8106b700>] ? manage_workers.isra.29+0x230/0x230
Apr  7 02:12:26 wcang-laptop kernel: [  364.266312]  [<ffffffff81070043>] kthread+0x93/0xa0
Apr  7 02:12:26 wcang-laptop kernel: [  364.266329]  [<ffffffff816391a4>] kernel_thread_helper+0x4/0x10
Apr  7 02:12:26 wcang-laptop kernel: [  364.266343]  [<ffffffff8106ffb0>] ? kthread_freezable_should_stop+0x70/0x70
Apr  7 02:12:26 wcang-laptop kernel: [  364.266358]  [<ffffffff816391a0>] ? gs_change+0x13/0x13
Apr  7 02:12:26 wcang-laptop kernel: [  364.266380]  utstate-0339 [430818512] [4294967290] ut_delete_generic_stat: ----Entry
Apr  7 02:12:26 wcang-laptop kernel: [  364.266396]  utstate-0346 [430818512] [4294967290] ut_delete_generic_stat: ----Exit-
Apr  7 02:12:26 wcang-laptop kernel: [  364.266439]  hwvalid-0132 [430818512] [4294967290] hw_validate_io_request: ----Entry

Do note that I don't use any proprietary kernel module and I added dump_stack call to trace the event.

I'll appreciate if someone can give a pointer or two. 

Thank you very much.

Regards,
Ang 


