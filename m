From: Jean-Pierre Schwickerath <lists-Z7rXY4Hz9HLk1uMJSBkQmQ@public.gmane.org>
Subject: Re: ACPI suspend weirdness on Dell Inspiron 2650
Date: Tue, 11 Feb 2003 08:57:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211085740.7a431645.lists@schwicky.net>
References: <3E491E11.20001@ihug.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E491E11.20001-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org> wrote:

> Hi,
> 
> I've finallyjust managed to get some kind of suspend state
> working on my Dell Inspiron 2650 laptop, using the 2.4.21-pre3 kernel
> and the ACPI-20030125-2.4.21-pre3 patch (under RedHat 7.3). I can
> get some kind of suspend state working using 'echo 1
> >/proc/acpi/sleep'
> but I don't think it's the genuine suspend-to-RAM state. For one

You're right.

> Nothing at all seems to happen if I try to echo 3, 4, 4b or 5 to 
> /proc/acpi/sleep,
> which is strange since the ChangeLog for the latest ACPI patch
> mentions being able to change settings for the S3 suspend, and it also
> claims to incorporate the s4bios patch. If I cat /proc/acpi/sleep I
> get "S0 S1 S3 S4 S5", so
> I'm not sure if I'm doing something wrong, or if ACPI suspend-to-RAM
> support isn't fully functional yet.

Suspend-to-RAM is S3 as far as I know and someone posted here that it'll
probably no be working on 2.4 that soon. Rather try kernel 2.5.x for
this. 

Jean-Pierre
-- 
Powered by Linux From Scratch - http://schwicky.net/
PGP Key ID: 0xEE6F49B4 - AIM/Jabber: Schwicky - ICQ: 4690141

Nothing is impossible... Everything is relative!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
