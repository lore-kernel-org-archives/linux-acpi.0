From: Robert <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Story of success
Date: Tue, 19 Nov 2002 22:53:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DDAB2C0.5050602@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi guys ....
i am watching this project now since may or march  this year and i want 
to let all know that i am now
quite satisfied with the ACPI implementation i have here .

I am using patch 20021002 with 2.4.18 + preempt + swsusp for 20020918  (!)
and i can sucessfully use acpid to sent me messages (and acpid_proxy 
handles them ) when i change from AC to battery or wise versa .
I can also use my PowerButton and see / change CPU throtteling (which 
doesent make sense for since i am using a TRANSMETA CPU)
i can use standard ( .. well patched ) KDE klaptopdaemon to get my 
battery state ....and have a look at the temparature my Crusou is 
swetting ..:-)

The only thing i ve to do is :
Ive to boot using lilo and give mem= XXXM as kernel parameter otherwise 
i get a AE_NOMEMORY error with ACPI
I think this is because Linux doesnt notice ( or the BIOS doenst 
correctly tell ) that the transmeta takes approx 16MB of my onboard RAM 
for his CodeMorphing(c) thing ...
ask me , but it is strange that a OS from "a" guy who is working for a 
CPU manufacturer doesnt get together ... anyhow

I am really looking forward to the day when i will have S3 running and 
also can use S4  ... well i have the swsusp patch and i can 
supend/restore many times , but
a little important app which i  use to acces a certain IO Port to 
increase/decrease the backlight level of my lcd is broken after a 
restore and doesnt send what it should ...
the developers of swsusp mentioned somewhere that there is a problem 
with broken terminal enviroments ...  anyhow

As far as now i am very pleased of what i see and it proves that OPEN 
SOURCE is still THE best way to get a good relation between CONTROL , 
COST and EFFORT !!

Keep up going and greetings to LINUS

Cheers Rob
-- 
_____________________________________
*Robert Woerle
**Technical Support | Linux
PaceBlade Technology Europe SA*
phone: +49 89 552 99935
fax: +49 89 552 99910
mobile: +49 179 474 45 27
email: robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: http://www.paceblade.com
_____________________________________







-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
