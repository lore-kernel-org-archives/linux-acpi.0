From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Waking from Sx : Test more!
Date: Wed, 24 Jul 2002 01:05:29 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207232209.g6NM8sK04910@pfn1.pefnos>
References: <20020627195226.GA29113@srcf.ucam.org> <200206272109.g5RL92I04788@pfn1.pefnos> <20020723073432.GA116@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020723073432.GA116-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > You often say "waking from S1/S3 works fine for me" etc.
> > I 've noticed that in a ratio of 1/20 times my machine doesn't wake. Do
> > you report after one sucessful wake?
>
> S1 or S3?
> Pavel

I was referring to S1. That was quite some time ago. 
Now, I have the 2.5 tree, and don't apply any patches (I want to keep the 
official kernel).  The problem I had mentioned hasn't appeared ever since. 
What I get is a frozen ACPI subsystem after the S1 (*1) and a dead USB. I 
haven't tested S3. I 'll let you know if I get any specific debugging.

*1. thermal won't report the temperature (50 deg. C continiously). The USB 
can't even unload its modules (as if this was supported). I can't say I have 
debugged that at all. I just report some trouble.

System: HP OB XE3 GC with 2.5.27.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
