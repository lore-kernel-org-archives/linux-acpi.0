From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH 11/11] x86, olpc: Add XO-1.5 SCI driver
Date: Tue, 24 May 2011 22:52:07 +0100
Message-ID: <BANLkTinnL2KLGQXcA_St3QLggpoiBw_pgg@mail.gmail.com>
References: <1304166750-31125-1-git-send-email-dsd@laptop.org>
	<1304166750-31125-12-git-send-email-dsd@laptop.org>
	<20110516092429.GC26487@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55339 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab1EXVwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 May 2011 17:52:08 -0400
In-Reply-To: <20110516092429.GC26487@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-acpi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dilinger@queued.net

On 16 May 2011 10:24, Sebastian Andrzej Siewior <bigeasy@linutronix.de>=
 wrote:
> * Daniel Drake | 2011-04-30 13:32:30 [+0100]:
>
>>+static DECLARE_WORK(sci_work, process_sci_queue_work);
>>+
>>+static u32 xo15_sci_gpe_handler(acpi_handle gpe_device, u32 gpe, voi=
d *context)
>>+{
>>+ =A0 =A0 =A0schedule_work(&sci_work);
>>+ =A0 =A0 =A0return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
>>+}
>
> I know this is too much to ask but acpi_install_gpe_handler() looks l=
ike
> a custom irq demultiplexor which lacks the support for threaded irqs.

Thanks for looking at the patch.

I guess you mean that ACPI should hide all this behind an irq_chip
abstraction. I had a quick look at doing this but not being very
familiar with ACPI nor irq_chip I don't think I'm the right person for
the task. Hopefully it is not seen as a merge requirement...

CCing ACPI list for comments.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
