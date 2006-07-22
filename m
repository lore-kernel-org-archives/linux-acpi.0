From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI problem on dual-Xeon server (2.6.18-rc2)
Date: Fri, 21 Jul 2006 23:47:13 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601091282@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43158 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751279AbWGVDrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2006 23:47:23 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>, linux-acpi@vger.kernel.org

>This box didn't boot on 2.6.18-rc2.
>(The last kernel I tested which worked (at least until it broke for
>other reasons...) was 2.6.17-rc2.)

it would be great if you can confirm that
2.6.17.stable works properly.

Then enable CONFIG_ACPI_DEBUG=y on 2.6.17.stable
and you should see the "BIOS reported wrong ACPI id"
message like below.  That message was enabled by
commit 0eace for bugzilla 5452 at 2.6.17-git9.

The AE_NOT_EXIST part, I think, may be new.
Might need acpidump output in a bugzilla to
figure it out.

>BIOS reported wrong ACPI idfor the processor
>ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify 
>handler [20060707]
>BIOS reported wrong ACPI idfor the processor
>ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify 
>handler [20060707]
>BIOS reported wrong ACPI idfor the processor
>ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify 
>handler [20060707]
>BIOS reported wrong ACPI idfor the processor
>ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify 
>handler [20060707]

Unclear if the hang is actually related to ACPI.
Does the system boot properly with acpi=off?

thanks,
-Len

>
>[ hang ]
>SysRq : Show State
>
>                                               sibling
>  task             PC      pid father child younger older
>[...]
>udevplug      S 003954DF     0   429    424                     (NOTLB)
>       dfea5f38 5b12f0c8 00000017 003954df dff3caa0 f76e7540 
>5ca442e7 00000017 
>       00000002 dff3cbc4 b1fe7cc0 00000076 00000000 00000004 
>00000417 00000000 
>       80f8f2be 00000417 00000286 dfea5f68 00000001 00000001 
>dfea5f4c b026c835 
>Call Trace:
> [<b026c835>] do_nanosleep+0x3f/0x71
> [<b012be84>] hrtimer_nanosleep+0x3c/0xe9
> [<b012bf72>] sys_nanosleep+0x41/0x53
> [<b01029b3>] syscall_call+0x7/0xb
>
