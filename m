From: Nigel Cunningham <ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: Thu, 01 Apr 2004 16:03:44 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080799424.1889.14.camel@calvin.wpcb.org.au>
References: <c15rn0$5bu$2@sea.gmane.org> <1077519609.12675.63.camel@dhcppc4>
	 <20040223074227.80AE57831D@mail.lmc.cs.sunysb.edu> <406ABD4A.10408@pca.it>
	 <1080781821.3066.5.camel@calvin.wpcb.org.au>
	 <20040401040507.0AAC477A2B@mail.lmc.cs.sunysb.edu>
Reply-To: ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040401040507.0AAC477A2B-Yo/1PYb2HdawRS80dfYGFoIJIQD0bWaD@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
Cc: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I'm using XFree 4.3, and thus needed the patch. Since you're running
4.4, I would guess that the Radeon part should work out of the box. When
I didn't have Charles' patches applied, everything else resumed okay,
but the X server was messed up to the extent that the mouse and keyboard
were useless. (I could ssh in though). Is this what you're getting?

Regards,

Nigel

On Thu, 2004-04-01 at 14:04, Giridhar Pemmasani wrote:
> Hi Nigel,
> 
> Thanks for the information (and of course your work with swsuspend2)!
> 
> I am a bit confused about what I need to do to get swsusp2 working
> with radeon+agpgart+dri. I am using XFree86 4.4.0 with
> 2.6.5-rc3-mm2. If I understand correctly, Charles Botha's patches are
> already in XFree86 4.4.0 and latest DRI. So do I need to do any
> patching or the setup I have will work if I use swsusp2?
> 
> Thanks again,
> Giri
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
