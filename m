From: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 06:05:11 +0000
Message-ID: <200502150605.11683.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
[snip]
>
> Table of known working systems:
>
> Model                           hack (or "how to do it")
> ---------------------------------------------------------------------------
>--- IBM TP R32 / Type 2658-MMG      none (1)
> Athlon HP Omnibook XE3		none (1)
> Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
> IBM t41p			none (1)
> Athlon64 desktop prototype	s3_bios (2)
> HP NC6000			s3_bios (2)

The above report is incorrect. On 2.6.11-rc4, even with the s3_bios option, 
the NC6000 (which I own) still does not wake up from S3 sleep. The wiki 
linked somewhere else in this thread also identifies these machines as not 
working.

> Toshiba Satellite 4080XCDT      s3_mode (3)
> Toshiba Satellite 4030CDT	s3_mode (3)
> Dell D600, ATI RV250            vga=normal (**)
> Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
> Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
> Acer TM 800			vga=normal, X patches, see webpage (5)
> Athlon64 Arima W730a		vbestate needed (6)
> eMachines athlon64 machines	vbestate needed (6) (someone please get me
> model #s)
>
> (**) Text console is "strange" after resume. Backlight is switched on again
>
>      by the X server. X server is:
>      | X Window System Version 6.8.1.904 (6.8.2 RC 4)
>      | Release Date: 2 February 2005
>      | X Protocol Version 11, Revision 0, Release 6.8.1.904
>      | Build Operating System: SuSE Linux [ELF] SuSE
>
>      as present in SUSE 9.3preview3.
>
> (***) To be tested with a newer kernel.
>
> (****) Not with SMP kernel, UP only.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
