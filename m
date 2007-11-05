From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PATCH] thinkpad-acpi patches for 2.6.24-rc
Date: Mon, 5 Nov 2007 14:32:27 -0500
Message-ID: <200711051432.27840.lenb@kernel.org>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193773585-17202-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I agree that these look post1rc1 worthy,
lets see if the boss thinks so too.

applied.

thanks,
-Len

On Tuesday 30 October 2007 15:46, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Here is a bunch of thinkpad-acpi changes that fixes some bugs and add key
> thinkpad models support that should, if at all possible, be merged for
> 2.6.24.
> 
> They are really important for ThinkPad X60, T61 and R61 users, and the
> first patch unbreaks the ThinkPad ACPI hotkey map in all IBM ThinkPads on
> several distros.
> 
> Please consider sending this patch set to Linus for merging after -rc2 is
> out.
> 
> All patches in it have been tested, and all comments the individual patches
> received (some of them are not new) have been addressed.
> 
> As usual, the patch set is available at:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release
> 
> Shortlog of the above branch:
> 
> Henrique de Moraes Holschuh (7):
>       ACPI: thinkpad-acpi: revert keymap changes
>       ACPI: thinkpad-acpi: support 16 levels of brightness (v3)
>       ACPI: thinkpad-acpi: add brightness_force parameter
>       ACPI: thinkpad-acpi: prefer standard ACPI backlight level control
>       ACPI: thinkpad-acpi: bump up version to 0.17
>       ACPI: thinkpad-acpi: allow for syscall restart in sysfs handlers
>       ACPI: thinkpad-acpi: fix brightness_set error paths
> 
> Thanks.
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
