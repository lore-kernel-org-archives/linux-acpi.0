From: takawata-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org
Subject: Re: Problem building pacpidump
Date: Sun, 04 Dec 2005 21:12:32 +0900
Message-ID: <200512041212.jB4CCWDC091502@ns.init-main.com>
References: <4391A792.2070901@alu.uclm.es>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Sat, 03 Dec 2005 15:11:30 +0100."
             <4391A792.2070901-HUQOYnP6kuoxAGwisGp4zA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jose Luis Segura Lucas <JoseL.Segura-HUQOYnP6kuoxAGwisGp4zA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <4391A792.2070901-HUQOYnP6kuoxAGwisGp4zA@public.gmane.org>, Jose Luis Segura Lucas wrote:
>Hello!
>
>First, excuse me for my bad english, I will write with many ortographic 
>errors, sorry.
>
>I have a Acer Travelmate 2702 WLMi, and with any distribution (Ubuntu 
>and Debian I test) I have ACPI support.
>I began to read at acpi.sourceforge.net and follow the Emma Jane Hogbin 
>howto, but I finished reading how to fix the DSDT on this other howto: 
>http://www.cpqlinux.com/acpi-howto.html#basic_steps.
>
>I tried to build pacpidump  for myself on my Debian Sarge, changing the 
>comment line on the Makefile, but when I compile with make it give me 
>errors that I can't understand. Do you know some howto to compile 
>correctly the pacpidump?

Use iasl in Intel ACPI tool with -d option.






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
