From: Vittorio Ballestra <vittorio.ballestra-w/p7aty22Lb1OrHgBX/NsA@public.gmane.org>
Subject: Am I burning my Compaq 700EA ?
Date: Tue, 17 Dec 2002 18:04:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212171804.10322.vittorio.ballestra@infogestnet.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

I'm running linux 2.4.20- acpi 20021205. 

First : 
	dmesg outputs the following warning :

	Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has known ACPI BIOS 	
problem.

	Someone knows where to find more information about this ?(don't send me to 	
compaq support site pleaz)

Second: 
	/proc/acpi/thermal_zone is there but empty. Is it Ok ?  If not someone knows 	
how to fix it ? (I'm a bit worried 'bout this).

Third: 
	acpid is not working (I've not applied the apcpid.patch, thought it was 	
integrated ...). Is this a real problem or the only side-effect is that power 
button will not work ?






-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
