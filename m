From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Hibernate to LVM
Date: Thu, 20 Jan 2005 14:36:43 +0100
Message-ID: <20050120133643.GE476@openzaurus.ucw.cz>
References: <OF97651F7F.22151B8B-ON87256F88.0076CB20-88256F88.00772C98@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OF97651F7F.22151B8B-ON87256F88.0076CB20-88256F88.00772C98-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Donald W Watson <dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am using the 2.6.10 kernel (linux-2.6.9.tar.bz2 with patch 2.6.10.bz2) on
> an older IBM ThinkPad (T20 booted with acpi=force).
> 
> I have seen no discussion of the following in the archives.  Hibernate (S4)
> does not work if the swap partition is on an LVM Logical Volume.  The
> reason is that try_name (init/do_mounts.c) is unable to find the partition
> in /sys/block.

Well, I'd say that this is currently unsupported.

> Further, if a second swap partition is established on a regular partition
> and referenced in the "resume" state in menu.lst, hibernate appears to
> succeed, but on resume check_sig (kernel/power.swsusp.c) complains because
> the swsusp_header signature is "SWAPSPACE2" rather than the hard-coded
> "S1SUSPEND" which it expects.

...but this one should be fixed. suspend should only write to partition
you specified with resume= parameter. If that is not the case, feel free to fix
it and send me a patch.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
