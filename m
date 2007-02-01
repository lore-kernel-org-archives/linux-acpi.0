From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.20-rc6-mm3
Date: Wed, 31 Jan 2007 23:10:32 -0500
Message-ID: <200701312310.32828.lenb@kernel.org>
References: <20070129204528.eb8d695e.akpm@osdl.org> <20070130142714.9f8dd5da.akpm@osdl.org> <45C08368.2020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55406 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161167AbXBAELy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2007 23:11:54 -0500
In-Reply-To: <45C08368.2020904@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 31 January 2007 06:54, Maciej Rutecki wrote:
> Andrew Morton napisa=C5=82(a):
>=20
> > OK, thanks.  That might be due to the time-management updates as we=
ll.=20
> > I'll see if I can reproduce this.
> >=20
> > If you're keen, you could test just 2.6.19-rc6+origin.patch+git-acp=
i.patch
> > from
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2=
0-rc6/2.6.20-rc6-mm3/broken-out
> > and see which of these problems remain.
> >=20
>=20
> I try 2.6.19-rc6 witch origin.patch and git-acpi.patch. This patch
> didn't add correctly (see patch_output.txt). Also I have compiling er=
ror:
>=20
> AS      arch/i386/kernel/entry.o
>   CC      arch/i386/kernel/traps.o
>   CC      arch/i386/kernel/irq.o
>   CC      arch/i386/kernel/ptrace.o
>   CC      arch/i386/kernel/time.o
>   CC      arch/i386/kernel/ioport.o
>   CC      arch/i386/kernel/ldt.o
>   CC      arch/i386/kernel/setup.o
> In file included from include/acpi/acpi.h:62,
>                  from include/linux/acpi.h:37,
>                  from arch/i386/kernel/setup.c:31:
> include/acpi/acpixf.h:100: warning: 'struct acpi_pointer' declared
> inside parameter list
> include/acpi/acpixf.h:100: warning: its scope is only this definition=
 or
> declaration, which is probably not what you want
> include/acpi/acpixf.h:115: error: expected ')' before 'table_type'
> make[2]: *** [arch/i386/kernel/setup.o] B=C5=82=C4=85d 1
> make[1]: *** [arch/i386/kernel] B=C5=82=C4=85d 2
> make[1]: Opuszczenie katalogu `/usr/src/linux-rc'
> make: *** [debian/stamp-build-kernel] B=C5=82=C4=85d 2
>=20
> "B=C5=82=C4=85d"=3D"Error" (in polish).

Note that you can always get the latest ACPI patch and drop it directly=
 onto Linus' tree here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.=
6.20/

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
