From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: 2.6.9-rc4 ACPI problem after starting X
Date: Fri, 15 Oct 2004 00:36:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041014223607.GA9549@message-id.gmane0305.slipkontur.de>
References: <20041013172118.0ec42975.admin@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041013172118.0ec42975.admin-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
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

On Wed, Oct 13, 2004 at 05:21:18PM +0200, Sebastian wrote:
> Hi,
> 
> After starting X (v. 4.4.0) I'm getting still some strange ACPI errors in dmesg.
> 
>  dswload-0292: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
>  psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c1474f28), AE_ALREADY_EXISTS
> 
> This does not happen, when working with the console. It starts some seconds, after i started X.

i suspect this is some battery applet accessing your battery.
What windowmanager / desktop environment are you using?
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
