From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Video Extension patch
Date: Thu, 26 Aug 2004 17:30:02 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093555801.11567.26.camel@6-allhosts>
References: <3ACA40606221794F80A5670F0AF15F84054F41D0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84054F41D0@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-08-26 at 06:21, Yu, Luming wrote:
> All,
> Since Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> has implemented acpi video
> extension filed at bug 1944.
> I made some improvement against his code. 
> 
> The patch [1/2] posted here is the original implementation of video
> extension written by Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> .
> The patch [2/2] posted here is my patch on top of the patch [1/2]. 
> Please give it a review, and have it a try.
> 
> Thanks 
> Luming

Hello,

I have a Dell Insprion 300m notebook with an Intel 855GM integrated
graphics device. I gave the video extensions code a try, primarily with
an interest in brightness control from userspace (for example, lowering
brightness at a certain battery level). Right now, the brightness keys
(Fn+Up/Down Arrow) are caught by the BIOS and work without any extra
code in the kernel. There are two problems for me right now: first,
brightness control is not effective. Doing:

root@dell-laptop /home/abarr/tmp # echo 40 >
/proc/acpi/video/GFX0/LCD/brightness
root@dell-laptop /home/abarr/tmp # cat
/proc/acpi/video/GFX0/LCD/brightness
levels:  80 60 0 20 40 60 80 100
current: 40

will change the current value, as you can see, but it does not change
the brightness value for my screen. Second, pressing the brightness
control buttons with the video extensions patch applied causes a loss of
keyboard input. The mouse will work, but both internal and external
keyboards are dead after using those keys. BIOS-trapped keys such as
brightness and CRT/LCD still work. I do get a video event in
/proc/acpi/event when I press the CRT/LCD switch key.

Now, I realize that this code is new and experimental. I'm just hacking
around here, and if anyone gets a chance to help me out I'd greatly
appreciate it.

Andrew



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
