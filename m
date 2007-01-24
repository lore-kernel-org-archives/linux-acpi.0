From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Wed, 24 Jan 2007 22:54:15 +0800
Message-ID: <3877989d0701240654p4421b8f0ob9462de2e3e40607@mail.gmail.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <414cba4e0701190641x4e5c5747j3edf4ead90d805a2@mail.gmail.com>
	 <3877989d0701232019g45af8feaxabdcf6ba77170a5d@mail.gmail.com>
	 <200701232138.54758.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:8495 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbXAXOyQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jan 2007 09:54:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so215699wxd
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jan 2007 06:54:16 -0800 (PST)
In-Reply-To: <200701232138.54758.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org, trenn@novell.com

>From the thread, I see  Emilio Scalise has resolved the problem by
hacking DSDT. So it would be helpful to verify. (Please check this
thread http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg02785.html)
I don't have this laptop, so I don't know if it really work. But, I
will check how it was resovled. Probably, we can find out the root
cause. But I'm still confused by the fact that Windows just works.

http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg02785.html
On 1/24/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Tuesday 23 January 2007 21:19, Luming Yu wrote:
> > On 1/19/07, emisca <emisca.ml@gmail.com> wrote:
> > > The TZ4 thermal zone on all the hp compaq line nx**** and nc**** is
> > > not a temperature but the fan speed. You can see this information on
> > > the web and on hp forums.
> >
> > Where is the hp forums.
>
> I don't work on laptops, so I can't confirm this, but Google found
> this (from "tz4 thermal zone fan speed hp"):
>
> http://forums1.itrc.hp.com/service/forums/bizsupport/questionanswer.do?threadId=1052925
>
