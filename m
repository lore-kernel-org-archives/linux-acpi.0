From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: RE: Working around bugs in ACPI BIOS [was Re: DSDT in
	initrd]
Date: 19 May 2003 18:55:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053366899.29226.2.camel@dhcp22.swansea.linux.org.uk>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E51B@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E51B-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Llu, 2003-05-19 at 18:38, Cagle, John (ISS-Houston) wrote:
> That said, it would be nice to relax that constraint in the Linux
> ACPI implementation.  The BIOS developers are aware of the issue and
> they are rolling that change into new implementations going forward,
> but there's no way all existing laptops will get new versions of the
> BIOS.

There I would agree. The -ac 2.4 tree has a config option for "relaxed"
ACPI, so you can have it to the spec - which might suit the more
paranoid types such as telco's, or to the reality which is a bit looser.
This is a prime candidate



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
