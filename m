From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 04 Nov 2004 13:14:00 +0100
Message-ID: <yzooeid4xrr.fsf@cern.ch>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com> <20041103155217.GH24195@wotan.suse.de>
 <yzosm7q97q2.fsf@cern.ch> <20041103172120.GB18092@wotan.suse.de>
 <yzo654mowci.fsf@cern.ch> <20041104090233.GD28895@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

>> There is absolutely no guarantee that the machine comes "fresh out of
>> suspend"! Here is my recollection of what the ACPI specs says: The

Andi> I don't see who should cause busmaster in flight operations
Andi> before suspend wakeup.

I'm supposing non-initialized hardware could physically hang on the
bus master request line.

Ole



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
