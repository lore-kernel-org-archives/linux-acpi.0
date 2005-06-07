From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Receiving ACPI notifications generically
Date: Tue, 7 Jun 2005 14:38:33 +0800
Message-ID: <20050607063833.GA3483@linux.sh.intel.com>
References: <1117972742.6648.122.camel@tyrosine> <20050606155913.GB5067@linux.sh.intel.com> <1118074038.6648.191.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1118074038.6648.191.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2005.06.07 00:07:18 +0800, Matthew Garrett wrote:
> 
>    On Mon, 2005-06-06 at 23:59 +0800, Yu, Luming wrote:
>    > Please send me output of acpidmp, then I can show you an example how
>    to configure generic-hotkey-driver for this case. BTW, we need to add
>    battery-hotplug code to respond this event.

Huh, is this ide-bay-hotplug?

>    I'm afraid I don't have the machine to hand (and so can't send a full
>    acpidmp), but here's the DSDT:

Try this:

echo "0:\\_SB.PCI0.IDE0.SECN.BAY1::\\_SB.PCI0.IDE0.SECN.BAY1::1:1" > event_config 

>    --
>    Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
