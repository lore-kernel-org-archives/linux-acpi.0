From: Ismail Donmez <ismail@pardus.org.tr>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Wed, 11 Oct 2006 11:04:48 +0300
Message-ID: <200610111104.50563.ismail@pardus.org.tr>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <1160549944.3000.347.camel@laptopd505.fenrus.org> <20061011070412.GA6128@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:40110 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161016AbWJKIEl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 04:04:41 -0400
In-Reply-To: <20061011070412.GA6128@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Yu Luming <luming.yu@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net

11 Eki 2006 =C3=87ar 10:04 tarihinde, Matthew Garrett =C5=9Funlar=C4=B1=
 yazm=C4=B1=C5=9Ft=C4=B1:=20
> On Wed, Oct 11, 2006 at 08:59:04AM +0200, Arjan van de Ven wrote:
> > it'd also be nice if the linux-ready firmware developer kit had a t=
est
> > for this, so that we can offer 1) a way to test this to the bios gu=
ys
> > and 2) encourage adding/note the lack easily
>
> Sure. Reading /proc/acpi/video/*/*/info should tell you whether a dev=
ice
> is an LCD or not.=20

On my Sony Vaio with latest linux-2.6 git kernel it says its a CRT :

[~]> cat  /proc/acpi/video/*/*/info
device_id:    0x0100
type:         CRT
known by bios: no
device_id:    0x0320
type:         UNKNOWN
known by bios: no
device_id:    0x0410
type:         UNKNOWN
known by bios: no
device_id:    0x0240
type:         UNKNOWN
known by bios: no
device_id:    0x0100
type:         CRT
known by bios: no
device_id:    0x0111
type:         UNKNOWN
known by bios: no
device_id:    0x0118
type:         UNKNOWN
known by bios: no
device_id:    0x0200
type:         TVOUT
known by bios: no

So I don't think its reliable.

Regards,
ismail
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
