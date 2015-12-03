From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 1/3] dell-wmi: Use a C99-style array for bios_to_linux_keycode
Date: Thu, 3 Dec 2015 15:45:36 -0800
Message-ID: <CALCETrV5WJgzp3EewXdkN35ZQ95cVDu-XLznqD6muCwHQZS4qQ@mail.gmail.com>
References: <cover.1448931589.git.luto@kernel.org> <c30cf7923f0059d21ba3d8a63b7eb47fe7e475a4.1448931589.git.luto@kernel.org>
 <20151203233249.GB1800@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33912 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbLCXp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 18:45:56 -0500
Received: by igvg19 with SMTP id g19so24797785igv.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2015 15:45:56 -0800 (PST)
In-Reply-To: <20151203233249.GB1800@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>

On Thu, Dec 3, 2015 at 3:32 PM, Darren Hart <dvhart@infradead.org> wrot=
e:
> On Mon, Nov 30, 2015 at 05:01:59PM -0800, Andy Lutomirski wrote:
>> It's currently hard to follow what maps to what, and it's hard to ed=
it
>> the array.  Redo it as a C99-style array.
>>
>> I generated this using emacs regexes and a python one-liner.
>> objdump says this didn't change the table.
>>
>> Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> I already have this one in next and I don't see a per-patch changelog=
 for this
> one - has it changed?
>

No, it hasn't.  I didn't actually mean to include it in the series.
Whoops!  Please just pretend that I only sent patch 2 onward.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
