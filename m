From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 4/4] acpi: create_polling_proc() fix
Date: 30 Mar 2005 22:56:47 -0500
Message-ID: <1112241407.2173.72.camel@d845pe>
References: <200503302116.j2ULGeuq027736@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503302116.j2ULGeuq027736-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-03-30 at 16:16, akpm-3NddpPZAyC0@public.gmane.org wrote:
> 
> drivers/acpi/hotkey.c: In function `create_polling_proc':
> drivers/acpi/hotkey.c:334: warning: ISO C90 forbids mixed declarations
> and code
> 
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/hotkey.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/hotkey.c~acpi-create_polling_proc-fix
> drivers/acpi/hotkey.c
> --- 25/drivers/acpi/hotkey.c~acpi-create_polling_proc-fix       Wed
> Mar 30 13:16:09 2005
> +++ 25-akpm/drivers/acpi/hotkey.c       Wed Mar 30 13:16:09 2005
> @@ -329,9 +329,10 @@ static int auto_hotkey_remove(struct acp
>  static int create_polling_proc(union acpi_hotkey *device)
>  {
>         struct proc_dir_entry *proc;
> +       mode_t mode;
> 
>         ACPI_FUNCTION_TRACE("create_polling_proc");
> -       mode_t mode = S_IFREG | S_IRUGO | S_IWUGO;
> +       mode = S_IFREG | S_IRUGO | S_IWUGO;
> 
>         proc = create_proc_entry(device->poll_hotkey.action_method,
>                                  mode, hotkey_proc_dir);
> _
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
