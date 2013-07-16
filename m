From: Parag Warudkar <parag.lkml@gmail.com>
Subject: Re: BGRT Pointer in System RAM
Date: Mon, 15 Jul 2013 20:00:39 -0400
Message-ID: <CAOULuOYySYf=Qv973Wx+DZMYKok8uu=Nosw7-3ajNvcrNEspPA@mail.gmail.com>
References: <CAOULuOY5VMiiuYmesaGxVWWKtby4Cj9Pc9ctQZeOKfoUzV46dA@mail.gmail.com>
	<CALCETrVk=ovYjHwALtzB3E3nP4TMivhppM42yw7rMRpzA68cbw@mail.gmail.com>
	<20130715230418.GA2649@leaf>
	<CAOULuOY=F5H_=Q1BcbrBxTAj9_9tXvOnm+KAtAksfDw2ei3hVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44716 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab3GPAAl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2013 20:00:41 -0400
In-Reply-To: <CAOULuOY=F5H_=Q1BcbrBxTAj9_9tXvOnm+KAtAksfDw2ei3hVw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, Jul 15, 2013 at 7:56 PM, Parag Warudkar <parag.lkml@gmail.com> wrote:
> On Mon, Jul 15, 2013 at 7:04 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>
>> We do need to handle the case of a valid pointer into memory that e820
>> calls system RAM, as well as the case of a valid pointer into memory
>> reserved for the BIOS or similar, but not the case of an invalid
>> pointer.
>
> Would that be as simple as
>
>                      page_is_ram(

Damn shortcuts -
                        virt_addr = phys_to_virt(image->base_address);
                        if(page_is_ram(virt_to_page(virt_addr))) {
                            //direct read from virt addr
                        }

Would that suffice for the System RAM case or some other MM trickery
is involved?

Thanks,
Parag
