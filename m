From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bug 25042] New: RAM buffer I/O resource badly interacts with
 memory hot-add
Date: Tue, 4 Jan 2011 14:32:35 -0800
Message-ID: <AANLkTinJ9P_B_0p+Y4VsuN+SjiWz2ai9WrNJFHwk=Mm+@mail.gmail.com>
References: <bug-25042-27@https.bugzilla.kernel.org/> <20110104135148.112d89c5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110104135148.112d89c5.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, petr@vandrovec.name, akataria@vmware.com, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 4, 2011 at 1:51 PM, Andrew Morton <akpm@linux-foundation.org> w=
rote:
>> Linus's commit 45fbe3ee01b8e463b28c2751b5dcc0cbdc142d90 in May 2009 adde=
d code
>> to create 'RAM buffer' above top of RAM to ensure that I/O resources do =
not
>> start immediately after RAM, but sometime later. =A0Originally it was en=
forcing
>> 32MB alignment, now it enforces 64MB. =A0Which means that in VMs with me=
mory size
>> which is not multiple of 64MB there will be additional 'RAM buffer' reso=
urce
>> present:
>>
>> 100000000-1003fffff : System RAM
>> 100400000-103ffffff : RAM buffer

I'd suggest just working around it by hotplugging in 64MB chunks.

IOW, the old "it hurts when I do that - don't do that then" solution
to the problem. There is no reason why a VM should export some random
8MB-aligned region that I can see.

>> Another approach is resurrecting
>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-07/msg06501.html an=
d using
>> this range instead of all "unclaimed" ranges for placing I/O devices. =
=A0Then
>> "RAM buffer" would not be necessary at all.

Yeah, not going to happen. There's no point (see above), and it is
fundamentally wrong to even think that the firmware tables - ACPI or
otherwise - would be so perfect that you can just always trust them.
Every time somebody makes the mistake of thinking they can do that
(and it happens distressingly often), they are quickly shown to be
wrong, and there's some random hardware out there that simply doesn't
list the ranges it uses.

What could happen these days is to move the "gap" logic from the e820
table (and /proc/iomem) and into the "arch_remove_reservations()"
logic. See commit fcb119183c73bf0781009713f303e28b1fb13d3e. That might
make memory hotplug happier.

That said, I do repeat: why the hell do you keep digging that hole in
the first place. Do memory hotplug in 256MB chunks, naturally aligned,
and don't bother with any of this crazy crap.

                     Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
