From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 16:35:43 -0700
Message-ID: <AANLkTi=pJFUWusDNrwQA8bWYy4q5QZBHxkbikZGKvHLY__27812.3725126081$1288049775$gmane$org@mail.gmail.com>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
	<1287992610-14996-10-git-send-email-ying.huang@intel.com>
	<20101025084553.GA27119@elte.hu>
	<1287997112.2862.322.camel@yhuang-dev>
	<20101025092557.GA11544@elte.hu>
	<AANLkTi=2SVT1M+nDZUB7EB05jh+tsuKcew_t66QORrwb@mail.gmail.com>
	<20101025202344.GC13652@liondog.tnic>
	<AANLkTi=DEmss+3uX_5uw=VJDY9+cFPayjQkCQHa+r+Ye@mail.gmail.com>
	<20101025215132.GA23427@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37756 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757108Ab0JYXfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 19:35:43 -0400
In-Reply-To: <20101025215132.GA23427@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@gmail.com>, Ingo Molnar <mingo@elte.hu>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel

On Mon, Oct 25, 2010 at 2:51 PM, Borislav Petkov <bp@alien8.de> wrote:
> Concerning fatal errors, take a look at drivers/edac/mce_amd.(c|h)=B9=
 -
> this is not in arch/x86/ and still decodes MCEs in the kernel. And it
> works fine - it even helped in several cases where people simply read
> their serial console/dmesg and didn't have to collect it first and ru=
n
> it through some tool to understand which functional unit in the CPU i=
s
> mchecking.

That looks neat ... but end-users seem to have some conflicting require=
ments
here. Your uses seem to like it but the LLNL folks at the S.F. meeting =
said
that solutions that involved looking at console logs from thousands
of machines in a cluster were not acceptable.

I doubt very much if any end-user cares which unit *within* a cpu
failed (their replaceable unit is the whole of the cpu). So much of
your driver could be replaced with: printk("CPU%d is bad\n", cpu);

-Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
