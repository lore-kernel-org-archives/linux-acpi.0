From: "Bernard Normier" <bernard-jCTGDdqZGLzlLTHTg0CpQwC/G2K4zDHf@public.gmane.org>
Subject: Re: ACPI on Intel SE7501WV2
Date: Sat, 9 Oct 2004 22:55:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001301c4ae74$94034c60$6400a8c0@centrino>
References: <028c01c4ae3e$938440e0$6400a8c0@centrino> <1097367827.6128.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Sad, 2004-10-09 at 21:28, Bernard Normier wrote:
>> - with USB enabled in the BIOS, dmesg shows:
>
> SE7xxx boxes are in general hopeless cases. Turn off USB legacy in the
> BIOS and you might get a working box. You may also need acpi=off and/or
> bios updates or some random combination thereof.

I tried to disable USB legacy support in the BIOS, but it did not make any 
difference.
USB support is not important for me, so I'd rather switch off USB and keep 
ACPI for hyper-threading.

Any suggestion for the other warnings?

Thanks,
Bernard



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
