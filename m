From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 4/5] x86/tboot: Fail extended mode
 reduced hardware sleep
Date: Fri, 28 Jun 2013 12:05:13 -0400
Message-ID: <20130628160513.GC13468@phenom.dumpdata.com>
References: <1372427184-6197-1-git-send-email-benjamin.guthro@citrix.com>
	<1372427184-6197-5-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1372427184-6197-5-git-send-email-benjamin.guthro@citrix.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: Ben Guthro <benjamin.guthro@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, "Rafael J . Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net, Jan Beulich <jbeulich@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 28, 2013 at 09:46:23AM -0400, Ben Guthro wrote:
> As tboot currently does not support the reduced hardware sleep
> interface, fail this extended call.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
> Cc: tboot-devel@lists.sourceforge.net
> Cc: Gang Wei <gang.wei@intel.com>
> ---
>  arch/x86/kernel/tboot.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index d578c9c..57383b2 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -285,6 +285,9 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
>  	if (!tboot_enabled())
>  		return 0;
>  
> +	if (extended)
> +		return -1;

I would add WARN_ON just so that the user is aware of.
Perhaps

	if (WARN(extended,"tboot is not able to suspend on ACPI extended platforms. Contact
tboot-something mailing list please."))
		return -1

Otherwise
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> +
>  	tboot_copy_fadt(&acpi_gbl_FADT);
>  	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
>  	tboot->acpi_sinfo.pm1b_cnt_val = pm1b_control;
> -- 
> 1.7.9.5
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
