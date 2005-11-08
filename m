From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Tue, 8 Nov 2005 10:11:44 +0100
Message-ID: <20051108091144.GD15730@elf.ucw.cz>
References: <971FCB6690CD0E4898387DBF7552B90E0356BAE2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0356BAE2-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Please don't top post.

> Just out of curiosity, what issues do you find with the coding
> style?

I hope that means you want to clean it up and apply it ;-).

+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#define DBG(x...) printk(x)

Include in the middle of file? Renaming of printk to confuse reader?

+       int i, tmp;
+       acpi_integer addr;
...
+       addr = i;

...oops, something is very wrong in acpi land.

+#define GTM_LEN (sizeof(u32) * 5)
...
+       u32     gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */

Eh? Better names would be nice, too.

+       for (i = 0; i < MAX_DEVICES; i ++)

Please no space between i and ++.

+static struct acpi_ide_stat *ide_get_acpi_state(acpi_handle handle)

The function is strange, btw. Linear search, and it basically returns
pointer to zeros. I'd expect zeroing to be in caller or something like that.

+int acpi_ide_suspend(struct device *dev)
+{
+       acpi_handle handle, parent_handle;
+       struct acpi_ide_stat *stat;
+       acpi_status     status;

At least alignment should be consistent locally.

+static int acpi_ide_gtf(acpi_handle handle, ide_drive_t *drive)
+{
+       struct acpi_buffer      output = {ACPI_ALLOCATE_BUFFER, NULL};
+       ide_task_t      args;
+       int index = 0;
+       unsigned char *data;
+       union acpi_object       *package = NULL;
+       acpi_status status;

...even more horible example of above.

+               /* submit command request */
+//             printk("return value %d\n", ide_raw_taskfile(drive, &args, NULL));
+               index += 7;

Someone should learn to use delete key and version control...

+       if (stat->channel_handled == 0) {
+               stat->handle = NULL;
+               goto gtf;
+       }
+DBG("Start STM\n");
+       if (acpi_ide_stm(stat))
+               return -ENODEV;
+       stat->channel_handled = 0;
+gtf:
+       return acpi_ide_gtf(handle, drive);
+}

What about "else" instead of ugly goto. And that DBG should really go
away.

-
+#ifdef CONFIG_ACPI
+       acpi_ide_suspend(dev);
+#endif

-
+#ifdef CONFIG_ACPI
+       acpi_ide_resume(dev);
+#endif
        memset(&rq, 0, sizeof(rq));
        memset(&rqpm, 0, sizeof(rqpm));
        memset(&args, 0, sizeof(args));

We normally allways provide acpi_ide_resume, but make them nop in
!ACPI case. That means #ifdefs are avoided in callers.

...should be enough...
							Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
