From: Alexei Gilchrist <alexei-JAjqph6Yjy/o0IyPN7li9Ydd74u8MsAO@public.gmane.org>
Subject: sleep problems on Panasonic W2 toughbook
Date: Mon, 1 Dec 2003 12:24:50 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031201022446.GA24467@physics.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi any help would be greatly appreciated, even what I should be looking at.

Most things work under linux on the Panasonic W2 toughbook except power management (neither APM nor ACPI).
I'm Using kernel 2.6t9.

Alexei Gilchirst

Problems:
 
Screen dim/brightness do not work, switching to external screen doesn't work.

My main problem though is waking the machine:
S3 will put the machine to sleep OK. Hitting the
powerbutton 'wakes' the machine in that the system and network comes back
but the screen/keyboard/mouse remain dead (no backlight either).

Some things I've noticed:

* The access light for the SD card reader remains on after trying to wake.

* ACPI lid and powerbutton events no longer register at /proc/acpi/event

* This gets logged to the console after it wakes (via network connection):

  # qutrit kernel: MCE: The hardware reports a non fatat, correctable incident on CPU 0
  # qutrit kernel: Bank 1: f200000000000111

* /var/log/messages:

Nov 30 20:39:56 qutrit kernel: PM: Preparing system for suspend
Nov 30 20:39:57 qutrit kernel: Stopping tasks: ==================================================================================|
Nov 30 20:39:57 qutrit kernel:  exmutex-0172: *** Error: Cannot acquire Mutex [HDMX], incorrect sync_level
Nov 30 20:39:57 qutrit kernel: dswstate-0211 [150409] ds_result_pop         : Result stack is empty! State=df2fd028
Nov 30 20:39:57 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_SB_.HKEY.HSAV] (Node df65ef28), AE_AML_MUTEX_ORDER
Nov 30 20:39:57 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_PTS] (Node df674da8), AE_AML_MUTEX_ORDER
Nov 30 20:39:57 qutrit kernel: hdc: start_power_step(step: 0)
Nov 30 20:39:57 qutrit kernel: hdc: completing PM request, suspend
Nov 30 20:39:57 qutrit kernel: hda: start_power_step(step: 0)
Nov 30 20:39:57 qutrit kernel: hda: start_power_step(step: 1)
Nov 30 20:39:57 qutrit kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Nov 30 20:39:57 qutrit kernel: hda: completing PM request, suspend
Nov 30 20:39:57 qutrit kernel: bad: scheduling while atomic!
Nov 30 20:39:57 qutrit kernel: Call Trace:
Nov 30 20:39:57 qutrit kernel:  [schedule+60/1268] schedule+0x3c/0x4f4
Nov 30 20:39:57 qutrit kernel:  [__mod_timer+245/336] __mod_timer+0xf5/0x150
Nov 30 20:39:57 qutrit kernel:  [schedule_timeout+128/168] schedule_timeout+0x80/0xa8
Nov 30 20:39:57 qutrit kernel:  [schedule_timeout+136/168] schedule_timeout+0x88/0xa8
Nov 30 20:39:57 qutrit kernel:  [process_timeout+0/12] process_timeout+0x0/0xc
Nov 30 20:39:57 qutrit kernel:  [pci_set_power_state+256/296] pci_set_power_state+0x100/0x128
Nov 30 20:39:58 qutrit kernel:  [rtl8139_suspend+100/140] rtl8139_suspend+0x64/0x8c
Nov 30 20:39:58 qutrit kernel:  [pci_device_suspend+29/44] pci_device_suspend+0x1d/0x2c
Nov 30 20:39:58 qutrit kernel:  [suspend_device+33/188] suspend_device+0x21/0xbc
Nov 30 20:39:58 qutrit kernel:  [device_suspend+72/120] device_suspend+0x48/0x78
Nov 30 20:39:58 qutrit kernel:  [suspend_prepare+85/136] suspend_prepare+0x55/0x88
Nov 30 20:39:58 qutrit kernel:  [enter_state+69/136] enter_state+0x45/0x88
Nov 30 20:39:58 qutrit kernel:  [pm_suspend+18/36] pm_suspend+0x12/0x24
Nov 30 20:39:58 qutrit kernel:  [acpi_suspend+46/68] acpi_suspend+0x2e/0x44
Nov 30 20:39:58 qutrit kernel:  [acpi_system_write_sleep+230/256] acpi_system_write_sleep+0xe6/0x100
Nov 30 20:39:58 qutrit kernel:  [dupfd+38/120] dupfd+0x26/0x78
Nov 30 20:39:58 qutrit kernel:  [vfs_write+160/208] vfs_write+0xa0/0xd0
Nov 30 20:39:58 qutrit kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Nov 30 20:39:58 qutrit kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 30 20:39:58 qutrit kernel: 
Nov 30 20:39:58 qutrit kernel: PM: Entering state.
Nov 30 20:39:58 qutrit kernel:  hwsleep-0257 [150400] acpi_enter_sleep_state: Entering sleep state [S3]
Nov 30 20:39:58 qutrit kernel: Back to C!
Nov 30 20:39:58 qutrit kernel: PM: Finishing up.
Nov 30 20:39:58 qutrit kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Nov 30 20:39:58 qutrit kernel: PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
Nov 30 20:39:58 qutrit kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Nov 30 20:39:58 qutrit kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Nov 30 20:39:58 qutrit kernel: Bank 1: f200000000000111
Nov 30 20:39:58 qutrit kernel: AC'97 warm reset still in progress? [0xffffffff]
Nov 30 20:39:58 qutrit kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov 30 20:39:58 qutrit kernel: codec_write 0: semaphore is not ready for register 0x26
  ... whole heap of these lines ...
  ... whole heap of these lines ...
Nov 30 20:39:59 qutrit kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Nov 30 20:39:59 qutrit kernel: PCMCIA: socket df498430: *** DANGER *** unable to remove socket power
Nov 30 20:39:59 qutrit kernel: hda: Wakeup request inited, waiting for !BSY...
Nov 30 20:39:59 qutrit kernel: hda: start_power_step(step: 1000)
Nov 30 20:39:59 qutrit kernel: hda: completing PM request, resume
Nov 30 20:39:59 qutrit kernel: hdc: Wakeup request inited, waiting for !BSY...
Nov 30 20:39:59 qutrit kernel: hdc: start_power_step(step: 1000)
Nov 30 20:39:59 qutrit kernel: hdc: completing PM request, resume
Nov 30 20:39:59 qutrit kernel:  exmutex-0172: *** Error: Cannot acquire Mutex [ECEX], incorrect sync_level
Nov 30 20:39:59 qutrit kernel: dswstate-0211 [150410] ds_result_pop         : Result stack is empty! State=d33a1028
Nov 30 20:39:59 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_.EC87] (Node df66aca8), AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_.EC86] (Node df66ada8), AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_.EC02] (Node df66bba8), AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_SB_.ECPF] (Node df676d28), AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel:  psparse-1120: *** Error: Method execution failed [\_WAK] (Node df674ca8), AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel:  hwsleep-0423: *** Error: Method _WAK failed, AE_AML_MUTEX_ORDER
Nov 30 20:39:59 qutrit kernel: Restarting tasks...<6> Strange, gnuclient not stopped
Nov 30 20:39:59 qutrit kernel:  Strange, xemacs not stopped
Nov 30 20:39:59 qutrit kernel:  done



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
