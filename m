From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Vaio PGC-FXA47 Troubles
Date: Mon, 19 Aug 2002 10:52:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208191052.55710.jbr.1@gmx.net>
References: <200208182302.01068.andre@masella.dynodns.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208182302.01068.andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andre Masella <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

2.4.19 is no good idea for a notebook that requires ACPI! The ACPI part of the 
kernel is totally out of date. There are a lot of bug fixes in the newer 
patches, that I really need to get my Vaio running at all.
There's currently no patch against 2.4.19. The current release will be put 
into 2.4.20. At the moment the best is to use a 2.4.18 and fetch the newest 
patch from http://sourceforge.net/projects/acpi/.

Most likely you will NOT get a working suspend with that combination. There 
are a lot of problems with suspend. The major work is currently done in 2.5.
But you will be able to use more features of ACPI with the patch. E.g. I can 
throttle my CPU via /proc/acpi/processor/CPU0/throttling. It's a lot of fun 
having a 1GHz notebook running at the speed of an old 386 ;-)

regards
Jochen

> I just got a Vaio FXA47 notebook and am having two seperate problems. I am
> running Gentoo with a Linux 2.4.19 kernel (from kernel.org -- not patched)
> and acpid 1.0.1
> The first is I cannot suspend the system. The /proc/acpi/sleep file
> contains "S0 S3 S4 S5" but using 0, 4, or 5 powers off the system. 3 seems
> to suspend it, but then it cannot be resumed. Is there a working suspend?
> The /proc/acpi/battery/ directory is empty. There is a battery in the
> system, but it doesn't show up in that directory. What's wrong?



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
