From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: ACPI using smp_processor_id in preemptible code
Date: Sun, 9 Jan 2005 22:10:42 +0100
Message-ID: <20050109211042.GA1196@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I enabled CPU hotplug and preemptible debugging... now I get...

BUG: using smp_processor_id() in preemptible [00000001] code:
swapper/0
caller is acpi_processor_idle+0xb/0x235
 [<c020ba28>] smp_processor_id+0xa8/0xc0
 [<c02338ce>] acpi_processor_idle+0xb/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338ce>] acpi_processor_idle+0xb/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c0101115>] cpu_idle+0x75/0x110
 [<c04f5988>] start_kernel+0x158/0x180
 [<c04f5390>] unknown_bootoption+0x0/0x1e0

...in logs.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
