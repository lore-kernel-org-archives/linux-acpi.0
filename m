From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: LID state
Date: Thu, 19 Dec 2002 08:29:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E017549.5FA54255@monetplus.cz>
References: <20021218221142.GA321@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1E380A4B8BDC0987A4747EF0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------1E380A4B8BDC0987A4747EF0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

	should you try this patch? It's simple (& maybe stupid), but it adds =

/proc/acpi/button/lid/*/state, which is the actual state of the lid. So y=
ou no
longer have to count events for lid :-) When the event lid happens, just =
ask the
state ....

	It's done by acpi_evaluate_integer( "_LID" ). =


	This patch is for acpi-20021205 for 2.4.20. It should be applied in
drivers/acpi dir.
It modifies only acpi_drivers.h & button.c. =


	Don't know, if it is linux-like coded, so somebody should take a look at=
=2E

	By
		Zdenek OGAR Skalak

-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557
--------------1E380A4B8BDC0987A4747EF0
Content-Type: text/plain; charset=iso-8859-2;
 name="acpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.diff"

diff -r -c original/acpi_drivers.h new/acpi_drivers.h
*** original/acpi_drivers.h	Mon Dec  9 15:01:10 2002
--- new/acpi_drivers.h	Wed Dec 18 14:12:46 2002
***************
*** 86,91 ****
--- 86,92 ----
  #define ACPI_BUTTON_DRIVER_NAME		"ACPI Button Driver"
  #define ACPI_BUTTON_CLASS		"button"
  #define ACPI_BUTTON_FILE_INFO		"info"
+ #define ACPI_BUTTON_FILE_STATE		"state"
  #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
  #define ACPI_BUTTON_NOTIFY_STATUS	0x80
  
diff -r -c original/button.c new/button.c
*** original/button.c	Mon Dec  9 11:13:45 2002
--- new/button.c	Thu Dec 19 08:17:35 2002
***************
*** 102,107 ****
--- 102,145 ----
  	return_VALUE(len);
  }
  
+ static int
+ acpi_button_lid_read_state(
+ 	char			*page,
+ 	char			**start,
+ 	off_t			off,
+ 	int 			count,
+ 	int 			*eof,
+ 	void			*data)
+ {
+ 	struct acpi_button	*button = (struct acpi_button *) data;
+ 	char			*p = page;
+ 	int			len = 0;
+ 	acpi_status		status=AE_OK;
+ 	unsigned long		state;
+ 
+ 	ACPI_FUNCTION_TRACE("acpi_button_lid_read_state");
+ 
+ 	if (!button || !button->device)
+ 		goto end;
+ 
+ 	status=acpi_evaluate_integer(button->handle,"_LID",NULL,&state);
+ 	if (ACPI_FAILURE(status)){
+ 	    p += sprintf(p, "state:      unsupported\n");
+ 	}
+ 	else{
+ 	    p += sprintf(p, "state:      %lu\n",state); 
+ 	}
+ 
+ end:
+ 	len = (p - page);
+ 	if (len <= off+count) *eof = 1;
+ 	*start = page + off;
+ 	len -= off;
+ 	if (len>count) len = count;
+ 	if (len<0) len = 0;
+ 
+ 	return_VALUE(len);
+ }
  
  static int
  acpi_button_add_fs (
***************
*** 148,153 ****
--- 186,205 ----
  	else {
  		entry->read_proc = acpi_button_read_info;
  		entry->data = acpi_driver_data(device);
+ 	}
+ 	
+ 	if (button->type==ACPI_BUTTON_TYPE_LID){
+ 	    /* 'state' [R] */
+ 	    entry = create_proc_entry(ACPI_BUTTON_FILE_STATE,
+ 			S_IRUGO, acpi_device_dir(device));
+ 	    if (!entry)
+ 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+ 			  "Unable to create '%s' fs entry\n",
+ 			   ACPI_BUTTON_FILE_STATE));
+ 	    else {
+ 		entry->read_proc = acpi_button_lid_read_state;
+ 		entry->data = acpi_driver_data(device);
+ 	    }
  	}
  
  	return_VALUE(0);

--------------1E380A4B8BDC0987A4747EF0--



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
