From: Emmanuel =?iso-8859-1?B?VGhvbcOp?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Tue, 2 Nov 2004 23:00:34 +0100
Message-ID: <20041102220034.GA31435@tate.loria.fr>
References: <20041018020816.48673359@localhost.localdomain> <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz> <20041101145410.GB12006@tate.loria.fr> <20041101154127.GB1056@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041101154127.GB1056-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Mon, Nov 01, 2004 at 04:41:28PM +0100, Pavel Machek wrote:
> Patch looks good to me...

Great. Here's an updated version.

> Uff, this looks pretty ugly. But I guess it is i386 being ugly...

The present version does the indirection once and for all, it's more
readable. I've documented a bit the segment descriptor stuff, so that
it's not so mystifying. I can do most of it in C, using asm/processor.h
and asm/desc.h if you prefer.

Ole, while digging up what happens with your real mode / pmode switch, I
discovered that it turns out you're _not_ initializing the segment
descriptor for the data segment. It does not matter too much,  since the
wakeup code (once in real mode) hooks ds to the same place as cs anyway,
and sets up the stack accordingly, but is there a reason for doing so ?
I've initialized the descriptor, to make things more clear.

In fact, I hoped that this was a key explaining vgabios crashes: the es
segment point into nowhere (the wakeup code does not touch it), but maybe
the ROM code uses it (who knows). Unfortunately, movw %ax, %es does not
improve things.

I would say, still, that adding movw %ax, %es on top of wakeup_start
would make sense, perhaps some machine where s3_{,late_}{bios,mode}
almost work would benefit from it. Do you agree ?

> > +	if (((pci_dev->class ^ (PCI_CLASS_DISPLAY_VGA << 8)) & 0xffff00)==0)
> The use of xor here is certainly interesting. Is it possible to say
> 	pci_dev->class & 0xffff00 == PCI_CLASS_DISPLAY_VGA << 8

;-) This one got me laughing as well. I do prefer the (a & b) == c idiom
(now used), but I was amused by this xor in pci_match_one_device.

> > [ sleep_hacks.h ]
> Does it really deserve its own header file? Hmm and it should probably
> be common between x86-64 and i386, as we might need 64-bit version in
> future...

Well, the problem is that this stuff has to be included from the .S file
as well.

I've moved it into asm/acpi.h instead, which was the place where I
intended to put it at first. This implies protecting most of asm/acpi.h
with #ifndef __ASSEMBLY__ , but this makes sense for asm/ includes,
doesn't it ? Do you prefer this location ?

Attached are three files.

s3_late_bios.patch.gz is the current, working patch for i386.

s3_late_bios_radeon.patch.gz puts an acpi_vgapost call into the radeonfb
driver, just to illustrate how it can be inserted into custom pci resume
functions (oh, this will change in 2.6.10 with the removal of
pci_restore_state's second arg...).

s3_late_bios-x86_64-draft.patch.gz is untested. It lays the ground for
doing the same for x86_64 , but currently I don't have access to amd64
boxes where I can play with acpi (you wouldn't play such games on a
department level server, would you ?).


I've read on this ml that this stuff crashes S4 resume, understandably.
So now, calls to acpi_vgapost are protected by (pci_dev->dev.power_state
!= 4) checks, as seen elsewhere. Is .power_state==4 effectively used for
marking S4 sleep ?

Hoping this version is OK for you,

E.

--ibTvN161/egqYuK8
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="s3_late_bios.patch.gz"
Content-Transfer-Encoding: base64

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
BVgZOSD/BX2A9NgbIgAA

--ibTvN161/egqYuK8
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="s3_late_bios_radeon.patch.gz"
Content-Transfer-Encoding: base64

H4sICGpWh0ECA3MzX2xhdGVfYmlvc19yYWRlb24ucGF0Y2gAjY/BUoMwFEXX8BXPXWkaCKV1
LC0d/sCly0yAR81Ik5gEtDN+vKFVN44zZkFY3HtyLqUUBqnG91Rbeco6Kye0LptkhzoT/pJZ
Ef4UN+e0jdaMbWjOaJFDzsrtttywlH0fICxnLCaE3ID/YuWUBdauLNbltvjFqmugO7Zb3QOZ
r3wNdR1DJHtYmA4negyf1Og3tNx54RGqClgSEpFFP1oFbB9DTCLTSm7ReW3xFrzWV3CDODFh
x1utennizogWk31MQi1bwqMaLoB9j60PYyC8jEo0A3YwSQGiNZK7AdFUruCN1I4Ps8YyC+2/
Le8q2CQhEV3700kY7fxXthkdParx3KCFwwEe4AN+IL26ikHovY4ybAnOTg9hE54XyTwVZucn
8YKjgfZZmtnkE0T6S7HiAQAA

--ibTvN161/egqYuK8
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="s3_late_bios-x86_64-draft.patch.gz"
Content-Transfer-Encoding: base64

H4sICNNUh0ECA3MzX2xhdGVfYmlvcy14ODZfNjQtZHJhZnQucGF0Y2gAnVVtc9o4EP4sfsVe
2gaIbWzZ5iW0ZKCJr8cUCFPSmbu53mgcW4AvxmaQndBef/ytbJOQBEimfLDx7qPdZ1fPSpqm
QRhE6boWr4KZ7q68ub5uNVjD1m/4KuKh7nrLQBch58uaR0zDsDWjpVEbTKtNjbZJa8bmB4qB
/pKiKHnI10WjVDMo0NO2ZbRt+1E0itG6XdCoaainoMgXbUG3W4L/SkDu5kHIoVIRyQp+68Do
62BQheNjqJwUlvI3o1ytZlgSTEECI2+xlG8VjoTFroNYHKnQrEKnA0a1pBFCJEF2G/g8ZtPQ
nQnoAH1fUnZ7eufjPpsMHGfMJhb72L+cvN+bbBH7/MVkPztg7sn282m64eWFg9g3mM2QS/QT
uJpzwcGL09CHaw6ugFTwaRrKf9N4BbgXKlynCQRJWUASJ24Yfpdr4QTSKOEi4X4t/9bla2ch
oZvwTeuouSnndZwHvSun6NPB8EWzfin8pi888oOp3A4phw7g05uv8jxltVzd3ql7/Uhbhley
BWIZFcRU+JYc4RrtdfNy597wdFmbFANjaqhbw27XW23beibxlwfmcbj7iTExXHPnxFhqAxRL
bWbD8iaIvDD1OXxwxUIXfLbgUVKbnz31LN0Z32FeiJW0Ko+tklcGRjicx8vv2I55AkjQgrF7
y0MYut6c38CHpfzqClRizftxpoIfYEsDVCFHzfl8BZ/Gg1sTw2TMbYqsFdssuBPURkjeGmtq
Wna90Wyp8I67a3T8G3FyHc9SwVbcDdnCnQUestGIlDEuoSpsa0WDvInMQ2mhnArU8wk+tAyz
/iBUiir0cHQAAJl52Hr1rYXGRXx7R955AjkixayaU1lN3dhUkyPcNSKEKAFtbzM2f4GxFPvr
GGNqkuPkcD2G5YSx2VgUkW4meOI+FXux/zpuv1aINFdBIUtDMxuAdwIqs37oWngpzr28m+36
7gvBbEp947MQuM+nQcSB9SZDlvXnj0yXwRQdwNhn58vIGTCWHZZRbutNJs7w4+AvtMJDhPPL
4bg/cL6wC2fsjC6c0RXrj64aNu50GEez7HEQ/bWAp5EIZhH3t5ZlN1mjIZnTRlOlpxn3EvB1
gqMOaUsez0x2IvBZEjN3GXiB//c/eFBtTjPQT7aZy0M6qwn5kPPL0e/9T+xBHpkvZ0qey5zQ
fV4pKWLu896f4MQ+CMmitA5DepPPhD5k2n1XXE0qf1ZJpYLPY7wPzs7MalbZ3obAlmuz8+iA
bceDUNDzP+fNvJkECQAA

--ibTvN161/egqYuK8--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
