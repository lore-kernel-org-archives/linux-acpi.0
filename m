From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 onASUS2400 NE
Date: Tue, 28 Dec 2004 12:01:04 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8406A730C0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262060AbUL1EBh@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Pavel Machek <pavel@ucw.cz>, "Li, Shaohua" <shaohua.li@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net, "Fu, Michael" <michael.fu@intel.com>
List-Id: linux-acpi@vger.kernel.org

the idea in post
http://sourceforge.net/mailarchive/message.php?msg_id=3D9091508
cure S1 resume hang for my ASUS2400NE.

I guess Len will accept it.

Does it imply IDE DMA  could be started too early in the original resum=
e code?

Thanks,
Luming

-----Original Message-----
=46rom: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
Sent: 2004=C4=EA12=D4=C227=C8=D5 21:45
To: Yu, Luming
Cc: Arjan van de Ven; Pavel Machek; Brown, Len; Li, Shaohua; Pallipadi,=
 Venkatesh; Linux Kernel Mailing List; acpi-devel@lists.sourceforge.net=
; Fu, Michael
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 o=
nASUS2400 NE

On Llu, 2004-12-27 at 10:14, Yu, Luming wrote:
>  Actually, the kernel (after removing restore-pci-config-space-on-res=
ume patch) with option "ide=3Dnodma"=20
> can work with S1 suspend/resume without any hang so far.
>   So my suggestion for IDE driver is to disable DMA before entering S=
1, and enable
> DMA after resuming from S1 if DMA was enabled.  I need help from IDE =
guys to confirm it.

The IDE layer has no problem doing this, although it raises interesting
questions about why it would be neccessary.=20
