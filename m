From: mikel <mikel1-rdc5FV7LBygPGFelY5Zqew@public.gmane.org>
Subject: how to re-enable acpi
Date: Fri, 1 Jul 2005 19:39:01 +1000
Message-ID: <20057119391.269331@p3200>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


sorry if this has been asked before I do try to follow the list.  
My friend had to disable ACPI via the option acpi=3Doff

We had to do this because the USB storage devices were hanging the kernel=
 during the boot process which again seemed to be related to BIOS.  In=
 otherwords if we had "usb storage devices" the kernel thinks they are=
 bootable devices (even though they have no actual media in them) and the=
 result is a HANG.  For some reason disabling ACPI via the above mentioned=
 argument worked around the problem.

the question is. If / Once we "disable" acpi via the "acpi=3Doff" option is=
 there a way to re-enable it at a later point ? He wants/likes ACPI but we=
 don't know how to re-enable once we have disabled this. Also should we try=
 to fix the crux of this.. I mean is it related to DSDT issues? 
thanks.. and sorry for my english I speak american as my native language :)

mikel



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
