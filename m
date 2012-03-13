From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 23/37] PCI, ACPI: Add pci_root_hp hot add hotplug notification
Date: Mon, 12 Mar 2012 23:03:30 -0700
Message-ID: <CAE9FiQWvOpJ1N=QLQ3MHRqVGw7pz1Fuma60pJSwzqP5Jc5PF3Q@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
	<1331362837-10740-24-git-send-email-yinghai@kernel.org>
	<CAErSpo5cCC4HySedQ85BFKkPQ0VuYWX+NTjZLd4GpcATh1ix3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5cCC4HySedQ85BFKkPQ0VuYWX+NTjZLd4GpcATh1ix3g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 12, 2012 at 8:22 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>> It is from acpiphp_glue.c
>>
>> How to use it?
>> Find out root bus number to acpi root name mapping from dmesg or /sy=
s
>>
>> =A0echo "\_SB.PCIB 0" > /proc/acpi/sci/notify
>> to add it back
>
> Nope. =A0That might be a way to exercise this for debug purposes (and=
 it
> only works when /proc/acpi/sci/notify is compiled in), but we
> definitely don't want normal users to deal with ACPI pathnames like
> this.

before this patch set, only way is: Users really put one root bus in
and press buton etc to trigger notification
to get it work.

>
> Most of this functionality belongs in the ACPI core, not here. =A0The
> core should be handling these notify events and turning them into
> .add() and .remove() calls to the driver.
>
> But since the ACPI core doesn't do that yet, we have to do it in the
> driver, like we do for CPU, memory, etc. =A0That part is fine. =A0But=
 I
> think it at least belongs *in* the driver, i.e., in pci_root.c, not i=
n
> a new pci_root_hp.c file.

don't want to pollute pci_root.c.

in separated file, we can use CONFIG_HOTPLUG in Makefile instead of pci=
_root.c

>
> There definitely should not be another acpi_walk_namespace() and
> another list of ACPI host bridges. =A0The core *does* already walk th=
e
> namespace and call acpi_pci_root_add() for us. =A0And the driver alre=
ady
> has a list of host bridges (acpi_pci_roots).

no, we may not have acpi_pci_root there.
