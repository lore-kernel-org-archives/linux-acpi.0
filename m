From: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: Re: DSDT in initrd
Date: Wed, 21 May 2003 00:23:12 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <baf9df$ro3$1@main.gmane.org>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com> <Pine.LNX.4.53.0305191725350.9728@dynast.gaugusch.at> <20030520180149.GJ31518@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0305202002180.22586@tweety.gaugusch.at>
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

> On May 20, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> wrote:
>> No.  Linus will take one look at it and vomit.
> Because I'm scanning raw initrd data? Can anybody give me hints or a
> better solution? I'm willing to improve it, but I don't think that it is
> easy to do.

I continue to think that the proper solution is a separate kernel parameter
acpi_tables=/boot/tables.??? (with credit to the person who generalized
this idea from the dsdt to all tables).  I know you're concerned about fs
drivers not being around, but if the kernel can find the initrd on the disk
it should be able to find other files somehow.  

It depends on what you think the initrd is for, though.  If it's just a
generic pseudo-disk for early boot time then putting the acpi tables in is
sensible, but if you think that certain specific things (e.g. modules)
"belong" in it while others don't then maybe it'll be more of an issue.  I
guess my next question would be, is there a filesystem in the initrd, and
if so can you implement your patch in a way that respects the filesystem
abstraction rather than scanning the raw bytes.  I'm not much of a kernel
hacker myself, but I can see how people would be uncomfortable with the
precedent it would set to allow that kind of raw byte scanning.

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
