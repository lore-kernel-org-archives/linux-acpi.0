From: Yu Luming <luming.yu@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Thu, 12 Oct 2006 00:31:13 +0800
Message-ID: <200610120031.13449.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061011070412.GA6128@srcf.ucam.org> <200610111104.50563.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161121AbWJKQb0@vger.kernel.org>
In-Reply-To: <200610111104.50563.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net
List-Id: linux-acpi@vger.kernel.org

On Wednesday 11 October 2006 16:04, Ismail Donmez wrote:
> 11 Eki 2006 =C3=87ar 10:04 tarihinde, Matthew Garrett =C5=9Funlar=C4=B1=
 yazm=C4=B1=C5=9Ft=C4=B1:
> > On Wed, Oct 11, 2006 at 08:59:04AM +0200, Arjan van de Ven wrote:
> > > it'd also be nice if the linux-ready firmware developer kit had a=
 test
> > > for this, so that we can offer 1) a way to test this to the bios =
guys
> > > and 2) encourage adding/note the lack easily
> >
> > Sure. Reading /proc/acpi/video/*/*/info should tell you whether a d=
evice
> > is an LCD or not.
>
> On my Sony Vaio with latest linux-2.6 git kernel it says its a CRT :
>
> [~]> cat  /proc/acpi/video/*/*/info
> device_id:    0x0100
> type:         CRT
> known by bios: no
> device_id:    0x0320
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0410
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0240
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0100
> type:         CRT
> known by bios: no
> device_id:    0x0111
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0118
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0200
> type:         TVOUT
> known by bios: no
>
> So I don't think its reliable.
Please open a bug on bugzilla.kernel.org,
and post acpidump output.=20

Thanks,
Luming
