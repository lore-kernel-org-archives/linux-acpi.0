From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] overriding tables via initramfs in 2.6.1
Date: Tue, 20 Jan 2004 16:44:58 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law11-F108WFBXZGYmX00040d1b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think you should look into initramfs / early-userspace, because I think 
that's what it's intended for.
Check the 2.6.1/Documentation/early-userspace directory.
The files are unpacked pretty early, even before ACPI initialization. That's 
what my patch and Markus Gaugusch's patch are based on, the fact that 
initramfs/initrd are processed at such an early stage.


>Ducrot Bruno wrote:
>>
>>That seems to be good, but why not using already the
>>"ACPI DSDT in initrd" patch from Markus Gaugusch instead?
>>
>>It is fairly trivial to modify it to get all tables overide and do
>>not require all of those files creation/deletion.
>>
>
>That patch on itself is fine. But I think it is time for a more general way 
>of adding stuff to an initrd that should be accessable for the kernel 
>before the kernel is "really" running (for example bootsplash).
>
>So I would propose to have a new kind of initial image that consists of an 
>archive of all kinds of files. One of them is the initrd, of course.
>
>
>Regards,
>
>Bas.

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
