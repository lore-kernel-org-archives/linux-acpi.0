From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Hibernate to LVM
Date: Sat, 15 Jan 2005 18:45:55 +0800
Message-ID: <20050115104555.GF4429@blackham.com.au>
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

On Thu, Jan 13, 2005 at 01:41:35PM -0800, Donald W Watson wrote:
> I have seen no discussion of the following in the archives. Hibernate (S4) does
> not work if the swap partition is on an LVM Logical Volume.
[...]
> Are these deliberate design decisions?

The in-kernel swsusp can not be built as a module. As a consequence,
it will always try to resume before an initrd/initramfs has been
executed. LVM setup (AFAIK) generally takes place in an initrd, or
off a separate boot partition once the kernel has booted. Hence,
impossible.

On the other hand, Software Suspend 2 should support it:
http://softwaresuspend.berlios.de/ - it'll need a bit of tweaking of
your initrd to tell it when to resume though.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
