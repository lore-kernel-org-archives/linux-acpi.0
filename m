From: Emmanuel Fleury <fleury-t5LvXY1cjzpaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Wed, 16 Feb 2005 20:12:44 +0100
Message-ID: <42139B2C.6040709@cs.aau.dk>
References: <20050210161809.GK3493@crusoe.alcove-fr> <20050211113636.GI3263@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050211113636.GI3263-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stelian Pop wrote:
> Based on feedback from Jean Delvare and Pekka Enberg, here is an
> updated version.
> 
> Changes from the previous version include:
> - do not initialize to 0 a static variable
> - trim to 80 columns
> - do not do spurious void * casts
> - use c99 style struct initialization
> - use simple_strtoul instead of sscanf
> - move documentation to new directory Documentation/acpi
> - name the file 'brightness' instead of 'brt'

Works straight for me (on a Vaio PCG-C1MZX), I can adjust brightness by
feeding the proc/ interface.

I have to try the debug mode.

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury-t5LvXY1cjzpaa/9Udqfwiw@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
