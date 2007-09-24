From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 8/9] ACPI: thinkpad-acpi: use a
 separate platform device for hwmon and name it
Date: Mon, 24 Sep 2007 18:43:28 +0200
Message-ID: <20070924184328.74bfbb9e@hyperion.delvare>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
	<11905574583315-git-send-email-hmh@hmh.eng.br>
	<20070924171128.19f91009@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070924171128.19f91009-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: LM-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org, Sensors ML <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 24 Sep 2007 17:11:28 +0200, Jean Delvare wrote:
> On Sun, 23 Sep 2007 11:24:16 -0300, Henrique de Moraes Holschuh wrote:
> > +	tpacpi_sensors_pdev = platform_device_register_simple(
> > +							IBM_HWMON_DRVR_NAME,
> > +							-1, NULL, 0);
> 
> As explained before, libsensors won't pick this device. You'd need to
> give it an id of 0 instead of -1. Hmm, I'll see if I can hack something
> in libsensors4 until that part of the code is reimplemented in a better
> way.

OK, it's fixed in libsensors4 now, the above code will work OK, no need
to change it.

-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
