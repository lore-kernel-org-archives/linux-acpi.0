From: Craig Ringer <craig-izDLMxIPhbnw5XnJhPqE1ikBLnlaf3ui@public.gmane.org>
Subject: Re: acpi and presario 700
Date: Fri, 18 Oct 2002 15:04:58 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DAFB29A.3060501@postnewspapers.com.au>
References: <3D929B6A000178E7@ims4c.cp.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>i'm a newbie (acpi is in my kernel but how to apply?)

In case you missed it from the last post, you'll quite possibly need to 
patch your kernel for ACPI support since the ACPI code shipped in the 
kernel is very outdated. I don't use Red Hat, so its possible that their 
kernel includes an up-to-date ACPI - but I wouldn't bet on it.

If you have any problems, download a vanilla 2.4 kernel from your local 
kernel.org mirror and the latest ACPI patches from 
sourceforge.net/projects/acpi, apply the ACPI patches, build and install 
the kernel, then give it another try.

> Note: if you want S3 you must use 2.5 kernels

... however, you can get away with swsusp ( virtual S4 ) on a 2.4 
kernel. I'm using it on my laptop, a Toshiba Satellite Pro 4600, and it 
works a treat. Really nice in combination with win2k's hibernate feature 
if you have to use win2k too (eg to make the crapmodem in your laptop work).

-- 
Craig Ringer
GPG Key Fingerprint: AF1C ABFE 7E64 E9C8 FC27  C16E D3CE CDC0 0E93 380D
	-- if it ain't broke, add features 'till it is. (or:)
	while (! broken) { features ++ ; broken = isBroken(features) }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
