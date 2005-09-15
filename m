From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fan driver suspend/resume issues
Date: Thu, 15 Sep 2005 08:49:02 -0600
Message-ID: <200509150849.02558.bjorn.helgaas@hp.com>
References: <E1EFrCU-0002lM-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1EFrCU-0002lM-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 15 September 2005 4:42 am, Miklos Szeredi wrote:
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

Interesting.  I've gotten burned (literally) the last few times
I've used my HP OB500.  I was worrying about something else, so
didn't think much about it.  But now that you mention it, the
fan wasn't running, so maybe it's related.

Last night, it crashed in the middle of a big Debian update,
and the bootloader config got screwed up.  When it's bootable
again, I'll play with the fan config.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
