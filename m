From: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: Re: Re: DSDT in initrd
Date: Wed, 21 May 2003 11:07:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <bagf6e$tq2$1@main.gmane.org>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com> <Pine.LNX.4.53.0305191725350.9728@dynast.gaugusch.at> <20030520180149.GJ31518@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0305202002180.22586@tweety.gaugusch.at> <baf9df$ro3$1@main.gmane.org> <Pine.LNX.4.53.0305210955210.13798@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
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

Markus Gaugusch wrote:

> On May 21, Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
> wrote:
> 
>> I continue to think that the proper solution is a separate kernel
>> parameter acpi_tables=/boot/tables.??? (with credit to the person who
>> generalized this idea from the dsdt to all tables).  I know you're
>> concerned about fs drivers not being around, but if the kernel can find
>> the initrd on the disk it should be able to find other files somehow.
> The file is not loaded by the kernel, but by the boot loader. Someone said
> that grub is able to load more than one file, but I think lilo is not.

That's what I imagined.  I didn't mean to attribute this to the kernel, but
I see that's basically how I wrote it.

> Also, the kernel has only support for one initrd, and I am not good enough
> at the moment to add support for more, I guess.

I know it's not easy, but if it's the right way then it's the right way.

> Although the way I use to read the initrd is a bit hacker-ish, it is not
> that bad I think. Bootsplash uses the same technique and is used by major
> distributors. If it were insecure they could not use it (initrd is a major
> part for distributions with pre-compiled kernels).

I don't think anybody's questioning the security of the approach.  I just
get the feeling that you'll get resistance to it.  You might try floating
the idea on the kernel list and see how people react.  I've got my opinion
on how it should work, but I can see that you have to have this data very
early on and it will not be trivial to make it work my way.  Linus may end
up agreeing with you, which would probably help your argument for inclusion
of your patch.  :-)

Cheers,
-Nathan

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
