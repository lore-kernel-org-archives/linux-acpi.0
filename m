From: "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
Subject: RE: Query regarding the linux ACPI
Date: Tue, 17 Jun 2003 20:25:11 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <004401c334c3$1dce6b00$b8d21b2b@ADACHIPC>
References: <09c601c334bb$d91226c0$2a0806c0@wiproxcoio3398>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <09c601c334bb$d91226c0$2a0806c0-mtNSFjsC3/e12yEdTghClg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'siva' <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>, 'Derek Broughton' <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> That means this option can be programmed in the BIOS and we
> can have it as
> option in the BIOS.
> Am I right ?
>

Power button override is done at hardware level as Derek pointed out and
what you have to look into is the Datasheet of your chipset. 

For example, ICH4 Datasheet says:

  2.10 Power Management Interface
  Table 2-10. Power Management Interface Signals

  <Quote>
  PWRBTN#
      :
  If PWRBTN# is pressed for more than 4 seconds, this causes an
unconditional transition (power button override) to the S5 state with
only the PWRBTN# available as a wake event. Override occurs even if the
system is in the S1-S4 states. This signal has an internal pull-up
resistor.
  </Quote>

Thanks,
- Adachi, Kenichi 



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
