From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Date: Sun, 6 Feb 2005 20:46:39 +0100
Message-ID: <20050206194639.GH18245@wotan.suse.de>
References: <20050206184447.GW3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206184447.GW3129-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 06, 2005 at 07:44:47PM +0100, Adrian Bunk wrote:
> acpi_save_state_disk does nothing and is completely unused.
> 
> This patch was already ACK'ed by Pavel Machek.

Since it affects both i386 and x86-64 it should be pushed by the ACPI
people. However it's no bugfix and so definitely nothing for 2.6.11,
so it'll take quite some time anyways.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
