From: rao-X0/UTAGn731gyGvZe3TC8g@public.gmane.org
Subject: How do I get acpi_handle for the battery?
Date: Mon, 29 Dec 2003 03:52:35 -0700 (MST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <61012.65.101.177.176.1072695155.squirrel@webmail.ece.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi
 I'm working on a battery lifetime estimation tool which implements some
recent ideas on the way batteries discharge, recover charge, etc.  This
requires maintaining a history of battery current (present rate in
/proc/acpi/battery/BAT1/state) values which are to be updated frequently
(about once every 1 to 5 s).

 The battery.c file in /usr/src/linux/drivers/acpi has a function
acpi_battery_status( ) which is defined as follows:
static int acpi_battery_get_status(struct acpi_battery *battery, struct
acpi_battery_status **bst)

 This function then calls acpi_evaluate_object( )
    status = acpi_evaluate_object(battery->handle, "_BST", NULL, &bu      
 ffer);

 where the handle is of type struct acpi_handle.  Now, how does one obtain
this acpi_handle? In the ACPI programmer's reference, section 4.2.7, it
is mentioned that
"A handle to an object is obtained by creating an attachment to the object
via the AcpiPathnameToHandle or AcpiNameToHandle primitives".

  However, I could not find such a primitive acpi_pathname_to_handle (or
anything similar) in the following source directories:
/usr/src/linux/drivers/acpi
/usr/src/linux/include/acpi

  I have the sources for the Linux 2.4.22-10mdk kernel.

  Any suggestions or pointers to relevant documentation would be very
helpful.

Thank You
-Ravi








-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
