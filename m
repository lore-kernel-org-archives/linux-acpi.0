From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: mutexes and preemption
Date: Wed, 3 Mar 2004 12:43:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040303114304.GA1513@ergo.gotdns.org>
References: <20040302225117.GA1660@ergo.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040302225117.GA1660-nlVyBo/8EO9N0TnZuCh8vA@public.gmane.org>
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

On Tue, Mar 02, 2004 at 11:51:17PM +0100, Sebastian Seifert wrote:
> some vital information first: I'm using kernel 2.6.3-mm4 with DSDT in ramdisk
> patch applied, preemption is enabled, SMP disabled. 
> 
> I'm currently debugging the DSDT of my laptop (Benq Joybook 5000). Some ACPI
> method calls seem to be failing because of double acquisition of a mutex. One
> reproducible way to trigger the problem is to read the ac adapter's state.  My
> syslog looks like this (I set debug_level to 31 and added printks in
> exoparg?.c):

There was a mistake in the last log I quoted - since I had changed the
notify value while playing around, I changed it back in the log. I
didn't realize it would be handled differently.

Anyway, I have done some experiments. I've done
echo 31 > /proc/acpi/debug_level
cat /proc/acpi/ac_adapter/AC/state
on different configurations of kernel and DSDT.

In my DSDT, the Acquire calls have a timeout value of 0x0FFF. If I leave
it at 0x0FFF on a preemptive kernel, the error happens. If I disable
preemption but leave the timeout at 0x0FFF, the error disappears. And if
I change the timeout of the Acquire calls to "0xFFFF" (i.e. they do not
time out) but leave on preemtion, the error disappears (but I still get
a single line "Failed to acquire semaphore"). 

Maybe someone can make sense out of the three logs that follow.

----- preemptive kernel, 0x0FFF timeout ------
r  3 12:21:01 tenshi kernel: Execute Method: [\_SB_.AC__._PSR] (Node dff60f88)
Mar  3 12:21:01 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1404 (57C)
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [216] acpi_ec_read          : Read [00] from address [92]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [221] acpi_ec_read          : Read [31] from address [9c]
Mar  3 12:21:01 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1404 (57C)
Mar  3 12:21:01 tenshi kernel:   evmisc-0121 [215] ev_queue_notify_reques: Dispatching Notify(81) on node dff61ca8
Mar  3 12:21:01 tenshi kernel:   evmisc-0141 [215] ev_queue_notify_reques: Unknown Notify Value: 81 
Mar  3 12:21:01 tenshi kernel: Execute Method: [\_TZ_.THZN._CRT] (Node dff61948)
Mar  3 12:21:01 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1404 (57C)
Mar  3 12:21:01 tenshi kernel: acpi_utils-0267 [229] acpi_evaluate_integer : Return value [3752]
Mar  3 12:21:01 tenshi kernel: acpi_thermal-0333 [228] acpi_thermal_get_trip_: Found critical threshold [3752]
Mar  3 12:21:01 tenshi kernel: acpi_utils-0256 [229] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._HOT]: AE_NOT_FOUND
Mar  3 12:21:01 tenshi kernel: acpi_thermal-0341 [228] acpi_thermal_get_trip_: No hot threshold
Mar  3 12:21:01 tenshi kernel: acpi_utils-0256 [229] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._PSV]: AE_NOT_FOUND
Mar  3 12:21:01 tenshi kernel: acpi_thermal-0353 [228] acpi_thermal_get_trip_: No passive threshold
Mar  3 12:21:01 tenshi kernel: Execute Method: [\_TZ_.THZN._AC0] (Node dff61a68)
Mar  3 12:21:01 tenshi kernel: acpi_utils-0267 [229] acpi_evaluate_integer : Return value [3380]
Mar  3 12:21:01 tenshi kernel: acpi_utils-0399 [229] acpi_evaluate_referenc: Found reference [dff620e8]
Mar  3 12:21:01 tenshi kernel: acpi_thermal-0394 [228] acpi_thermal_get_trip_: Found active threshold [0]:[3380]
Mar  3 12:21:01 tenshi kernel: Execute Method: [\_TZ_.THZN._AC1] (Node dff61b88)
Mar  3 12:21:01 tenshi kernel: acpi_utils-0267 [229] acpi_evaluate_integer : Return value [3280]
Mar  3 12:21:01 tenshi kernel: acpi_utils-0399 [229] acpi_evaluate_referenc: Found reference [dff61e28]
Mar  3 12:21:01 tenshi kernel: acpi_thermal-0394 [228] acpi_thermal_get_trip_: Found active threshold [1]:[3280]
Mar  3 12:21:01 tenshi kernel: acpi_utils-0256 [229] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._AC2]: AE_NOT_FOUND
Mar  3 12:21:01 tenshi kernel: Execute Method: [\_TZ_.THZN._TMP] (Node dff61c48)
Mar  3 12:21:01 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  3 12:21:01 tenshi kernel:      osl-0909 [243] os_wait_semaphore     : Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  3 12:21:01 tenshi kernel:      osl-0909 [243] os_wait_semaphore     : Failed to acquire semaphore[dffd8680|1|4095], AE_TIME
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [248] acpi_ec_read          : Read [31] from address [9c]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [248] acpi_ec_read          : Read [00] from address [9d]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [248] acpi_ec_read          : Read [37] from address [9e]
Mar  3 12:21:01 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)
Mar  3 12:21:01 tenshi kernel:  exmutex-0264: *** Error: Thread 3 cannot release Mutex [MUT1] acquired by thread 57C
Mar  3 12:21:01 tenshi kernel:  psparse-1120: *** Error: Method execution failed [\_TZ_.THZN._TMP] (Node dff61c48), AE_AML_NOT_OWNER
Mar  3 12:21:01 tenshi kernel: acpi_utils-0256 [230] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._TMP]: AE_AML_NOT_OWNER
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [228] acpi_ec_read          : Read [00] from address [9d]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0230 [231] acpi_ec_write         : Wrote [00] to address [9d]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [235] acpi_ec_read          : Read [37] from address [9e]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0230 [241] acpi_ec_write         : Wrote [37] to address [9e]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0178 [247] acpi_ec_read          : Read [00] from address [a0]
Mar  3 12:21:01 tenshi kernel:  acpi_ec-0230 [252] acpi_ec_write         : Wrote [00] to address [a0]
Mar  3 12:21:01 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1404 (57C)
Mar  3 12:21:01 tenshi kernel: exregion-0372 [257] ex_pci_config_space_ha: pci_config 0 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:21:01 tenshi kernel: exregion-0372 [257] ex_pci_config_space_ha: pci_config 1 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:21:01 tenshi kernel: acpi_utils-0267 [239] acpi_evaluate_integer : Return value [0]
------------------------------------------------

----- nonpreemptive kernel, 0x0FFF timeout  -------
Mar  3 12:28:22 tenshi kernel: Execute Method: [\_SB_.AC__._PSR] (Node dff60f88)
Mar  3 12:28:22 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1427 (593)
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [72] acpi_ec_read          : Read [00] from address [92]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [72] acpi_ec_read          : Read [31] from address [9c]
Mar  3 12:28:22 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1427 (593)
Mar  3 12:28:22 tenshi kernel:   evmisc-0121 [63] ev_queue_notify_reques: Dispatching Notify(81) on node dff61ca8
Mar  3 12:28:22 tenshi kernel:   evmisc-0141 [63] ev_queue_notify_reques: Unknown Notify Value: 81
Mar  3 12:28:22 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1427 (593)
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [73] acpi_ec_read          : Read [00] from address [9d]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0230 [73] acpi_ec_write         : Wrote [00] to address [9d]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [73] acpi_ec_read          : Read [37] from address [9e]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0230 [73] acpi_ec_write         : Wrote [37] to address [9e]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [73] acpi_ec_read          : Read [00] from address [a0]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0230 [73] acpi_ec_write         : Wrote [00] to address [a0]
Mar  3 12:28:22 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1427 (593)
Mar  3 12:28:22 tenshi kernel: exregion-0372 [72] ex_pci_config_space_ha: pci_config 0 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:28:22 tenshi kernel: exregion-0372 [72] ex_pci_config_space_ha: pci_config 1 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:28:22 tenshi kernel: acpi_utils-0267 [54] acpi_evaluate_integer : Return value [0]
Mar  3 12:28:22 tenshi kernel: Execute Method: [\_TZ_.THZN._CRT] (Node dff61948)
Mar  3 12:28:22 tenshi kernel: acpi_utils-0267 [57] acpi_evaluate_integer : Return value [3752]
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0333 [56] acpi_thermal_get_trip_: Found critical threshold [3752]
Mar  3 12:28:22 tenshi kernel: acpi_utils-0256 [57] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._HOT]: AE_NOT_FOUND
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0341 [56] acpi_thermal_get_trip_: No hot threshold
Mar  3 12:28:22 tenshi kernel: acpi_utils-0256 [57] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._PSV]: AE_NOT_FOUND
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0353 [56] acpi_thermal_get_trip_: No passive threshold
Mar  3 12:28:22 tenshi kernel: Execute Method: [\_TZ_.THZN._AC0] (Node dff61a68)
Mar  3 12:28:22 tenshi kernel: acpi_utils-0267 [57] acpi_evaluate_integer : Return value [3380]
Mar  3 12:28:22 tenshi kernel: acpi_utils-0399 [57] acpi_evaluate_referenc: Found reference [dff620e8]
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0394 [56] acpi_thermal_get_trip_: Found active threshold [0]:[3380]
Mar  3 12:28:22 tenshi kernel: Execute Method: [\_TZ_.THZN._AC1] (Node dff61b88)
Mar  3 12:28:22 tenshi kernel: acpi_utils-0267 [57] acpi_evaluate_integer : Return value [3280]
Mar  3 12:28:22 tenshi kernel: acpi_utils-0399 [57] acpi_evaluate_referenc: Found reference [dff61e28]
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0394 [56] acpi_thermal_get_trip_: Found active threshold [1]:[3280]
Mar  3 12:28:22 tenshi kernel: acpi_utils-0256 [57] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._AC2]: AE_NOT_FOUND
Mar  3 12:28:22 tenshi kernel: Execute Method: [\_TZ_.THZN._TMP] (Node dff61c48)
Mar  3 12:28:22 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [76] acpi_ec_read          : Read [31] from address [9c]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [76] acpi_ec_read          : Read [00] from address [9d]
Mar  3 12:28:22 tenshi kernel:  acpi_ec-0178 [76] acpi_ec_read          : Read [37] from address [9e]
Mar  3 12:28:22 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)
Mar  3 12:28:22 tenshi kernel: acpi_utils-0267 [58] acpi_evaluate_integer : Return value [3220]
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0229 [57] acpi_thermal_get_tempe: Temperature is 3220 dK
Mar  3 12:28:22 tenshi kernel: acpi_thermal-0740 [56] acpi_thermal_check    : THZN: temperature[3220] sleep[0]
------------------------------------------------------

----- preemptive kernel, 0xFFFF timeout = no timeout -----
Mar  3 12:16:38 tenshi kernel: Execute Method: [\_SB_.AC__._PSR] (Node dff60f88)
Mar  3 12:16:38 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1450 (5AA)
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [87] acpi_ec_read          : Read [00] from address [92]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [93] acpi_ec_read          : Read [36] from address [9c]
Mar  3 12:16:38 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1450 (5AA)
Mar  3 12:16:38 tenshi kernel:   evmisc-0121 [90] ev_queue_notify_reques: Dispatching Notify(81) on node dff61ca8
Mar  3 12:16:38 tenshi kernel:   evmisc-0141 [90] ev_queue_notify_reques: Unknown Notify Value: 81
Mar  3 12:16:38 tenshi kernel: Execute Method: [\_TZ_.THZN._CRT] (Node dff61948)
Mar  3 12:16:38 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1450 (5AA)
Mar  3 12:16:38 tenshi kernel: acpi_utils-0267 [104] acpi_evaluate_integer : Return value [3752]
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0333 [103] acpi_thermal_get_trip_: Found critical threshold [3752]
Mar  3 12:16:38 tenshi kernel: acpi_utils-0256 [104] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._HOT]: AE_NOT_FOUND
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0341 [103] acpi_thermal_get_trip_: No hot threshold
Mar  3 12:16:38 tenshi kernel: acpi_utils-0256 [104] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._PSV]: AE_NOT_FOUND
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0353 [103] acpi_thermal_get_trip_: No passive threshold
Mar  3 12:16:38 tenshi kernel: Execute Method: [\_TZ_.THZN._AC0] (Node dff61a68)
Mar  3 12:16:38 tenshi kernel: acpi_utils-0267 [104] acpi_evaluate_integer : Return value [3380]
Mar  3 12:16:38 tenshi kernel: acpi_utils-0399 [104] acpi_evaluate_referenc: Found reference [dff620e8]
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0394 [103] acpi_thermal_get_trip_: Found active threshold [0]:[3380]
Mar  3 12:16:38 tenshi kernel: Execute Method: [\_TZ_.THZN._AC1] (Node dff61b88)
Mar  3 12:16:38 tenshi kernel: acpi_utils-0267 [104] acpi_evaluate_integer : Return value [3280]
Mar  3 12:16:38 tenshi kernel: acpi_utils-0399 [104] acpi_evaluate_referenc: Found reference [dff61e28]
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0394 [103] acpi_thermal_get_trip_: Found active threshold [1]:[3280]
Mar  3 12:16:38 tenshi kernel: acpi_utils-0256 [104] acpi_evaluate_integer : Evaluate [\_TZ_.THZN._AC2]: AE_NOT_FOUND
Mar  3 12:16:38 tenshi kernel: Execute Method: [\_TZ_.THZN._TMP] (Node dff61c48)
Mar  3 12:16:38 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  3 12:16:38 tenshi kernel:      osl-0909 [118] os_wait_semaphore     : Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [118] acpi_ec_read          : Read [32] from address [9d]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0230 [118] acpi_ec_write         : Wrote [32] to address [9d]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [118] acpi_ec_read          : Read [41] from address [9e]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0230 [118] acpi_ec_write         : Wrote [41] to address [9e]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [118] acpi_ec_read          : Read [00] from address [a0]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0230 [118] acpi_ec_write         : Wrote [00] to address [a0]
Mar  3 12:16:38 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1450 (5AA)
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [123] acpi_ec_read          : Read [36] from address [9c]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [123] acpi_ec_read          : Read [32] from address [9d]
Mar  3 12:16:38 tenshi kernel:  acpi_ec-0178 [123] acpi_ec_read          : Read [41] from address [9e]
Mar  3 12:16:38 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)
Mar  3 12:16:38 tenshi kernel: acpi_utils-0267 [105] acpi_evaluate_integer : Return value [3270]
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0229 [104] acpi_thermal_get_tempe: Temperature is 3270 dK
Mar  3 12:16:38 tenshi kernel: acpi_thermal-0740 [103] acpi_thermal_check    : THZN: temperature[3270] sleep[0]
Mar  3 12:16:38 tenshi kernel: exregion-0372 [101] ex_pci_config_space_ha: pci_config 0 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:16:38 tenshi kernel: exregion-0372 [101] ex_pci_config_space_ha: pci_config 1 (8) Seg(0000) Bus(0000) Dev(001f) Func(0000) Reg(00a0)
Mar  3 12:16:38 tenshi kernel: acpi_utils-0267 [83] acpi_evaluate_integer : Return value [0]
------------------------------------------------------------


Sebastian


-- 
"God is as real as I am," the old man said.  My faith was restored, for I
knew that Santa would never lie.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
