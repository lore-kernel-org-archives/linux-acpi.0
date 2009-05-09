From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Asus Eee 901Go ACPI errors on 2.6.30-rc4-git4
Date: Sat, 9 May 2009 09:13:18 +0100
Message-ID: <9b2b86520905090113v427c1de8n4d8479016701d30a@mail.gmail.com>
References: <87vdobq48p.fsf@fzidpc73.tu-graz.ac.at>
	 <9b2b86520905080646r85f30bcp6f50d7388d8289f5@mail.gmail.com>
	 <20090509025643.GA24335@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47331 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZEIINU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2009 04:13:20 -0400
In-Reply-To: <20090509025643.GA24335@ellpspace.math.ualberta.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Cc: Mario Lang <mlang@tugraz.at>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On 5/9/09, Michal Jaegermann <michal@ellpspace.math.ualberta.ca> wrote:
> On Fri, May 08, 2009 at 02:46:05PM +0100, Alan Jenkins wrote:
>> On 5/8/09, Mario Lang <mlang@tugraz.at> wrote:
>> >
>> > Booting 2.6.30-rc4-git4 on an Asus Eee 901Go I get the following in
>> > dmesg:
>> >
>> > [   27.005071] ACPI: EC: missing confirmations, switch off interrupt
>> > mode.
>> > [   27.548097] ACPI Exception (evregion-0422): AE_TIME, Returned by
>> > Handler
>> > for [EmbeddedControl] [20090320]
>> > [   27.548139] ACPI Error (psparse-0537): Method parse/execution failed
>> > [\_SB_.PCI0.SBRG.EC0_.BST1] (Node f7033d4c), AE_TIME
>> > [   27.548280] ACPI Error (psparse-0537): Method parse/execution failed
>> > [\_SB_.PCI0.CBST] (Node f70366f8), AE_TIME
>> > [   27.548393] ACPI Error (psparse-0537): Method parse/execution failed
>> > [\_SB_.PCI0.BAT0._BST] (Node f7034c48), AE_TIME
>> > [   27.548521] ACPI Exception (battery-0385): AE_TIME, Evaluating _BST
>> > [20090320]
>>
>> Odd.  Did this happen in 2.6.29?
>
> I have seen something similar with different kernels.  See for example
> https://bugzilla.redhat.com/show_bug.cgi?id=492699
> which reports that for kernel-2.6.27.19-170.2.35.fc10 and
> kernel-2.6.29-3.fc10 Fedora kernels and Asus Eeeps 1002HA.

Interesting.  Not the same model, but both are relatively new.  It
sounds as if they switched to the EC chip that Acer used for the
Aspire One :-).  There's a very similar bug for the Acer netbook:

<http://bugzilla.kernel.org/show_bug.cgi?id=12949>

There are several patches.  Alexey's patch was confirmed to help on
the Acer netbook.  I suggest you try the latest patch from Alexey,
which is attached at comment 20:

<http://bugzilla.kernel.org/show_bug.cgi?id=12949#c20>



> https://bugzilla.redhat.com/buglist.cgi?quicksearch=+Method+parse%2Fexecution+failed
>
> brings a list where it is possible to find something of that sort
> in different settings too.

I think that's a very general failure message, that ACPI failed to
execute some method.  I don't think there are any other EC (Embedded
Controller) failures on that list.

Thanks
Alan
