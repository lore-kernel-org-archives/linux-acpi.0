From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: DSDT in initrd
Date: Wed, 21 May 2003 18:52:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030521165234.GD346@poupinou.org>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com> <Pine.LNX.4.53.0305191725350.9728@dynast.gaugusch.at> <20030520180149.GJ31518@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0305202002180.22586@tweety.gaugusch.at> <baf9df$ro3$1@main.gmane.org> <Pine.LNX.4.53.0305210955210.13798@dynast.gaugusch.at> <3ECB95CB.2020109@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ECB95CB.2020109-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 21, 2003 at 10:05:47AM -0500, Richard Black wrote:
> Concerning Red Hat Linux, the initrd.img is a compressed ext2 filesystem 
> and the ext2 driver is built statically into the kernel.
> 
> The question is if ext2 is built statically into the kernel then are the 
> ext2 functions (i.e. the ext2 driver) available when ACPI would be 
> trying to load the dsdt table. My first response would be yes, since it 
> is static in the kernel, you may use those functions any time you need 
> them -- but that's only a guess as I haven't studied how the kernel 
> boots that closely.

No.  acpi is initialized too early (due to irq routing stuff for example)
VFS is intialized way to late to be used for retrieving acpi tables in
disks.

If you want something like that, you have to modify boot loaders (grub,lilo,
etc.) then write approriate code in kernel setup stage, etc.  It is 
actually not so hard to do.  Just, well, boring stuff in fact, not to
mention you have to send patch to at least main boot loaders maintainers.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
