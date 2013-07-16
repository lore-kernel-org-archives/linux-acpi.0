From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] BGRT: Don't ioremap if image address is in System RAM
 (was: Re: BGRT Pointer in System RAM)
Date: Tue, 16 Jul 2013 15:55:36 -0700
Message-ID: <CALCETrUs9Udhv7KqL+Dy8UNnHd6Amyb1mYjkC8zniF=F-RNZgw@mail.gmail.com>
References: <CAOULuOb3-gA36S=xhA_pwLT0vf9Bb973d3Qq40KfsnS15R_qWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOULuOb3-gA36S=xhA_pwLT0vf9Bb973d3Qq40KfsnS15R_qWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 16, 2013 at 3:15 PM, Parag Warudkar <parag.lkml@gmail.com> wrote:
> On Mon, Jul 15, 2013 at 8:00 PM, Parag Warudkar <parag.lkml@gmail.com> wrote:
>> On Mon, Jul 15, 2013 at 7:56 PM, Parag Warudkar <parag.lkml@gmail.com> wrote:
>>> On Mon, Jul 15, 2013 at 7:04 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>>>
>>>> We do need to handle the case of a valid pointer into memory that e820
>>>> calls system RAM, as well as the case of a valid pointer into memory
>>>> reserved for the BIOS or similar, but not the case of an invalid
>>>> pointer.
>>>
>>> Would that be as simple as
>>>
>>>                      page_is_ram(
>>
>> Damn shortcuts -
>>                         virt_addr = phys_to_virt(image->base_address);
>>                         if(page_is_ram(virt_to_page(virt_addr))) {
>>                             //direct read from virt addr
>>                         }
>>
>> Would that suffice for the System RAM case or some other MM trickery
>> is involved?
>
> Ok, so I played around with it a bit and the following patch works
> fine on my system. (I.E. image size is reasonable, cat
> /sys/firmware/acpi/bgrt/image > img.bmp generates a valid,
> non-distorted bitmap, which it did before too, btw as despite of the
> ioremap WARN_ON the ioremap seems to succeed if !(is_ram &&
> pfn_valid(pfn) && !PageReserved.)
>

How reliable is this?  That is, is there any guarantee that nothing
will have overwritten the image in memory before this code runs?

--Andy
