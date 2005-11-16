From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: s3 buggy after kernel-update
Date: Wed, 16 Nov 2005 22:08:14 +0100
Message-ID: <20051116210814.GB12561@elf.ucw.cz>
References: <437A0B9E.50501@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <437A0B9E.50501-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rathgeb Markus <maggu2810-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> i own a 'targa traveller 811'. the company 'targa' supports only 
> microsoft windows (who is suprised).
> for a few month i spend a lot of time to get s3 working and since then i 
> used suspend-to-ram with full satisfaction with kernel 2.6.12-gentoo-r10 
> (kernel from gentoo-sources with my own configuration).
> because of an update to version 2.6.14-gentoo-r2 the screen keeps blank 
> / black / off after wake up from s3. i changed nothing in the kernel 
> confiuration (except the new functions - make oldconfig...).
> where can be the problem?
> does somebody know what could be responsible for this?

Look at Doc*/power/video.txt. If that fails... you probably need to
binary search for what broke it. Oh and try vanilla kernels...

							Pavel

-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
