From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: lid state reported incorrectly; no ac events
Date: Wed, 23 Jul 2003 07:28:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307230728.31830.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, folks.

I have a Presario 900 laptop (I mention this in case the problem is 
specific to this model) and acpi interface appears to be reporting 
lid state incorretly: /proc/acpi/button/lid/LID/state says "state: 
closed" when lid is open and "state: open" when it is closed. Is it 
supposed to be like that?

I figured it comes from this place in drivers/acpi/button.c :

-----------------------
        
status=acpi_evaluate_integer(button->handle,"_LID",NULL,&state);
        if (ACPI_FAILURE(status)){
            p += sprintf(p, "state:      unsupported\n");
        }
        else{
            p += sprintf(p, "state:      %s\n", (state ? "open" :
"closed"));
        }
-----------------------

so state!=0 is interpreted as "open" whereas (it seems to me) since it 
is state of the _button_ (not the lid itself), it would be logical 
that state!=0 means that button is depressed (which means that the 
lid is closed). Am I making sense here? 
The only question here is what happens on other laptops or whether 
this is specified in ACPI docs somewhere?

The other question (issue?) I have is that in acpid log I only see 
messages for power and lid buttons and the battery (BTW when exactly 
do these fire? is it only when battery is critically low/fully 
charged or more often?). I expected to see AC connected/disconnected 
events and maybe thermal events too. When I compile with acpi 
debugging output I do see messages on ac plugging/unplugging so I 
assume it gets detected correctly, but event does not fire. Is that 
ok or is it a bug?

And the last one. Is there any reason why events when lid is closed 
and opened are identical. It would be more convinient if they were 
distinct. Of course one can always read lid state on event, but 
having event provide that info would be handy.

I hope my questions make sense.

Fedor.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
