From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Reference object type?
Date: Fri, 9 Apr 2004 00:03:04 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040408235720.K45889@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bob and others,

I can't seem to figure out the canonical ways to retrieve a Reference
type.  The ACPI-CA code seems to indicate:
    Type == ACPI_TYPE_LOCAL_REFERENCE and use obj->Reference.Handle

I also support ACPI_TYPE_ANY since that seems to be the previous type.
Strings seem to be another way.  This is needed for objects like this:
    Package() {\_SB.PCI0.ISA.GPE, 2}

Anyway, comments on my code below are welcome.  It retrieves a handle from
various forms of a reference and seems to have worked for a few years, at
least for thermal zones.

Thanks,
-Nate

----
 njl         2004/04/08 23:55:50 PDT

  FreeBSD src repository

  Modified files:
    sys/dev/acpica       acpi_powerres.c acpi_thermal.c
  Log:
  Replace more ad-hoc versions of acpi_GetReference().  Since the type of
  Reference objects changed from ACPI_TYPE_ANY to ACPI_TYPE_LOCAL_REFERENCE
  in Oct. 2002, this may help systems where switching the cooler on failed.
  We support both types for now until this sorts out.

  Revision  Changes    Path
  1.136     +33 -26    src/sys/dev/acpica/acpi.c
  1.3       +31 -0     src/sys/dev/acpica/acpi_package.c
  1.20      +3 -23     src/sys/dev/acpica/acpi_powerres.c
  1.41      +30 -69    src/sys/dev/acpica/acpi_thermal.c

--- src/sys/dev/acpica/acpi_package.c:1.2	Tue Dec 23 10:26:53 2003
+++ src/sys/dev/acpica/acpi_package.c	Thu Apr  8 23:40:03 2004
@@ -122,4 +122,35 @@
 	return (ENXIO);

     return (0);
+}
+
+ACPI_HANDLE
+acpi_GetReference(ACPI_HANDLE scope, ACPI_OBJECT *obj)
+{
+    ACPI_HANDLE h;
+
+    if (obj == NULL)
+	return (NULL);
+
+    switch (obj->Type) {
+    case ACPI_TYPE_LOCAL_REFERENCE:
+    case ACPI_TYPE_ANY:
+	h = obj->Reference.Handle;
+	break;
+    case ACPI_TYPE_STRING:
+	/*
+	 * The String object usually contains a fully-qualified path, so
+	 * scope can be NULL.
+	 *
+	 * XXX This may not always be the case.
+	 */
+	if (ACPI_FAILURE(AcpiGetHandle(scope, obj->String.Pointer, &h)))
+	    h = NULL;
+	break;
+    default:
+	h = NULL;
+	break;
+    }
+
+    return (h);
 }


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
