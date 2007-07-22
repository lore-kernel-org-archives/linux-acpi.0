From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] thinkpad-acpi queue for 2.6.23 (v3)
Date: Sat, 21 Jul 2007 23:52:47 -0400
Message-ID: <200707212352.47747.lenb@kernel.org>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11848131483573-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Applied.

thanks,
-Len

On Wednesday 18 July 2007 22:45, Henrique de Moraes Holschuh wrote:
> 
> Len,
> 
> Please pull from:                                                                                                                                     
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test                                                                     
> 
> to receive the main batch of thinkpad-acpi changes for the merge window, now
> rebased to apply on top of v2.6.22, with changes based on the comments I
> received when I posted v2 of this queue.
> 
> It replaces all the other patches I sent you (none were merged yet, AFAIK).
> 
> Henrique de Moraes Holschuh (23):
>       ACPI: thinkpad-acpi: add DMI-based modalias
>       ACPI: thinkpad-acpi: remove all uneeded initializers
>       ACPI: thinkpad-acpi: update information on T43 thermal sensor 0xc1
>       ACPI: thinkpad-acpi: enable more hotkeys
>       ACPI: thinkpad-acpi: export hotkey maximum masks
>       ACPI: thinkpad-acpi: export to sysfs the state of the radio slider switch
>       ACPI: thinkpad-acpi: checkpoint sysfs interface version due to hotkey
>       ACPI: thinkpad-acpi: update CMOS commands documentation
>       ACPI: thinkpad-acpi: register input device
>       ACPI: thinkpad-acpi: add input device support to hotkey subdriver
>       ACPI: thinkpad-acpi: make the input event mode the default
>       ACPI: thinkpad-acpi: add power-management handler capability
>       ACPI: thinkpad-acpi: export EV_SW SW_RADIO events
>       ACPI: thinkpad-acpi: checkpoint sysfs interface version due to input layer
>       ACPI: thinkpad-acpi: rename pci HID constant
>       ACPI: thinkpad_acpi: use bool for boolean parameters
>       ACPI: thinkpad-acpi: store ThinkPad model information
>       ACPI: thinkpad-acpi: allow use of CMOS NVRAM for brightness control
>       ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
>       ACPI: thinkpad-acpi: make sure DSDT TMPx readings don't return +128
>       ACPI: thinkpad-acpi: make EC-based thermal readings non-experimental
>       ACPI: thinkpad-acpi: bump up version to 0.15
>       ACPI: thinkpad-acpi: add locking to brightness subdriver
> 
> These changes are composed mainly of the first part of the effort to move all
> the hot keys functionality to the input layer, plus some fixes.
> 
> All these patches are targetted to 2.6.23's merge window.  Please merge for
> acpi-test.
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
