From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Mon, 8 Nov 2004 17:45:13 +0100
Message-ID: <20041108164512.GB14497@hell.org.pl>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome> <Pine.LNX.4.60.0411041729180.4727@frog.athome> <200411041812.54813.christian.hesse@linuxob.de> <200411072052.53065.mail@earthworm.de> <Pine.LNX.4.60.0411081640410.4713@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411081640410.4713-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Christian Hesse <mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org:
> I am verry impressed. I had a try myself today and did not succeed. Then I 
> took a look at the driver (6629 -> nv.c) and discovered, that they removed 
> all ACPI support, which was in 6111. So your once success with 6629 is a 

Which was outright bogus...

> little miracle. But maybe ACPI is not allways needed :-))))

... because there's only one PM interface in 2.6 and it's not really
ACPI-specific. The driver might even work as expected now.
Note: I haven't seen the new code yet.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
