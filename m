From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Fri, 6 Jun 2008 23:55:26 -0700
Message-ID: <20080606235526.783acc83.akpm@linux-foundation.org>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45101 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753939AbYFGG4S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 02:56:18 -0400
In-Reply-To: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, 7 Jun 2008 06:21:54 +0000 "Justin Mattock" <justinmattock@gmail.com> wrote:

> Well; I was hoping it was going to be just an easy fix, but unfortunately
> changing
>  if (atomic_read(&ec->irq_count) > 5) {
>  to
> if (atomic_read(&ec->irq_count) > 20) {
> does seem to make the message disappear, for a while, probably at
> around three hours,(for me at least) then the message appeared again.
> :-(
> So leaving me back to the beginning of try to have a go at this.
> regards;

I removed bugzilla from cc - that only works if there's [Bug 1234] in
the Subject:.

I added linux-acpi to cc - this is an acpi problem.

What Justin is mysteriously referring to here is:


: From: "Justin Mattock" <justinmattock@gmail.com>
: To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
: Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
: Subject: GPE storm detected, disabling EC GPE
: Date: 	Thu, 5 Jun 2008 21:01:55 +0000
: Sender: linux-kernel-owner@vger.kernel.org
: 
: FWIW I noticed a post where the person had changed 5 to 20, and it
: seemed to work for them;
: So with that in mind I decide to give that a go, here is the location:
: drivers/acpi/ec.c
: @@ -527,47 +488,51 @@ static u32 acpi_ec_gpe_handler(void *data)
:  {
:         acpi_status status = AE_OK;
:         struct acpi_ec *ec = data;
:        u8 state = acpi_ec_read_status(ec);
: 
:         pr_debug(PREFIX "~~~> interrupt\n");
:        atomic_inc(&ec->irq_count);
: -       if (atomic_read(&ec->irq_count) > 5) {
: +       if (atomic_read(&ec->irq_count) > 20) {
:                pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
:                ec_switch_to_poll_mode(ec);
:                goto end;
:        }
: 
: Now I don't know if this will work for other brands, but for
: me(Macbook Pro ATI chipset) I have not received the
: GPE storm detected, disabling EC GPE message, but it's only been an
: hour, maybe after two or three this might appear.
: Also is this good or bad to set 5 to 20 for the system?

Could someone from acpi land please help here?

Justin, has this machine always had this problem or is it something
which earlier kernels handled correctly?

Thanks.
