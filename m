From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Mon, 1 Nov 2004 15:54:10 +0100
Message-ID: <20041101145410.GB12006@tate.loria.fr>
References: <20041018020816.48673359@localhost.localdomain> <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041020225334.GC29863-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi all,

The attached patch provides acpi_sleep=s3_late_bios boot option. This is
just a trivial wrap-up of Ole's patch. It hooks into pci_default_resume
(on X86 only and even then only when the flag is given), so you actually
can resume the video without a framebuffer driver (and if you do have
one, well, it should do what it takes to handle resume).

Ole, do you mind having your code wrapped up this way ?

I'd be curious to know whether other machines than my Dell D600 (with a
radeon 9000) and Ole's Fujitsu P2120 (with a radeon 7000) work with this
hack.

A few annoying bits, still:

When the machine resumes (using s3_late_bios), hitting a key seems to be
necessary to finish the wakeup. Weird.

At present, I can resume with video=radeonfb:off acpi_sleep=s3_late_bios
, but not from a VESA mode: the machine hangs in the VGA bios lcall. I'm
having difficulties issuing good beeps during the late real mode step:
beep starts, but never ends. So perhaps something is wrong with the real
mode setup, forbidding I/Os, or something like this (which could explain
that resuming from anything less trivial than basic 80x25 crashes). The
beep code I use is from pcspkr.c :

#define BEEP(X)                 \
        inb     $0x61, %al;     \
        orb     $3,%al;         \
        outb    %al, $0x61;     \
        movb    $0xb6, %al;     \
        outb    %al, $0x43;     \
        movb    $0, %al;        \
        outb    %al, $0x42;     \
        movb    X, %al;         \
        outb    %al, $0x42;     \
        movw    $0x3FF, %bx;    \
20:                             \
        movw    $0, %ax;        \
21:                             \
        decw    %ax;            \
        jnz     21b;            \
        decw    %bx;            \
        jnz     20b;            \
        inb     $0x61, %al;     \
        and     $0xfc, %al;     \
        outb    %al, $0x61
#define DEBUG_TONE      \
        BEEP($0x20);    \
        BEEP($0x04)


E.

On Thu, Oct 21, 2004 at 12:53:34AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > For debugging techniques... There's beeping patch from me floating
> > > around.
> > 
> > Thanks, but with 2.6.9-final it actually does resume, so luckily I won't
> > have to suffer the beeping :)
> 
> Good.
> 
> > I do hit the video problem though. I've tried the stuff in
> > power/video.txt, but mine doesn't seem to be among the few systems with
> > a solution at the moment. I don't have a Radeon, so I haven't tried the
> > radeonfb-patch that's been floating around
> > (http://www.loria.fr/~thome/d600/), but the part that mentions "you may
> > insert a similar call from the vesa frame buffer driver to obtain
> > similar results for a wide range of cards" intrigues me. Could this be
> > something to try? Or is this already what acpi_sleep=s3_bios does?
> 
> No, its something different. Take Ole's patch and port it to whatever
> framebuffer you use... and good luck with that.
> 								Pavel

--CUfgB8w4ZwR/yMy5
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="s3_late_bios.patch.gz"
Content-Transfer-Encoding: base64

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
5vI7pcgtKiJH/C+dEOj2BB8AAA==

--CUfgB8w4ZwR/yMy5
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="s3_late_bios_radeon.patch.gz"
Content-Transfer-Encoding: base64

H4sIAFJFhkECA42PzW7DIBCEz/ZT7DGJgw2JEzXOj/wGPfaIMF6nqA5QwG4j9eGLk6aXXsoB
VmLnmxlCCPRKD5+5cepctE6N6HwxqhZNIcK1cCJOmttLLpMVpSVhlKwZMFptNlVJc/o4kFFG
aZpl2R34LxYjlAFlVbmtVps/rLoGsqO75Ray6WEM6jqFRHUwsy2O5BSv3JoPdNwHERCOR6Dz
uJE4DIPTQPcppFlipeIOfTAOfxZv+iXcKV6M2HJpdKfO3Fshcb5Ps6grFvCs+ytg16EMsQ1E
a9Si6bGFUQkQ0irue0R79GveKON5P+EXRVTfPsezsMaHR+Bm8OSkh0uDDg4HeIIv+G3S6Zst
ROH7oGLUmMibPkbGy2w+NYEp0Yt4w8GCfFV28vkGoSOKssEBAAA=

--CUfgB8w4ZwR/yMy5--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
