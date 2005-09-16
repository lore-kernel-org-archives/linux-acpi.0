From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Fan driver suspend/resume issues
Date: Fri, 16 Sep 2005 23:33:54 +0200
Message-ID: <20050916213354.GD15219@message-id.gmane0305.slipkontur.de>
References: <E1EFrCU-0002lM-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1EFrCU-0002lM-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
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

On Thu, Sep 15, 2005 at 12:42:42PM +0200, Miklos Szeredi wrote:
> It seems that the ACPI fan driver lacks suspend/resume support, which
> causes problems on some laptops (e.g HP nc-4000, nc-8000).
> 
> But it's not just suspend.  I see more than one issue:
> 
>  1)  ACPI initializes the fans all-off.
> 
>   This is dangerous.  If fan/thermal_zone driver are not compiled into
>   the kernel or are modules or acpid is not installed (to insert the
>   modules), then the system will silently overheat.  This is not a
>   theoretical scenario, I've seen cases where sysadmin simply "forgot"
>   to install the acpid package and user was clueless about
>   overheating, and it resulted in hard disk failure.

YES.
I had problems on newer compaq HP models with SUSE pre-9.3, since during
installation the fan/thermal module was not loaded. We fixed this shortly
before 9.3 for some models by dmi-matching and loading the modules. 10.0
loads fan and thermal in the initramfs for exactly this reason.
Older models seem to control the fans by BIOS until the thermal/fan modules
are inserted, newer machine do it only until ACPI is initialized and then
leave control to the OS.
Right now this seems only to hit newer HP models, but maybe other
manufacturers will also start to implement ACPI-compliant (and ACPI-
demanding) machines.

>  2) The fan/thermal_zone modules dont turn on all fans when removed.
> 
>     Also dangerous for same reasons as above.

Yes.

>  3) Fan driver doesn't have suspend/resume support.

It is _not funny_ that ACPI is the only subsystem which has no suspend /
resume support _at all_! All the drivers, be it battery, button, fan
break randomly on various machines during suspend / resume :-(
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
