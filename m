From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: ACPI AC driver doesn't work on Toshiba Portege R500 (bisected)
Date: Mon, 24 Nov 2008 14:30:01 +0100
Message-ID: <200811241430.02434.rjw@sisk.pl>
References: <200811230053.14211.rjw@sisk.pl> <200811240221.54716.rjw@sisk.pl> <1227490280.15014.291.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41803 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbYKXNaQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Nov 2008 08:30:16 -0500
In-Reply-To: <1227490280.15014.291.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, walken <walken@zoy.org>

On Monday, 24 of November 2008, Zhang Rui wrote:
> On Mon, 2008-11-24 at 09:21 +0800, Rafael J. Wysocki wrote:
> > On Monday, 24 of November 2008, Zhao Yakui wrote:
> > > On Mon, 2008-11-24 at 07:37 +0800, Rafael J. Wysocki wrote:
> > > > On Sunday, 23 of November 2008, Rafael J. Wysocki wrote:
> > > > > Hi,
> > > > > 
> > > > > With current mainline (2.6.28-rc6-git1 as of today) on Toshiba Portege R500 the
> > > > > status of the AC adapter is not updated when the adapter is unplugged and
> > > > > plugged in.  Evidently, /sys/class/power_supply/ADP1/online always contains the
> > > > > same value.  Interestingly enough, though, if the box is suspended to RAM and
> > > > > resumed, the status of the AC adapter is correctly updated, but the value read
> > > > > at that time remains in /sys/class/power_supply/ADP1/online until the next
> > > > > suspend/resume cycle regardless of what's going on with the AC adapter.
> > > > > 
> > > > > 2.6.27.7 works correctly on this box so the recent EC patches don't seem to
> > > > > cause this regression to happen.
> > > > > 
> > > > > Any other ideas?
> > > Hi, Rafael
> > >     Will you please open a new bug at
> > > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
> > > output of acpidump, dmesg, lspci -vxxx?
> > >     If no ACPI event is reported when AC adapter is unplugged and
> > > plugged, the /sys/class interface can't display the correct AC status.
> > > Now Rui is working on this issue and the patch is already finished. But
> > > it is not sent to Lenb.
> > 
> > Can you give me a link to the patch, please?

Thanks.

Still, it doesn't seem to be related to the problem at hand.

> From: Zhang Rui <rui.zhang@intel.com>
> Subject: power_supply: update ac status before acquiring it.
> 
> Update AC status in sysfs I/F.
> http://bugzilla.kernel.org/show_bug.cgi?id=12035
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ac.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/ac.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/ac.c
> +++ linux-2.6/drivers/acpi/ac.c
> @@ -87,6 +87,7 @@ struct acpi_ac {
>  	unsigned long long state;
>  };
>  
> +static int acpi_ac_get_state(struct acpi_ac *ac);
>  #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
>  
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> @@ -103,15 +104,18 @@ static int get_ac_property(struct power_
>  			   enum power_supply_property psp,
>  			   union power_supply_propval *val)
>  {
> +	int result;
>  	struct acpi_ac *ac = to_acpi_ac(psy);
> +
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
> +		result = acpi_ac_get_state(ac);
>  		val->intval = ac->state;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -	return 0;
> +	return result;
>  }
>  
>  static enum power_supply_property ac_props[] = {
> 
> >  
> > >     From the problem description it seems that the problem is related
> > > with the AC driver. But from the git-bisect it seems that the problem is
> > > related with the button driver(Fix power button device). 
> > > 
> > >     Any-way, please attach the output of dmesg, acpidump, lspci -vxxx.
> > 
> > Created http://bugzilla.kernel.org/show_bug.cgi?id=12091 with the information
> > attached as requested.
> > 
> I'll take this bug. :)

Thanks again.

Do I understand correctly that you intend to revert commit
faee816b1502385dc9bc5abf2960d1cc645844d1 and provide an alternative patch
for walken?

Rafael
