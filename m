From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Sat, 7 Jun 2008 15:47:57 +0000
Message-ID: <dd18b0c30806070847t63b8dbc0x8bfcbafc359f7031@mail.gmail.com>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
	 <20080606235526.783acc83.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:17086 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406AbYFGPsA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 11:48:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so367981and.103
        for <linux-acpi@vger.kernel.org>; Sat, 07 Jun 2008 08:47:57 -0700 (PDT)
In-Reply-To: <20080606235526.783acc83.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, Jun 7, 2008 at 6:55 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 7 Jun 2008 06:21:54 +0000 "Justin Mattock" <justinmattock@gmail.com> wrote:
>
>> Well; I was hoping it was going to be just an easy fix, but unfortunately
>> changing
>>  if (atomic_read(&ec->irq_count) > 5) {
>>  to
>> if (atomic_read(&ec->irq_count) > 20) {
>> does seem to make the message disappear, for a while, probably at
>> around three hours,(for me at least) then the message appeared again.
>> :-(
>> So leaving me back to the beginning of try to have a go at this.
>> regards;
>
> I removed bugzilla from cc - that only works if there's [Bug 1234] in
> the Subject:.
>
> I added linux-acpi to cc - this is an acpi problem.
>
> What Justin is mysteriously referring to here is:
>
>
> : From: "Justin Mattock" <justinmattock@gmail.com>
> : To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> : Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> : Subject: GPE storm detected, disabling EC GPE
> : Date:         Thu, 5 Jun 2008 21:01:55 +0000
> : Sender: linux-kernel-owner@vger.kernel.org
> :
> : FWIW I noticed a post where the person had changed 5 to 20, and it
> : seemed to work for them;
> : So with that in mind I decide to give that a go, here is the location:
> : drivers/acpi/ec.c
> : @@ -527,47 +488,51 @@ static u32 acpi_ec_gpe_handler(void *data)
> :  {
> :         acpi_status status = AE_OK;
> :         struct acpi_ec *ec = data;
> :        u8 state = acpi_ec_read_status(ec);
> :
> :         pr_debug(PREFIX "~~~> interrupt\n");
> :        atomic_inc(&ec->irq_count);
> : -       if (atomic_read(&ec->irq_count) > 5) {
> : +       if (atomic_read(&ec->irq_count) > 20) {
> :                pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
> :                ec_switch_to_poll_mode(ec);
> :                goto end;
> :        }
> :
> : Now I don't know if this will work for other brands, but for
> : me(Macbook Pro ATI chipset) I have not received the
> : GPE storm detected, disabling EC GPE message, but it's only been an
> : hour, maybe after two or three this might appear.
> : Also is this good or bad to set 5 to 20 for the system?
>
> Could someone from acpi land please help here?
>
> Justin, has this machine always had this problem or is it something
> which earlier kernels handled correctly?
>
> Thanks.
>

This issue just recently started, 2.6.25-rc9 and below don't give me
this message.

-- 
Justin P. Mattock
