From: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: DSDT in initrd
Date: Wed, 21 May 2003 10:05:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ECB95CB.2020109@hp.com>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com> <Pine.LNX.4.53.0305191725350.9728@dynast.gaugusch.at> <20030520180149.GJ31518@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0305202002180.22586@tweety.gaugusch.at> <baf9df$ro3$1@main.gmane.org> <Pine.LNX.4.53.0305210955210.13798@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Concerning Red Hat Linux, the initrd.img is a compressed ext2 filesystem 
and the ext2 driver is built statically into the kernel.

The question is if ext2 is built statically into the kernel then are the 
ext2 functions (i.e. the ext2 driver) available when ACPI would be 
trying to load the dsdt table. My first response would be yes, since it 
is static in the kernel, you may use those functions any time you need 
them -- but that's only a guess as I haven't studied how the kernel 
boots that closely.

If anyone wants to examine initrd.img files it is super simple -- make 
use of the command "file" to help you along on your own. Or if you want 
full details then I have them here: http://www.cpqlinux.com/rhdiskmod.html

Probably the splash is just raw data attached to the initrd because it 
is likely it needs to be used before the kernel is even loaded. In our 
case the kernel is in the process of loading or is loaded.

Sincerely,
Richard Black

Markus Gaugusch wrote:

>On May 21, Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org> wrote:
>
>  
>
>>I continue to think that the proper solution is a separate kernel
>>parameter acpi_tables=/boot/tables.??? (with credit to the person who
>>generalized this idea from the dsdt to all tables).  I know you're
>>concerned about fs drivers not being around, but if the kernel can find
>>the initrd on the disk it should be able to find other files somehow.
>>    
>>
>The file is not loaded by the kernel, but by the boot loader. Someone said
>that grub is able to load more than one file, but I think lilo is not.
>Also, the kernel has only support for one initrd, and I am not good enough
>at the moment to add support for more, I guess.
>Although the way I use to read the initrd is a bit hacker-ish, it is not
>that bad I think. Bootsplash uses the same technique and is used by major
>distributors. If it were insecure they could not use it (initrd is a major
>part for distributions with pre-compiled kernels).
>
>Markus
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
