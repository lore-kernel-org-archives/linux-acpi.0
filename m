From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 3 Jan 2005 14:45:21 +0100
Message-ID: <20050103134521.GP19199@poupinou.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2acrth375.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 01, 2005 at 11:08:14AM +0100, Johan Vromans wrote:
> Happy New Year to y'all!
> 
> Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org> writes:
> 
> > corcovado:/usr/src/smartbatt# ./smartbattery
> > Error: No i2c-bus specified!
> > Syntax: smartbatt I2CBUS
> >   Installed I2C busses:
> >     i2c-1       unknown         ACPI EC SMBus adapter at 0018
> > Algorithm unavailable
> >     i2c-0       unknown         SMBus I801 adapter at 1880
> > Algorithm unavailable
> 
> I only have one bus i2c-0 (ACPI EC SMBus adapter at 0018) here.
> 
> > corcovado:/usr/src/smartbatt# ./smartbattery  1
> > current:       65535 mA
> > remain:        65535 mA or mWh
> > time to empty: 65535 minutes
> > time to full:  65535 minutes
> > temperature:   6280.5 C
> > voltage:       65535 mV
> 
> Same here (with bus 0).
> I also get a lot of spinlock errors in my system log.
> 

Could you post those errors?

Thanks,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
