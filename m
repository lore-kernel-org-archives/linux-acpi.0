From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: Re: Fixing broken DSDT - code suggestions for comment please!
Date: Mon, 17 May 2004 12:27:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40A8A18D.3040104@mesias.co.uk>
References: <40A73460.2070407@mesias.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40A73460.2070407-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again ACPI list,

I'm really hoping someone with DSDT hacking experience will cast an eye 
over the DSDT patches I gave before (dated 16/05/04 10:29).

I also see some messages at boot time:

ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.QSB_.WQS_] (Node 19f1a5bc), AE_NOT_EXIST
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.QSB_.WENR] (Node 19f1a77c), AE_NOT_EXIST
     ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0._INI] 
(Node 19f2123c), AE_NOT_EXIST
ACPI: Interpreter enabled

Any suggestions how I can fix or work around these? Or any more links to 
useful guides to hacking the DSDT?

Thanks in advance,

-Cam

-- 
camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org                                                 <--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
