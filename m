From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Tue, 2 Nov 2004 23:09:58 +0100
Message-ID: <20041102220958.GF1407@elf.ucw.cz>
References: <20041018020816.48673359@localhost.localdomain> <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz> <20041101145410.GB12006@tate.loria.fr> <20041101154127.GB1056@elf.ucw.cz> <20041102220034.GA31435@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041102220034.GA31435-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Uff, this looks pretty ugly. But I guess it is i386 being ugly...
> 
> The present version does the indirection once and for all, it's more
> readable. I've documented a bit the segment descriptor stuff, so that
> it's not so mystifying. I can do most of it in C, using asm/processor.h
> and asm/desc.h if you prefer.

Yes, that would be nice.

> > > +	if (((pci_dev->class ^ (PCI_CLASS_DISPLAY_VGA << 8)) & 0xffff00)==0)
> > The use of xor here is certainly interesting. Is it possible to say
> > 	pci_dev->class & 0xffff00 == PCI_CLASS_DISPLAY_VGA << 8
> 
> ;-) This one got me laughing as well. I do prefer the (a & b) == c idiom
> (now used), but I was amused by this xor in pci_match_one_device.

Good.

> I've moved it into asm/acpi.h instead, which was the place where I
> intended to put it at first. This implies protecting most of asm/acpi.h
> with #ifndef __ASSEMBLY__ , but this makes sense for asm/ includes,
> doesn't it ? Do you prefer this location ?

I think that's better.

> s3_late_bios-x86_64-draft.patch.gz is untested. It lays the ground for
> doing the same for x86_64 , but currently I don't have access to amd64
> boxes where I can play with acpi (you wouldn't play such games on a
> department level server, would you ?).

Well, it depends if you want to keep your work, I guess :-). Okay,
x86-64 can wait.

Thanks,
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
