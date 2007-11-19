From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [Bugme-new] [Bug 9398] New: BUG: soft lockup detected on CPU#0!
Date: Mon, 19 Nov 2007 16:30:59 -0500
Message-ID: <47420093.9040505@redhat.com>
References: <bug-9398-10286@http.bugzilla.kernel.org/> <20071116153247.b1e99f9e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbXKSVbx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 16:31:53 -0500
In-Reply-To: <20071116153247.b1e99f9e.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cijoml@volny.cz, bugme-daemon@bugzilla.kernel.org, stable@kernel.org, linux-acpi@vger.kernel.org

On 11/16/2007 06:32 PM, Andrew Morton wrote:
> (switched to email.  Please reply via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Fri, 16 Nov 2007 14:56:13 -0800 (PST)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=9398
>>
>>            Summary: BUG: soft lockup detected on CPU#0!
>>            Product: Other
>>            Version: 2.5
>>      KernelVersion: 2.6.23.8
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: Other
>>         AssignedTo: other_other@kernel-bugs.osdl.org
>>         ReportedBy: cijoml@volny.cz
>>
>>
>> Most recent kernel where this bug did not occur: 2.6.23.0
> 
> Ow.  Are you sure?  This is a regression which was added into the 2.6.23
> stable tree?
> 
>> Distribution: Debian stable
>> Hardware Environment: Pentium M laptop
>> Software Environment: Debian stable
>> Problem Description:
>>
>> Steps to reproduce:
>>
>> i2c-adapter i2c-5: SMBus Quick command not supported, can't probe for chips
>> i2c-adapter i2c-6: SMBus Quick command not supported, can't probe for chips
>> pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
>> pcmcia: This interface will soon be removed from the kernel; please expect
>> breakage unless you upgrade to new tools.
>> pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
>> details.
>> eth0: link down
>> ieee80211_crypt: registered algorithm 'TKIP'
>> BUG: soft lockup detected on CPU#0!
>>  [<c0140bf4>] softlockup_tick+0x90/0xaf
>>  [<c0120a17>] update_process_times+0x32/0x54
>>  [<c012edfd>] tick_periodic+0x6e/0x78
>>  [<c012ee16>] tick_handle_periodic+0xf/0x5d
>>  [<c0126390>] insert_work+0x59/0x5c
>>  [<c012ef3c>] tick_do_broadcast+0x1f/0x3f
>>  [<c012f05a>] tick_do_periodic_broadcast+0x1a/0x31
>>  [<c012f08c>] tick_handle_periodic_broadcast+0x1b/0x5b
>>  [<c01272fb>] __rcu_process_callbacks+0x112/0x170
>>  [<c0106e83>] timer_interrupt+0x34/0x3d
>>  [<c0140e66>] handle_IRQ_event+0x1a/0x3f
>>  [<c01420df>] handle_level_irq+0x77/0xd0
>>  [<c01061c5>] do_IRQ+0x75/0x8c
>>  [<c0220d76>] acpi_hw_register_write+0x11b/0x14b
>>  [<c0104713>] common_interrupt+0x23/0x28
>>  [<c0110000>] mc_sysdev_remove+0x2b/0x4b
>>  [<c0232ddf>] acpi_processor_idle+0x22f/0x398
>>  [<c0102344>] cpu_idle+0x43/0x71
>>  [<c03d29de>] start_kernel+0x250/0x255
>>  [<c03d2317>] unknown_bootoption+0x0/0x195
>>  =======================
> 
> Looks like acpi_hw_register_write() has locked up.  Or someone is
> continuously calling acpi_hw_register_write().
> 
> I assume that the mc_sysdev_remove() in there is just stack garbage.  To
> confirm this could you please set CONFIG_MICROCODE=n and retest?
> 
> Also, it would be interesting to test whether we have introduced this bug
> into 2.6.24-rc2 (or -rc3, if it's out).
> 

The softlockup detector was patched in 2.6.23.2; before that it was broken
for a few releases.

patch a115d5caca1a2905ba7a32b408a6042b20179aaa in mainline


