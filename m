From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Tue, 1 May 2007 17:38:13 +0400
Message-ID: <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>
References: <46370B26.2080704@gmx.de>
	 <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>
	 <46371966.2020300@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:37032 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423466AbXEANiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2007 09:38:14 -0400
Received: by an-out-0708.google.com with SMTP id b33so1600543ana
        for <linux-acpi@vger.kernel.org>; Tue, 01 May 2007 06:38:13 -0700 (PDT)
In-Reply-To: <46371966.2020300@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

Please remove error lines at the beginning of the file and try to
compile it again...

On 5/1/07, Markus Feldmann <feldmann_markus@gmx.de> wrote:
> Alexey Starikovskiy schrieb:
> > 1. why do you think that making custom DSDT is going to help you?
> > 2. please attach your dsdt.dsl, so we could see on what iasl barks...
> >> From your report it looks like you trying to fed it with some non-aml
> > code.
> >
> > Regards,
> > Alex.
> >
> Sorry forgot the dsdt.dsl.
> Here it comes.
>
> bye Markus
>
>
