From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Mon, 18 Oct 2004 15:40:14 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF2B7B5756.848C0EAB-ON49256F31.002252A6-49256F31.0024011A@jp.ibm.com>
References: <20041017231258.1ec99146.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041017231258.1ec99146.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org





>No, doesn't seem to be my situation... reboot still occurs.

>> Ouch and also try what happens if you do
>>
>>           pushl %eax
>>           popl %eax
>>
>> before
>>
>>           pushl $0
>>           popfl

>i added
>            pushl %eax
>            popl %eax
>            hole: jmp hole
>and it doesn't fall in the loop, but reboots.

Piali,

You are so unlucky. Your PC's BIOS may jump into the wakeup entry without
complete real mode initialization.
Please try this code at the top of entry.

      movl  %cr0, %eax
      andl  $0xfffffff0, %eax # TS/EM/MP bit off
      movl  %eax, %cr0

Grazie, Hiro.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
