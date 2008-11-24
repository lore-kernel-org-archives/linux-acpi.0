From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: battery: current a factor of 10 off? [fix confirmed]
Date: Mon, 24 Nov 2008 02:43:06 +0100
Message-ID: <878wr9j3v9.fsf_-_@szonett.ki.iif.hu>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>
	<8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
	<4926C87D.20308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:59485 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbYKXBp1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Nov 2008 20:45:27 -0500
In-Reply-To: <4926C87D.20308@gmail.com> (Alexey Starikovskiy's message of
	"Fri, 21 Nov 2008 22:41:01 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy <aystarik@gmail.com> writes:

> Alexey Starikovskiy wrote:
>
>> On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
>>
>>> on my ThinkPad R50e the current_now reading seems something like 10
>>> times the actual value.  [...]
>>
>> Good catch.  ACPI battery interface report its state either in mW
>> or in mA, and discharge rate in your case is reported in
>> mW. power_supply interface does not have such a parameter, so
>> current_now parameter is used for all cases. But in case of mW,
>> reported discharge should be converted into mA.
>>
>> Please test the attached patch.
>
> This patch should be better -- no integer overflow.

Hi Alex,

Thanks, this patch really fixes the issue (tried on 2.6.28-rc6).
Hope to see it soon in Linus' tree!

Btw. that kernel gives me two ACPI warnings on boot:

  ACPI: RSDP 000F6E40, 0024 (r2 IBM   )
  ACPI: XSDT 1F6EF33D, 004C (r1 IBM    TP-1W        2060  LTP        0)
  ACPI: FACP 1F6EF400, 00F4 (r3 IBM    TP-1W        2060 IBM         1)
  ACPI Warning (tbfadt-0460): Optional field "Gpe1Block" has zero address or length: 000000000000102C/0 [20080926]
  ACPI: DSDT 1F6EF5E7, 7865 (r1 IBM    TP-1W        2060 MSFT  100000E)
  ACPI: FACS 1F6F8000, 0040
  ACPI: SSDT 1F6EF5B4, 0033 (r1 IBM    TP-1W        2060 MSFT  100000E)
  ACPI: ECDT 1F6F6E4C, 0052 (r1 IBM    TP-1W        2060 IBM         1)
  ACPI: TCPA 1F6F6E9E, 0032 (r1 IBM    TP-1W        2060 PTL         1)
  ACPI: BOOT 1F6F6FD8, 0028 (r1 IBM    TP-1W        2060  LTP        1)
  [...]
  ACPI Warning (nspredef-0858): \_SB_.PCI0.LPC_.EC__.BAT0._BIF: Return Package type mismatch at index 9 - found Buffer, expected String [20080926]
  ACPI: Battery Slot [BAT0] (battery present)

I'm willing to provide further info if anybody here is interested.
-- 
Cheers,
Feri.
