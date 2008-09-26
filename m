From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Fri, 26 Sep 2008 06:37:08 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308587672B3@orsmsx503.amr.corp.intel.com>
References: <200809251119.48907.elendil@planet.nl>
 <1222400642.4023.187.camel@yakui_zhao.sh.intel.com>
 <200809260652.21929.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32892 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYIZNhP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 09:37:15 -0400
In-Reply-To: <200809260652.21929.elendil@planet.nl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>, "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Most of the problems seen in the SSDT are related to the fact that the disassembler cannot always correctly disassemble code that contains calls to control methods that are external to the table. There is not enough information to disassemble correctly, and the table often needs to be repaired by hand.



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Frans Pop
>Sent: Thursday, September 25, 2008 9:52 PM
>To: Zhao, Yakui
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: Syntax errors in SSDT1 table of HP 2510p laptop
>
>On Friday 26 September 2008, Zhao Yakui wrote:
>> Will you please try the latest kernel (2.6.27-rc6) and see whether the
>> problem still exists?
>
>Sorry that I did not make that clear, but I am already running with
>current git (v2.6.27-rc7-94-gc0f4d6d).
>
>>    It seems that the problem is fixed by the following commit:
>>    commit 48feb3c419508487becfb9ea3afcc54c3eac6d80
>
>The kernel errors listed in that commit log are rather different from what
>I'm seeing.
>
>Also, how could a commit in the kernel fix a broken ACPI table? No change
>in the kernel can repair syntax errors that show up when you disassemble
>and recompile the ACPI table itself, can it?
>I thought using iasl as I did was the accepted way to uncover errors in a
>system's ACPI tables.
>
>I really think the problem is in the ACPI table in this case, not in the
>kernel.
>
>Cheers,
>FJP
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
