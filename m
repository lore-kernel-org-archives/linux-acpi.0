From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Thinkpads running hot
Date: Sun, 21 Aug 2005 17:55:18 +0200
Message-ID: <4308A3E6.7080002@suse.de>
References: <43077C3C.5030501@suse.de> <43083B55.4000700@xms.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43083B55.4000700-7RBX4Gk6oWI@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jonas Petersson wrote:
> Hi Thomas,
> 
> Thomas Renninger wrote:
>>I got several reports of Thinkpads shutting down due critical temp limit.
>>Here are some more:
>>[...]
>>Still when the processor is on load the critical temperature is reached quickly
>>(1-3 minutes?).
>>
>>Thinkpads are widespread and I wonder whether others have experienced that problem
>>and whether it only exists on current kernels or got it solved somehow.
> 
> Have these Thinkpads been in use for a while? My 1.5 year old ASUS would
> occasionally turn off like that and initially I assumed it was either a
> bug or my hardware being close to death. However, when I pulled it apart
> I found that the way out from the fans were partially blocked by a layer
> of dust.  After I cleaned that out it runs ~20 degrees cooler which
> seems to solve the problem (and it is less noisy too).
> 
No. The fans are clean. I also heard about this and it is the first thing
I asked. Those machines are even too new to have a dirty fan.

There seem to exist Thinkpad models (T42p, 53e, ...) that do not have a
perfekt thermal design (Or Pentium Ms are now also hitting their heat prod.
limit).

The graphics card tuning seems to help a bit (another report):
________________________
Ok, I tried now Option "DynamicClocks" "on".

Where there is no significant change when the system is idle it seems that
applications with high graphics activity no longer trigger the alert.
________________________

Still the critical trip point can be reached on permanent high load.
I expect that these reports are also poping up lately because of this
embedded controller firmware update:
_______________
Symptom corrected by version 3.03 - 1RHT70WW
Reduced Fan noise in some models
_______________

But even I could find the EC address and value to set the fan on full speed
(echo 0x2f 0x50 >/proc/acpi/ibm/ecdump - with ibm_acpi module)
(>5000 instead of ~3700 rpm) , the machine still run very hot.

However, when passive cooling works well, people shouldn't notice much.
It seems as if these machines are designed to work with OS thermal management.
The userspace governor works nicely and temperature stays at passive trip point
with 1200 instead of 1700 MHz (even on 70 C passive tp limit it stays at 1200 MHz
poking around 70 C - default is 92 C).

The ondemand govenor and I also expect the conservative governor do not consider
thermal limits yet, but this should be fixed soon and those critcal alert reports
will disappear.


     Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
