From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Hibernate to LVM
Date: Thu, 20 Jan 2005 14:38:32 +0100
Message-ID: <20050120133832.GF476@openzaurus.ucw.cz>
References: <OF97651F7F.22151B8B-ON87256F88.0076CB20-88256F88.00772C98@us.ibm.com> <20050115104555.GF4429@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050115104555.GF4429-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Donald W Watson <dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I have seen no discussion of the following in the archives. Hibernate (S4) does
> > not work if the swap partition is on an LVM Logical Volume.
> [...]
> > Are these deliberate design decisions?
> 
> The in-kernel swsusp can not be built as a module. As a consequence,
> it will always try to resume before an initrd/initramfs has been
> executed. LVM setup (AFAIK) generally takes place in an initrd, or
> off a separate boot partition once the kernel has booted. Hence,
> impossible.

Actually, I think I took a patch that enables you to trigger resume from userland.
Check /sys/power in 2.6.11rc1.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
