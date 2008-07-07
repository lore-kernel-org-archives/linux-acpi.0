From: Andi Kleen <andi@firstfloor.org>
Subject: Re: ACPI git trees and vacation
Date: Mon, 07 Jul 2008 08:17:31 +0200
Message-ID: <4871B4FB.5020205@firstfloor.org>
References: <48711391.6090608@firstfloor.org> <20080707095659.a1b486e1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080707095659.a1b486e1.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Stephen Rothwell wrote:
> Hi Andi,
> 
> On Sun, 06 Jul 2008 20:48:49 +0200 Andi Kleen <andi@firstfloor.org> wrote:
>> The trees for the next ACPI merge are at git.kernel.org now
>> These are based on Len's branches with some additional patches.
>>
>> (based on Linus' tree aka 2.6.26rc9)
>> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git release
>> Intended for the 2.6.27 merge
> 
> If that is true ..
> 
>> git://git.kernel.org/pub/scm/git/linux/kernel/ak/linux-acpi-2.6.git test
> 
> Then why is linux-next tracking that?

It is tracking Len's tree not mine, right?

Right now my only has a few patches difference, but it will be growing.

Or did you switch already to mine?

> 
>> (based on Linux next for patches with dependencies)
>> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-next-acpi.git
> 
> Is there something we can do about those dependencies?

It's some patches from Henrique that require rfkill changes
in the net tree. I'm also not happy about that (it complicates
everything here), but cannot do much about it.

>> This is not quite yet the full state intended for the merge, a few
>> patches are still missing.
> 
> So what is missing, and why should we merge stuff in 2.6.27 that we don't
> see until the merge window?  (Not trying to be antagonistic, just asking
> about procedure and wondering why stuff for 2.6.27 is still not in
> linux-next.)

Because they're small fixes and would go in later anyways.

And because I haven't gone through all of them yet due to time
reasons, but I cannot say categorically I'll delay them all.

-Andi
