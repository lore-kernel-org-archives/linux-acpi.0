From: Toni Erdmann <toni.erdmann-S0/GAf8tV78@public.gmane.org>
Subject: Re: mobo A7V600-F and problems with sound
Date: Tue, 24 Feb 2004 16:38:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403B6FEF.1000609@web.de>
References: <4038FDDB.8090807@web.de> <1077518290.12669.49.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077518290.12669.49.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote

>go ahead and file the bug and make the tar-ball an attachment.
>
>would be good if you can try a 2.6.3 kernel, I don't really know what is
>in suse's 2.4.21-166-athlon kernel.
>
>thanks,
>-Len
>
Hello,

I tried to post a bug at bugzilla.kernel.org for 'sound' and 2.6.3 but 
got an internal
error : "THE MAINTAINER HAS NOT YET BEEN SET" and
"A legal Archtecture was not set".

Anyway, there's no hint in 'dmesg' for problems with ACPI, but sound does
not work with 2.6.3 either.

"ALSA sound/pci/via82xx.c:585: codec_read: codec 0 is not valid [0xfe0000]"

Same message (with 'codec_valid') appeard with 2.4.21-...

Thnaks,
Toni



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
