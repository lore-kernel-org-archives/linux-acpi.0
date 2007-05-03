From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Thu, 3 May 2007 20:12:37 +0400
Message-ID: <8f8ff01d0705030912p1694820by1b61a85604d62916@mail.gmail.com>
References: <46370B26.2080704@gmx.de>
	 <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>
	 <46371966.2020300@gmx.de>
	 <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>
	 <463982CA.1060806@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:38751 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162157AbXECQMi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 12:12:38 -0400
Received: by an-out-0708.google.com with SMTP id b33so545479ana
        for <linux-acpi@vger.kernel.org>; Thu, 03 May 2007 09:12:37 -0700 (PDT)
In-Reply-To: <463982CA.1060806@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

I already received your dsdt.dsl to my mailbox. I answered as well,
but your provider seem to block whole gmail.com domain.
Lets try to go without attachements:
First error -- move Stall() function out of Return().
Second error -- you have wrong length for optional _PSD object, so
iasl puts everything after first item as garbage. just delete whole
Name(_PSD {} from both places, it will ok.

Regards,
Alex.


On 5/3/07, Markus Feldmann <feldmann_markus@gmx.de> wrote:
> Alexey Starikovskiy schrieb:
> > Please remove error lines at the beginning of the file and try to
> > compile it again...
> >
> > On 5/1/07, Markus Feldmann <feldmann_markus@gmx.de> wrote:
> >> Alexey Starikovskiy schrieb:
> >> > 1. why do you think that making custom DSDT is going to help you?
> >> > 2. please attach your dsdt.dsl, so we could see on what iasl barks...
> >> >> From your report it looks like you trying to fed it with some non-aml
> >> > code.
> >> >
> >> > Regards,
> >> > Alex.
> >> >
> >> Sorry forgot the dsdt.dsl.
> >> Here it comes.
> >>
> >> bye Markus
> >>
> >>
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> Where can i upload my dsdt.dsl file ?
> Because my Emails which i did send are not arrived in this Newsgroup.
> I think its not allowed to send emails to this Newsgroup with Attachment.
>
> bye Markus
>
