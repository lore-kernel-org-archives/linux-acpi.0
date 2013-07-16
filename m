From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: BGRT Pointer in System RAM
Date: Tue, 16 Jul 2013 14:15:22 -0700
Message-ID: <CALCETrWkja4k7AO1CFx=ev21Fg_6HO_unXbh=zGGdfPNRvLfcA@mail.gmail.com>
References: <CAOULuOY5VMiiuYmesaGxVWWKtby4Cj9Pc9ctQZeOKfoUzV46dA@mail.gmail.com>
 <CALCETrVk=ovYjHwALtzB3E3nP4TMivhppM42yw7rMRpzA68cbw@mail.gmail.com>
 <20130715230418.GA2649@leaf> <CALCETrX_Qjmdo5JtRPzhW6kBaNgwAstG1g8p8pKNy4e+kPYdMQ@mail.gmail.com>
 <20130715232053.GB2649@leaf> <CALCETrUMrztJ1aTfvfMZyOSRFhDM52Fa3pSS8EuW3ByYGMNMpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrUMrztJ1aTfvfMZyOSRFhDM52Fa3pSS8EuW3ByYGMNMpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Parag Warudkar <parag.lkml@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 15, 2013 at 4:24 PM, Andy Lutomirski <luto@amacapital.net> =
wrote:
> On Mon, Jul 15, 2013 at 4:20 PM, Josh Triplett <josh@joshtriplett.org=
> wrote:
>> On Mon, Jul 15, 2013 at 04:08:13PM -0700, Andy Lutomirski wrote:
>>> On Mon, Jul 15, 2013 at 4:04 PM, Josh Triplett <josh@joshtriplett.o=
rg> wrote:
>>> > On Mon, Jul 15, 2013 at 01:28:36PM -0700, Andy Lutomirski wrote:
>>> >>
>>> >> Interesting.  My BGRT says:
>>> >>
>>> >> [028h 0040   8]                Image Address : 0D06801800000001
>>> >>
>>> >> If I reverse the high and low 32-bit dwords, then I get an addre=
ss in
>>> >> system RAM.
>>> >
>>> > Does that address in RAM start with a BMP header?
>>>
>>> No idea.  I'd presumably have to modify the driver to find out --
>>> otherwise something else will overwrite it.
>>
>> You could boot with a mem=3D command-line argument that reserves tha=
t
>> memory.
>
> I'll see what I can do.
>

I booted with mem=3D3G, and:

$ sudo dd bs=3D1 skip=3D4513853464 if=3D/dev/mem count=3D1
dd: reading =91/dev/mem=92: Bad address

The kernel log says nothing, which suggests that ioremap_cache is
failing.  I don't know why.

The address 4513853464 is 0x10D0BF018, which should be okay:

[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000045fffffff] u=
sable
[    0.000000] e820: remove [mem 0xc0000000-0xfffffffffffffffe] usable

EFI agrees:
[    0.000000] efi: mem213: type=3D7, attr=3D0xf,
range=3D[0x0000000100000000-0x0000000460000000) (13824MB)

This could be related to the fact that mtrr cleanup is failing,
possibly due to bugs related to mem=3D.

That's about my tolerance for debugging something that doesn't really
deserve to work.

--Andy
