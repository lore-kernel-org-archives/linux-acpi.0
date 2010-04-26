From: Mike Travis <travis@sgi.com>
Subject: Re: ACPI acpi_processor_get_throttling_info taking excessive time?
Date: Mon, 26 Apr 2010 11:14:51 -0700
Message-ID: <4BD5D81B.4020600@sgi.com>
References: <4BD4F0A5.7050208@sgi.com> <1272248522.25088.67.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:49500 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752996Ab0DZSOy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Apr 2010 14:14:54 -0400
In-Reply-To: <1272248522.25088.67.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jack Steiner <steiner@sgi.com>, Hedi Berriche <hedi@sgi.com>, Robin Holt <holt@sgi.com>

Hi,

Thanks for the reply.  I've added a new BZ:

	https://bugzilla.kernel.org/show_bug.cgi?id=15856

and attached the console output I collected from:

ignore_loglevel acpi.debug_layer=0x2800001f acpi.debug_level=0x00000027

This took almost an hour to boot so adding all flags would not be
practical.

Thanks!
Mike

Zhang Rui wrote:
> Hi, Mike,
> 
> please attach the acpidump of this machine, together with full dmesg
> output after boot (you can use boot option log_buf_len=4M to save more
> boot logs).
> BTW: it would be great if you can file a new bug report about this at
> https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach all the info there.
> 
> thanks,
> rui
> 
> On Mon, 2010-04-26 at 09:47 +0800, Mike Travis wrote:
>> Hi,
>>
>> On our test machine that has 1664 processors, we've discovered that
>> the function acpi_processor_get_throttling_info takes 10 minutes.
>> It's estimated that with 4096 cpus, this will take over 25 minutes.
>>
>> It seems that the acpi_processor_get_throttling_info serially queries
>> each cpu with a "runon" function to extract the throttling states.
>>
>> My question is can this be optimized to use the previous processor's
>> throttling states?  Would there be any reason to expect any of the
>> processors to be different?
>>
>> Another thought, if each processor needs to be queried, can the
>> functions be run in parallel?
>>
>> Each time I broke into this delay, this was the call stack:
>>
>>     6.559522 (    0.000032)| Stack traceback for pid 16894
>>     6.559554 (    0.000032)| 0xffff8827fb4d8680    16894        1  1  358   R  0xffff8827fb4d8d10  modprobe
>>     6.559628 (    0.000074)|  ffff8827fb535ae0 0000000000000018 ffffffff81246665 ffff8ac700000004
>>     6.559694 (    0.000066)|  ffff8d21fc07d150 ffff8ac7fc2e8800 0000000000000000 ffff8ac7fc2e9550
>>     6.559771 (    0.000077)|  0000000000000000 ffff8827fb535cd8 ffffffff81235822 ffffffff8158ac76
>>     6.559837 (    0.000066)| Call Trace:
>>     6.559852 (    0.000015)| Inexact backtrace:
>>     6.559874 (    0.000022)|
>>     6.559879 (    0.000005)|  [<ffffffff81246665>] ? acpi_ns_delete_namespace_by_owner+0xb2/0xdb
>>     6.559944 (    0.000065)|  [<ffffffff81235822>] ? acpi_ds_terminate_control_method+0x74/0x102
>>     6.560008 (    0.000064)|  [<ffffffff8124a60f>] ? acpi_ps_parse_aml+0x246/0x3c9
>>     6.560061 (    0.000053)|  [<ffffffff81251e25>] ? acpi_ut_create_internal_object_dbg+0x18/0x79
>>     6.560129 (    0.000068)|  [<ffffffff8124be20>] ? acpi_ps_execute_method+0x229/0x331
>>     6.560194 (    0.000065)|  [<ffffffff81246851>] ? acpi_ns_evaluate+0x189/0x2bc
>>     6.560246 (    0.000052)|  [<ffffffff8124611c>] ? acpi_evaluate_object+0x15e/0x2a5
>>     6.560301 (    0.000055)|  [<ffffffff812513e8>] ? acpi_ut_update_ref_count+0x17f/0x1d6
>>     6.560386 (    0.000085)|  [<ffffffffa012e14c>] ? acpi_processor_get_throttling_info+0x202/0x6f9 [processor]
>>     6.560464 (    0.000078)|  [<ffffffffa0131c46>] ? acpi_processor_add+0x93a/0xa8c [processor]
>>     6.560528 (    0.000064)|  [<ffffffff8122b247>] ? acpi_device_probe+0x4e/0x179
>>     6.560580 (    0.000052)|  [<ffffffff8128cb28>] ? driver_probe_device+0xc8/0x2d0
>>     6.560633 (    0.000053)|  [<ffffffff8128cdc3>] ? __driver_attach+0x93/0xa0
>>     6.560682 (    0.000049)|  [<ffffffff8128cd30>] ? __driver_attach+0x0/0xa0
>>     6.560740 (    0.000058)|  [<ffffffff8128c158>] ? bus_for_each_dev+0x58/0x80
>>     6.560790 (    0.000050)|  [<ffffffff8128b945>] ? bus_add_driver+0x155/0x2b0
>>     6.560839 (    0.000049)|  [<ffffffffa00d0000>] ? acpi_processor_init+0x0/0x10e [processor]
>>     6.560902 (    0.000063)|  [<ffffffff8128d0d9>] ? driver_register+0x79/0x170
>>     6.560952 (    0.000050)|  [<ffffffffa00d0000>] ? acpi_processor_init+0x0/0x10e [processor]
>>     6.561015 (    0.000063)|  [<ffffffffa00d009a>] ? acpi_processor_init+0x9a/0x10e [processor]
>>     6.561079 (    0.000064)|  [<ffffffff81067325>] ? __blocking_notifier_call_chain+0x65/0x90
>>     6.561141 (    0.000062)|  [<ffffffff810001e5>] ? do_one_initcall+0x35/0x190
>>     6.561190 (    0.000049)|  [<ffffffff8107b514>] ? sys_init_module+0xe4/0x270
>>     6.561240 (    0.000050)|  [<ffffffff81002e7b>] ? system_call_fastpath+0x16/0x1b
>>
>> Thanks,
>> Mike
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
