From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI black-list (was RE: Working around bugs in ACPI BIOS [was Re
	: DSDT in initrd])
Date: Tue, 27 May 2003 11:28:14 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A6647054FC457@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > A please upgrade signature table so that vendors who have 
> fixed bioses
> > have a way to let customers find this out without bitching 
> at support
> 
> Yeah.

I like this too.  If somebody hasn't done it already I volunteer to take a
swing at it.

This sort of leads to examination of the ACPI black-list scheme -- which I
think needs some work.

It should have a cut-off date for each vendor, with a black list disabling
ACPI on platforms newer than that date, plus a white list enabling ACPI for
platforms older than the cutoff date.  If the OEM isn't on the list, there
should be a default cut-off date.  If the date is about in the right place,
then the black and white lists will be short. 

Also, the current black list has 3 possible outcomes:
1. pass black list and continue with everythything enabled.
2. fail black list, print a warning, but continue with acpi anyway ("non
critical")
3. fail black list, and disable ACPI.

Option 2 is worthless.  Probably better would be some flag bits that disable
the part of ACPI that actually fails -- leaving the rest intact.  (eg. Just
because fan speed adjustment has a bug doesn't meen that power states have
to be disabled).

I think if we do this, then it will be easier to deploy and support
ACPI-enabled systems, and less necessary for hackers to enhance their DSDT
just to make their sytem function.

Cheers,
-Len


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
