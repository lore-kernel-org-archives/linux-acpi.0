From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: AW: compile problem
Date: Mon, 26 May 2003 15:13:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F12ECCD@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Are you really using MTD Devices (i.e. Flash Devices)?=20
I doubt it. Ignore these errors.

Ciao, Herbert.

-----Urspr=FCngliche Nachricht-----
Von: sjb [mailto:ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org]
Gesendet: Montag, 26. Mai 2003 11:45
An: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Betreff: [ACPI] compile problem


Apologies for this not being a strictly ACPI problem.

I'm trying to compile an ACPI enabled kernel for my Vaio. I've tried=20
numerous combinations of kernel sources and patches as per the pointers=20
from members of this list.

However, I always get this error during "make modules_install"

Not being a seasoned kernel builder, I really don't know what's wrong=20
and I was wondering if anybody here can tell me what's up.

TIA

sjb

cd /lib/modules/2.4.20; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} =
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.20; fi
depmod: *** Unresolved symbols in=20
/lib/modules/2.4.20/kernel/drivers/mtd/maps/sc520cdp.o
depmod:         mtd_concat_create_R606fc87b
depmod:         mtd_concat_destroy_R9c645004
depmod: *** Unresolved symbols in=20
/lib/modules/2.4.20/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
