From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Re: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron 8200)
Date: Thu, 19 Feb 2004 00:57:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040218235751.GA13838@homerelay.wiesner-net.de>
References: <200402181320.29381.mailinglists@glomann.de> <1077111155.2028.3.camel@personal-118.mip.sdu.dk> <200402182017.47960.mailinglists@glomann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402182017.47960.mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thomas Glomann schrieb:
>On Wednesday 18 February 2004 14:32, Mads Paulin wrote:
>> Try to spind the drive down using hdparm and see if that helps.
>>
>nope, putting the drive to sleep doesn't do the trick. the sound
>remains.

I have the same problem with my Inspiron 8200. (Tried only 2.6.0 some
weeks ago, but the problem obviously still exists in newer kernels)

It has nothing to do with the drive but only the CPU being idle. When
doing e.g. "dd if=/dev/zero of=/dev/null" the noise is gone. Slowing
down the CPU via "echo $SOMELIMIT > /proc/acpi/processor/CPU0/limit"
reduces the noise, too. (lowering performance and throttling both help)

But both methods are not really a solution to make kernel 2.6 usable
with this machine. :-(

I read somewhere that it might be caused by the higher HZ value in
kernel 2.6 (1000, 2.4 uses 100). Is it safe to change this value or can
there be unwanted side effects?

Markus
-- 
This message has been ROT-13 encrypted twice for higher security.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
