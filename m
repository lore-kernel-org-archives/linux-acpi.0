From: "Andrew Lutomirski" <luto@myrealbox.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Wed, 16 Jul 2008 10:13:54 -0400
Message-ID: <cb0375e10807160713r5aa2bb82md1e0b3b349ca8115@mail.gmail.com>
References: <200807010148.02135.rjw@sisk.pl> <487A2431.2050103@myrealbox.com>
	 <487A4CB7.1080001@firstfloor.org> <200807132115.08230.rjw@sisk.pl>
	 <487A617B.80707@firstfloor.org> <487A67C3.50000@zytor.com>
	 <487AD37A.2050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:46772 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbYGPON4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 10:13:56 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1823022nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2008 07:13:54 -0700 (PDT)
In-Reply-To: <487AD37A.2050903@zytor.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Ingo Molnar <mingo@elte.hu>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Sorry for the delay in testing.  This appears to work and fix the problem.

--Andy

On Mon, Jul 14, 2008 at 12:18 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> H. Peter Anvin wrote:
>>
>> The most likely explanation for this is that the VESA BIOS expects to be
>> entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real
>> Mode.  Here is a completely untested patch which changes the segment
>> descriptors to Big Real Mode instead.  It would be worth testing out.
>>
>
> ... and here is one that actually has a prayer of actually working.
>
>        -hpa
>
>
> --- AV & Spam Filtering by M+Guardian - Risk Free Email (TM) ---
>
