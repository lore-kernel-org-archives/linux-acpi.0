From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: type vs descriptor
Date: Sat, 15 Mar 2003 20:09:51 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030315200951.GO29631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


I'm trying to write a routine which invokes an ACPI function which takes
`0' as its parameter.  So I looked to see how it's done already, and I
think I found a bug.

Here's how it's done in battery.c:

        union acpi_object       arg0 = {ACPI_TYPE_INTEGER};
        struct acpi_object_list arg_list = {1, &arg0};
        arg0.integer.value = alarm;

        status = acpi_evaluate_object(battery->handle, "_BTP", &arg_list, NULL);

This looks wrong to me.  All the acpi_objects start with
ACPI_OBJECT_COMMON_HEADER which is:

#define ACPI_OBJECT_COMMON_HEADER   /* SIZE/ALIGNMENT: 32 bits, one ptr plus tra
iling 8-bit flag */\
        u8                                      descriptor;         /* To differ
entiate various internal objs */\
        u8                                      type;               /* acpi_obje
ct_type */\
        u16                                     reference_count;    /* For objec
t deletion management */\
        union acpi_operand_object               *next_object;       /* Objects l
inked to parent NS node */\
        u8                                      flags; \

So we're assigning ACPI_TYPE_INTEGER to descriptor, but most places we
check type against ACPI_TYPE_*, for example in scan.c:

                switch (object->type) {
                case ACPI_TYPE_INTEGER:
                        acpi_ex_eisa_id_to_string((u32) object->integer.value, 
                                cid);
                        break;
                case ACPI_TYPE_STRING:
                        strncpy(cid, object->string.pointer, sizeof(cid) - 1);
                        break;
                case ACPI_TYPE_PACKAGE:
                        /* TBD: Support CID packages */
                        break;
                }

So I think this code in battery.c should look like:

        struct acpi_object_integer arg0 = { .type = ACPI_TYPE_INTEGER,
					    .value = alarm,
					  };
        struct acpi_object_list arg_list = {1, &arg0}; 

        status = acpi_evaluate_object(battery->handle, "_BTP", &arg_list, NULL);

Comments?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
