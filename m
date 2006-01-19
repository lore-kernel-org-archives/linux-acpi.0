From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4] Hot Dock/Undock support
Date: Thu, 19 Jan 2006 10:23:00 -0500
Message-ID: <d120d5000601190723k3339f92eufc3bc1d0832f6058@mail.gmail.com>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
	 <20060118222348.GG1580@elf.ucw.cz> <1137629220.31839.56.camel@whizzy>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:16354 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161231AbWASPXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 10:23:01 -0500
Received: by wproxy.gmail.com with SMTP id i3so251864wra
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jan 2006 07:23:01 -0800 (PST)
In-Reply-To: <1137629220.31839.56.camel@whizzy>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

On 1/18/06, Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> On Wed, 2006-01-18 at 23:23 +0100, Pavel Machek wrote:
> <snip>
> > Device GDCK looks like dock to my untrained eye. Unfortunately its
> > type is IBM0079... ...
> >
> > Ahha, and ibm_acpi.c agrees with me.
> >
> > IBM_HANDLE(dock, root, "\\_SB.GDCK",    /* X30, X31, X40 */
> >
> >         Scope (\_SB)
> >         {
> >             Device (GDCK)
> >             {
> >                 Name (_HID, EisaId ("IBM0079"))
> >                 Name (_CID, 0x150CD041)
> >                 Method (_STA, 0, NotSerialized)
> >                 {
> > ...
> >                 Method (_DCK, 1, NotSerialized)
> >                 {
> >                     Store (0x00, Local0)
> >                     If (LEqual (GGID (), 0x03))
> >                     {
> >                         Store (\_SB.PCI0.LPC.EC.SDCK (Arg0), Local0)
> >                     }
> >
> >                     If (LEqual (GGID (), 0x00))
> >                     {
> >                         Store (\_SB.PCI0.PCI1.DOCK.DDCK (Arg0), Local0)
> >                     }
> >
> >                     Return (Local0)
> >                 }
> >
> >                 Method (_EJ0, 1, NotSerialized)
> >                 {
> >                     If (LEqual (GGID (), 0x03))
> >                     {
> >                         \_SB.PCI0.LPC.EC.SEJ0 (Arg0)
> >                     }
> >
> >                     If (LEqual (GGID (), 0x00))
> >                     {
> >                         \_SB.PCI0.PCI1.DOCK.DEJ0 (Arg0)
> >                     }
> >                 }
> > ....
> >
> > Hope this helps.
> >                                               Pavel
>
>
> so the problem that I see is that this dsdt defines two separate dock
> devices, one outside the scope of pci, and one within it.  The one
> outside the scope of pci defines the _EJ0 and _DCK methods.  So, when
> acpiphp loads, it scans the pci slots for ejectable slots, finds none
> (because _EJ0 is defined in the dock device that is outside the scope of
> pci) and exits.  This dsdt is different from the others I've used in
> that most of them define all methods related to docking under the actual
> dock bridge (within the scope of pci).  perhaps some acpi people can
> shed some light on the best way to handle this - otherwise I'm sure I
> can hack something up that will be less than acceptable :).
>

ACPI has (had?) a braindamage - it drops devices that do not present
when initially scanning ACPI namespace. So if you boot undocked - too
bad. Driver won't ever see your docking station.

--
Dmitry
