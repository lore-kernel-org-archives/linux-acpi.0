From: ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org
Subject: Re: ACPI 2021111 on Asus L3800C
Date: Thu, 14 Nov 2002 15:43:22 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DD3C49A.3070405@mindspring.com>
References: <20021114203058.05b4c3c1.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021114203058.05b4c3c1.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Regarding swsusp and X. It appears that your laptop probably has a 
Mobility Radeon 7500 (according to Asus' site). I have a Radeon VE (now 
known as the 7000) in my desktop and have been able to get swsusp from X 
to work, by disabling DRI (and after resuming, you don't get xvideo, 
either.. so no speedy movies). This is, obviously, not an ideal 
solution. You didn't get a Radeon just for fast 2D graphics.

I have found, though, the following site that might be of interest to 
you: http://cpbotha.net/dri_resume.html. I've recently downloaded the 
latest CVS of X from dri.sourceforge.net and tried applying this patch, 
to no avail (X still hangs the machine when I resume). I believe I may 
need to actually get the particular version that cpbotha mentions on his 
webpage, but I'm not so familiar with using CVS.

Anyway, if you're feeling adventurous, check out dri.sourceforge.net. 
They have instructions there on how to download and compile the latest 
CVS. The patch from cpbotha applied semi-cleanly (with, I think, 1 
failed hunk or so) with: patch p0 < xfree86-dri-resume-v5.patch. But, 
again, X still freezes in my case, even if I switch to text mode (using 
framebuffer mode) before suspending. I may need to do some more haxoring 
to my suspend/resume script and possibly some changes that he mentions 
on that site -- it was late last night when I finally got the Beast to 
compile.

Of course, the other option is to just download the binaries and use 
those. Except that there's no fun in having things work without a 
struggle ;-).

Anyway, HTH.


-Andy



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
