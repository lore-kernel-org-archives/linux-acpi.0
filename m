From: Theodore Morse <ender5175-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Patch
Date: Wed, 25 Dec 2002 21:12:31 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021226051231.55578.qmail@web13703.mail.yahoo.com>
References: <1040837764.2777.8.camel@justlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1040837764.2777.8.camel-SH3sQJamR4OeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mailhebuau Christophe <CMailhebuau-GyotsYYSwH0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mailhebuau,

I had this same problem. I compiled the latest acpi
patch into 2.4.20, and did not get an acpi directory
in /proc. This was due to the fact that APM was
initializing first, and ACPI did not try to override
it, even though my BIOS did not support APM. What I
did was not include APM support in the kernel. This
fixed it for me.

Hope this helps. Good luck.

Ted Morse

--- Mailhebuau Christophe <CMailhebuau-GyotsYYSwH0@public.gmane.org>
wrote:
> Hi,
> 
> I have compiled my kernel with acpi support, but i
> don't have
> subdirectory :
> 
> /proc/acpi
> 
> What must i do ?
> 
> apply patch ? and compiled again ?
> 
> what i must used patch, which version ? my kernel is
> 2.4.19-16
> 
> which command i must used to apply patch ?
> -- 
> Cordialement,
> Christophe Mailhebuau    http://www.justlinux.org
>                            http://www.abul.org
> GPG: 1024D/75B07F8D: BD18 2D01 D954 A339 E35B 9EA1
> 4240 0410 75B0 7F8D
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



=====
Ted Morse
Student/Programmer
University of Evansville/Ciholas Enterprises

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
