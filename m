From: Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Tue, 27 Nov 2007 12:50:07 -0500
Message-ID: <20071127125007.4e1eddff@bree.surriel.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
	<4743CC0B.9000508@linux.vnet.ibm.com>
	<20071120221839.faab108e.akpm@linux-foundation.org>
	<20071126143943.0a01665b@cuia.boston.redhat.com>
	<20071126123319.7483e57f.akpm@linux-foundation.org>
	<20071126204540.GA19874@elte.hu>
	<474B43E1.9080407@gmail.com>
	<20071126141713.3dcd492b.akpm@linux-foundation.org>
	<474B5349.2070500@gmail.com>
	<20071126152832.f6c808f3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758937AbXK0R76@vger.kernel.org>
In-Reply-To: <20071126152832.f6c808f3.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, mingo@elte.hu, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org, balbir@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, tglx@linutronix.de, clameter@sgi.com
List-Id: linux-acpi@vger.kernel.org

On Mon, 26 Nov 2007 15:28:32 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 27 Nov 2007 00:14:17 +0100
> Jiri Slaby <jirislaby@gmail.com> wrote:
>=20
> > On 11/26/2007 11:17 PM, Andrew Morton wrote:
> > >> Maybe if you can emit a broken-out with the fresh pull to test?
> > >=20
> > > http://userweb.kernel.org/~akpm/mmotm/ is current.  But it probab=
ly won't
> > > compile.=20
> >=20
> > Yes it did :). And it worked. Both in qemu and on my desktop...
>=20
> boggle.  Let's slap 2.6.25 on it and take the rest of the year off.

No worries, the mmotm compiling issue seems to have been fixed:

  CC [M]  drivers/scsi/libsas/sas_ata.o
drivers/scsi/libsas/sas_ata.c:39: error: field =E2=80=98rphy=E2=80=99 h=
as incomplete type
drivers/scsi/libsas/sas_ata.c: In function =E2=80=98sas_discover_sata=E2=
=80=99:
drivers/scsi/libsas/sas_ata.c:773: error: implicit declaration of funct=
ion =E2=80=98ata_sas_rphy_alloc=E2=80=99
drivers/scsi/libsas/sas_ata.c:775: error: dereferencing pointer to inco=
mplete type
drivers/scsi/libsas/sas_ata.c:775: warning: assignment makes pointer fr=
om integer without a cast
drivers/scsi/libsas/sas_ata.c:781: error: dereferencing pointer to inco=
mplete type
drivers/scsi/libsas/sas_ata.c:782: error: dereferencing pointer to inco=
mplete type
drivers/scsi/libsas/sas_ata.c:784: warning: type defaults to =E2=80=98i=
nt=E2=80=99 in declaration of =E2=80=98__mptr=E2=80=99
drivers/scsi/libsas/sas_ata.c:784: warning: initialization from incompa=
tible pointer type
drivers/scsi/libsas/sas_ata.c:791: error: implicit declaration of funct=
ion =E2=80=98ata_sas_rphy_add=E2=80=99
drivers/scsi/libsas/sas_ata.c:807: error: implicit declaration of funct=
ion =E2=80=98ata_sas_rphy_delete=E2=80=99
drivers/scsi/libsas/sas_ata.c:809: error: implicit declaration of funct=
ion =E2=80=98ata_sas_rphy_free=E2=80=99
make[3]: *** [drivers/scsi/libsas/sas_ata.o] Error 1
make[2]: *** [drivers/scsi/libsas] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

So much for continuing the bisect with that tree, to find the
cause of the second bug :)

Guess I'll extract an x86 tree changeset first, to place into
the 2.6.23-rc3-mm1 broken out tree and work from there...

--=20
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
