From: "Hiroshi Itoh" <hiroit-s3IJUFpODnp4Eiagz67IpQ@public.gmane.org>
Subject: Re: Newbie question &machine don't power off with acpi
Date: Sat, 13 Nov 2004 02:28:21 +0900
Message-ID: <002901c4c8dd$02707ab0$7bbdbd09@TPHIROIT>
References: <1100279182.3190.24.camel@outfox>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Sun <outfox-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi! David-san,

>I can't recall exactly what I have done, and don't like to go backward
>to the original acpi code, any hint on how to debug acpi or what
>information I should provide to the list for further help is highly
>appreciated :)

How did you change the sources to reduce the size?
OK. If you can't recall it, how did you change any compile option to reduce
the size?
Alignment options may change ACPI method behavior unexpectedly.

And if the size permits, you may add printk for debug at the final stage of
ACPI power off after
searching "acpi_enter_sleep_state(ACPI_STATE_S5)".

- Hiro



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
