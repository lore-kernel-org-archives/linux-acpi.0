From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Tue, 24 Feb 2004 00:06:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403ADBCC.9060108@verizon.net>
References: <4038F499.2060302@verizon.net> <1077517907.12673.43.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077517907.12673.43.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:

>>    
>>
>
>I've got a laptop running Fedora Core 2 out of the box, and all I do is
>
># echo 3 >/proc/acpi/sleep
>and I use the power button to wake it up.
>
>I've also got a D875PBZ, however
>
>[root-BJIgRQarj28@public.gmane.org /]# echo -n 3 >/proc/acpi/sleep
>Stopping tasks: ==============================
> stopping tasks failed (1 tasks remaining)
>Restarting tasks...<6> Strange, katad-1 not stopped
> done
>[root-BJIgRQarj28@public.gmane.org /]#
>
>which I guess is due to its SATA boot drive.
>Do you have a regular PATA drive?
>
>cheers,
>-Len
>
>
>
>  
>
Yes I do have regular PATA drives. Could you give me the details on your 
configuration? Other hardware, kernel and patches applied?

Thanks.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
