From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: [Swsusp-devel] swsusp and ac status
Date: Thu, 24 Jun 2004 17:13:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406241513.i5OFDpKC003189@fermat.unipv.it>
References: <mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
   of "Thu, 24 Jun 2004 22:37:12 +0800." <opr93r8ap24evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> For now, in practice all ACPI modules should be unloaded prior to
> suspend and loaded on resume.
> 
> I use the AC module and kernel 2.4.24 with swsusp 2.0 and it works
> fine as long as it is removed prior to suspend.

Unloading acpi modules, suspending, resuming and loading modules
again does not help for me (2.6.7 and swsusp 2.0.0.88).
Even after resuming, if I

rmmod ac
insmod ac

then I don't see the new charging state. On the other hand if, after 
resuming, I change the charging state again, then ac detection works 
OK.

I tried also with 2.4.25 and swsusp 2.0 ... then it is stranger: 

- suspend with ac plugged
- unplug
- resume
- ac is correctly detected off-line
- next changes in ac state are not detected


morph-XAiDara3MvRg9hUCZPvPmw@public.gmane.org said:
> Would you mind checking to see (with top or something) whether or
> not keventd is using 100% CPU next time this happens.

It is not. CPU is about 1% (mostly used by X)

Daniele




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
