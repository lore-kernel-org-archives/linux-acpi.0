From: Pasi Savolainen <psavo-X3B1VOXEql0@public.gmane.org>
Subject: Re: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 18:26:10 +0000 (UTC)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <bgrh82$3sp$1@main.gmane.org>
References: <200308060621.06216.d.nuetzel@wearabrain.de> <20030806100815.GH16091@fs.tum.de> <200308061849.01416.d.nuetzel@wearabrain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Dieter N=FCtzel <d.nuetzel-VZcQ4qwp+CzQLMG2gba6HQ@public.gmane.org>:
> Am Mittwoch, 6. August 2003 12:08 schrieb Adrian Bunk:
>> On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter N=FCtzel wrote:
>> > Hello,
>>
>> Hi Dieter,
>>
>> > I had it running very well on my dual Athlon MP 1900+ for several =
months
>> > before. Latest Kernel was 2.4.22-pre5+ACPI patch.
>> >
>> > Any changes?
>> > I changed lm_sensors from 2.7.0 (?) to 2.8.0
>=20
> This one is the culprit.
> Reverting to 2.7.0 cure my problems.

It's most probably because somebody (temp. monitoring) is already using
the south bridge, so just plain grabbing of it doesn't work. I faced
this with port to 2.6 and it's handled thus:


+       /* Find southbridge */
+       pdev_sb =3D NULL;
+       while((pdev_sb =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev=
_sb)) !=3D NULL) {
+               if(pci_match_device(amd_sb_tbl, pdev_sb) !=3D NULL)
+                       goto found_sb;
+       }
+       printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+       return -ENODEV;


It could work in 2.4 too.


--=20
   Psi -- <http://www.iki.fi/pasi.savolainen>
Vivake -- Virtuaalinen valokuvauskerho <http://members.lycos.co.uk/viva=
ke/>
