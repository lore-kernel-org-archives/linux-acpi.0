From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Laptop powers off randomly
Date: Wed, 25 May 2005 15:17:59 +0200
Message-ID: <20050525131759.GB1960@elf.ucw.cz>
References: <4291C7E4.3030809@fcaglp.unlp.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4291C7E4.3030809-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fabio Zyserman <zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am a new to this list, I apollogize if my
> question has been already answered.
> 
> I have a Toshiba Satellite A60 laptop since some days ago,
> with kernel 2.6.10, with acpi enabled; kernel configuration looks
> like this:
> 
> CONFIG_TOSHIBA=y
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> # CONFIG_ACPI_SLEEP is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> CONFIG_ACPI_TOSHIBA=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> 
> While using the computer, it powers off randomly.
> That means, using battery (and fully charged) or being plugged in,
> with X11 activated or not.
> I don't know if this information is useful, but it's the
> almost the only one I am able to give!

Try monitoring system temperature in /proc/acpi.. if it overheats that
might be a problem.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
