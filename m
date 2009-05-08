From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Asus Eee 901Go ACPI errors on 2.6.30-rc4-git4
Date: Fri, 8 May 2009 14:46:05 +0100
Message-ID: <9b2b86520905080646r85f30bcp6f50d7388d8289f5@mail.gmail.com>
References: <87vdobq48p.fsf@fzidpc73.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:42349 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZEHNqI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 09:46:08 -0400
In-Reply-To: <87vdobq48p.fsf@fzidpc73.tu-graz.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Lang <mlang@tugraz.at>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On 5/8/09, Mario Lang <mlang@tugraz.at> wrote:
> Hi.
>
> Booting 2.6.30-rc4-git4 on an Asus Eee 901Go I get the following in dmesg:
>
> [   27.005071] ACPI: EC: missing confirmations, switch off interrupt mode.
> [   27.548097] ACPI Exception (evregion-0422): AE_TIME, Returned by Handler
> for [EmbeddedControl] [20090320]
> [   27.548139] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC0_.BST1] (Node f7033d4c), AE_TIME
> [   27.548280] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.CBST] (Node f70366f8), AE_TIME
> [   27.548393] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.BAT0._BST] (Node f7034c48), AE_TIME
> [   27.548521] ACPI Exception (battery-0385): AE_TIME, Evaluating _BST
> [20090320]

Odd.  Did this happen in 2.6.29?

If so - I think there's only one significant EC change since 2.6.29,
you could try reverting that.

34ff4dbccccce54c83b1234d39b7ad9e548a75dd "ACPI: EC: Separate delays
for MSI hardware"

Alan
